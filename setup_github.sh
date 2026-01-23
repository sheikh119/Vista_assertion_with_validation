#!/bin/bash
# Script to set up and push to GitHub repository "Fyp_Vista"

echo "🚀 Setting up GitHub repository 'Fyp_Vista'"
echo ""

# Check if remote already exists
if git remote | grep -q "^origin$"; then
    echo "⚠️  Remote 'origin' already exists. Removing it..."
    git remote remove origin
fi

# Get GitHub username (you can modify this)
read -p "Enter your GitHub username: " GITHUB_USERNAME

if [ -z "$GITHUB_USERNAME" ]; then
    echo "❌ GitHub username is required!"
    exit 1
fi

echo ""
echo "📝 Please create the repository 'Fyp_Vista' on GitHub:"
echo "   1. Go to https://github.com/new"
echo "   2. Repository name: Fyp_Vista"
echo "   3. Choose Public or Private"
echo "   4. DO NOT initialize with README, .gitignore, or license"
echo "   5. Click 'Create repository'"
echo ""
read -p "Press Enter after you've created the repository on GitHub..."

# Add remote
REPO_URL="https://github.com/${GITHUB_USERNAME}/Fyp_Vista.git"
echo ""
echo "🔗 Adding remote: $REPO_URL"
git remote add origin "$REPO_URL"

# Push to GitHub
echo ""
echo "📤 Pushing to GitHub..."
git branch -M main
git push -u origin main

echo ""
echo "✅ Done! Your repository is now at: https://github.com/${GITHUB_USERNAME}/Fyp_Vista"

