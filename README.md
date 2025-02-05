 
# GIC (Git Commit Automation Script) - Command Line Tool

## Overview

GIC is a powerful, user-friendly Git commit automation tool that simplifies and customizes your Git commit process. With GIC, you can easily automate Git commits with detailed messages, custom tags, and much more. It enhances the commit workflow, especially for teams working on feature branches or managing multiple repositories.

## Features

- **Custom Commit Messages**: Add a custom commit message or use the default tags for changes.
- **Commit Preview**: See a preview of your commit message before applying it.
- **Tag Customization**: Customize the commit tags (`Updated`, `Added`, `Removed`, etc.) with your own labels.
- **Dry Run Mode**: Preview commits without actually committing any changes.
- **Cross-platform Support**: Fully supports Linux, macOS, and Windows.
- **Integrates with Git**: Automates Git commands such as `git add`, `git commit`, and `git push`.

## Installation

### Prerequisites

Ensure you have [Node.js](https://nodejs.org/) and [npm](https://www.npmjs.com/) installed on your system.

### Global Installation

To install `gic` globally, run:

```bash
npm install -g @souvik666/gic
```

This will allow you to run the `gic` command globally from anywhere in your terminal.

### Local Installation

If you want to install `gic` for a specific project, run:

```bash
npm install @souvik666/gic --save-dev
```

Then, you can use `npx` to execute the command without needing to install it globally:

```bash
npx gic --help
```

## Usage

### Basic Command

To use GIC, run the following command to see the help options:

```bash
gic --help
```

### Commit Changes with Custom Message

To make a commit with a custom message:

```bash
gic -m "Custom commit message"
```

This will add all the changes, generate a commit message with the custom content at the top, and then display a preview of the commit before applying it.

### Dry Run Mode

You can perform a "dry run" to preview the commit without actually committing:

```bash
gic --dry-run
```

This will show the commit preview without applying any changes.

### Default Commit Message Tags

By default, GIC uses the following commit message tags:

- `🔧 UPDATED` for modified files.
- `✨ ADDED` for new files.
- `🗑️ REMOVED` for deleted files.
- `📄 NEW` for new, untracked files.
- `🔄 OTHER` for other changes.

These tags can be customized in the `gic.config.json` file.

## Configuration

### Customizing Commit Tags

To customize the commit message tags (e.g., change `🔧 UPDATED` to `🔨 CHANGED`), create a `gic.config.json` file in your project root:

```json
{
  "modified": "🔨 CHANGED",
  "added": "✨ NEW FEATURE",
  "deleted": "🗑️ DELETED",
  "new": "📄 NEW FILE",
  "other": "🔄 ALTERED"
}
```

GIC will automatically load the tags from this configuration file if it exists.

## Example Commit Message

Here’s an example of a generated commit message:

```bash
(#123) [2025-02-05 14:30:00] Fixed login issue
✨ ADDED: src/components/Login.js
🔧 UPDATED: src/api/auth.js
🗑️ REMOVED: src/utils/deprecatedFunction.js
```

### Detailed Breakdown:
- The **issue number** (`#123`) is automatically detected from the branch name.
- The **commit message timestamp** (`2025-02-05 14:30:00`) is dynamically added.
- Each change is tagged with customizable icons like `✨ ADDED`, `🔧 UPDATED`, etc.

## Advanced Options

- **Dry Run**: Preview your changes before actually committing them:

  ```bash
  gic --dry-run
  ```

- **Custom Message**: Add a custom commit message:

  ```bash
  gic -m "Fixed login issue"
  ```

- **No Changes Detected**: If there are no changes to commit, the tool will display:

  ```bash
  No changes to commit.
  ```

## Troubleshooting

### Common Errors

- **Permission Denied**: If you're unable to install the package, ensure you're running with the appropriate permissions or use `sudo` for global installations.
- **Command Not Found**: Ensure that `gic.sh` is marked as executable and properly linked in the `bin` section of your `package.json`.

```bash
chmod +x gic.sh
```

### FAQ

#### 1. How do I install GIC globally?

Run the following command to install GIC globally:

```bash
npm install -g @souvik666/gic
```

#### 2. Can I customize the commit tags?

Yes, you can customize the commit tags by modifying the `gic.config.json` file in your project.

#### 3. How do I test my changes before committing?

Use the `--dry-run` option to preview your commit before it’s made:

```bash
gic --dry-run
```

## Contributing

We welcome contributions to GIC! If you would like to contribute, please fork the repository and submit a pull request. Make sure to follow the code style and write tests for new features.

## License

GIC is licensed under the [ISC License](https://opensource.org/licenses/ISC).

## Related Tools

- [Git](https://git-scm.com/): A distributed version control system.
- [Node.js](https://nodejs.org/): JavaScript runtime built on Chrome's V8 engine.
- [npm](https://www.npmjs.com/): Node.js package manager.



 