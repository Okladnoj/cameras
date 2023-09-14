#!/bin/bash

# Run command: [bash pub_publish.sh]

# This script is intended for publishing your plugin on pub.dev.
# Before publishing, the script performs code analysis, tests, package verification, and code formatting.

set -e # Stop the script at the first error

# Code analysis
echo -e "\033[32mAnalyzing the code...\033[0m"
flutter analyze


# Dry run to verify the package before publishing
echo -e "\033[32mVerifying package for publishing (dry run)...\033[0m"
flutter pub publish --dry-run

# Format the code
echo -e "\033[32mFormatting the code...\033[0m"
dart format .

# Publishing the package
echo -e "\033[32mPublishing the package...\033[0m"
flutter pub publish

echo -e "\033[32mPublication complete!\033[0m"
