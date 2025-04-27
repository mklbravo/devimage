#!/bin/bash

if [ -z "$NVIM_LANGUAGES" ]; then
  echo "Skipping Neovim language configurations..."
  exit 0
fi

# Convert coma separated string to array
IFS=',' read -r -a NVIM_LANGUAGES_ARRAY <<<"$NVIM_LANGUAGES"

for language in ${NVIM_LANGUAGES_ARRAY[@]}; do
  echo "Installing $language language server..."
  nvim --headless +"LanguageEnable $language" +"qall"
done
