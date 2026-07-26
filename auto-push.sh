#!/bin/bash

cd ~/dotfiles

# Check internet first
if ! ping -c 1 github.com &>/dev/null; then
    echo "No internet at $(date)" >> ~/dotfiles/push.log
    exit 1
fi

# Check if there are any changes
if [[ -n $(git status --porcelain) ]]; then
    git add .
    git commit -m "auto-update: $(date '+%Y-%m-%d %H:%M')"
    git push origin main
    echo "✅ Pushed at $(date)" >> ~/dotfiles/push.log
else
    echo "No changes at $(date)" >> ~/dotfiles/push.log
fi
