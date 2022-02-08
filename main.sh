# #!/bin/sh

function git_setting() {
  echo 'node_modules/' > .gitignore
  git init
  git add .
  git commit -m 'first commit'
  git branch -M main
}

function nvm() {
  echo "lts/gallium" > .nvmrc
  nvm install
}

function packageJson() {
  npm init -y
}


