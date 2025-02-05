#!/bin/bash

CONFIG_FILE="./gic.config.json"

# Detect OS
OS_TYPE=$(uname -s)

# Define colors (Works in Linux/macOS/Git Bash)
if [[ "$OS_TYPE" == "Linux" || "$OS_TYPE" == "Darwin" || "$OS_TYPE" == "MINGW"* || "$OS_TYPE" == "CYGWIN"* ]]; then
  GREEN="\e[32m"
  YELLOW="\e[33m"
  BLUE="\e[34m"
  RED="\e[31m"
  CYAN="\e[36m"
  RESET="\e[0m"
else
  GREEN=""
  YELLOW=""
  BLUE=""
  RED=""
  CYAN=""
  RESET=""
fi

# Default commit tags (Plain text for commit message)
MODIFIED_TAG="🔧 UPDATED"
ADDED_TAG="✨ ADDED"
DELETED_TAG="🗑️ REMOVED"
NEW_TAG="📄 NEW"
OTHER_TAG="🔄 OTHER"

# Load tags from config if the file exists
if [ -f "$CONFIG_FILE" ]; then
  MODIFIED_TAG=$(jq -r '.modified' "$CONFIG_FILE")
  ADDED_TAG=$(jq -r '.added' "$CONFIG_FILE")
  DELETED_TAG=$(jq -r '.deleted' "$CONFIG_FILE")
  NEW_TAG=$(jq -r '.new' "$CONFIG_FILE")
  OTHER_TAG=$(jq -r '.other' "$CONFIG_FILE")
fi

# Add all changes
git add .

# Check for changes
changes=$(git status --short)
if [ -z "$changes" ]; then
  echo -e "${YELLOW}No changes to commit.${RESET}"
  exit 0
fi

branch_name=$(git rev-parse --abbrev-ref HEAD)

# Extract issue number from the branch name (e.g., feature/issue-123 -> 123)
issue_number=$(echo "$branch_name" | grep -oE '[0-9]+')

commit_message_lines=()
commit_message_plain=()

while read -r line; do
  status=$(echo $line | awk '{print $1}')
  file=$(echo $line | awk '{$1=""; print $0}' | xargs) 

  case $status in
    M) 
      commit_message_lines+=("${GREEN}$MODIFIED_TAG: $file${RESET}")
      commit_message_plain+=("$MODIFIED_TAG: $file")
      ;;
    A) 
      commit_message_lines+=("${CYAN}$ADDED_TAG: $file${RESET}")
      commit_message_plain+=("$ADDED_TAG: $file")
      ;;
    D) 
      commit_message_lines+=("${RED}$DELETED_TAG: $file${RESET}")
      commit_message_plain+=("$DELETED_TAG: $file")
      ;;
    ??) 
      commit_message_lines+=("${BLUE}$NEW_TAG: $file${RESET}")
      commit_message_plain+=("$NEW_TAG: $file")
      ;;
    *) 
      commit_message_lines+=("${YELLOW}$OTHER_TAG: $file${RESET}")
      commit_message_plain+=("$OTHER_TAG: $file")
      ;;
  esac
done <<< "$changes"

date_time="$(date +'%Y-%m-%d %H:%M:%S')"

if [ -n "$issue_number" ]; then
  commit_message="(#$issue_number) [$date_time] ${commit_message_plain[0]}"
else
  commit_message="[$date_time] ${commit_message_plain[0]}"
fi

for ((i=1; i<${#commit_message_plain[@]}; i++)); do
  commit_message+="\n${commit_message_plain[i]}"
done

# Show colored commit preview but commit without colors
echo -e "\n${GREEN}Commit Preview:${RESET}"
for msg in "${commit_message_lines[@]}"; do
  echo -e "$msg"
done
echo ""

# Commit changes
git commit -m "$(echo -e "$commit_message")"
echo -e "${CYAN}Pushing to remote...${RESET}"
git push
echo -e "${GREEN}✅ Done!${RESET}"
