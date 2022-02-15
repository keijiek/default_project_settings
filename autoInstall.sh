# #!/bin/bash
set -Ceu

# paths
readonly execDir="$(pwd)"
readonly projectName="$(basename $execDir)"
readonly scriptDir="$(dirname "$(readlink -f "$0")")"

# package.json が存在するなら、すでに開発環境があるとみなして実行停止
if [[ -e package.json ]] ; then
  echo 'Warning: package.json already exists. Therefore, this script will stop.'
  exit 1;
fi

# node_modules ディレクトリが存在すれば、削除
if [[ -e node_modules ]] ; then
  rm -rf node_modules
  echo '"node_modules/" dir is removed.'
fi

# cp files: .gitignore, package.json .code-workspace
cp $scriptDir/.gitignore $execDir
cp $scriptDir/package.json $execDir
cp $scriptDir/default.code-workspace $execDir/$projectName.code-workspace
cp $scriptDir/webpack.config.js $execDir

# argment receive
needSass=true
needTS=true

# basic packages
npm i -D webpack webpack-cli webpack-dev-server
npm i -D html-webpack-plugin terser-webpack-plugin

# css packages
npm i -D css-loader mini-css-extract-plugin

# npm i -D webpack webpack-cli webpack-dev-server
# npm i -D html-webpack-plugin terser-webpack-plugin
if [[ ${needSass} = true ]]; then
  echo 'you use sass.'
  npm i -D sass sass-loader
  else
  echo 'no sass'
fi

if [[ ${needTS} = true ]]; then
  echo 'you use TypeScript.'
  sed -e "s?// tsLoaderSetting,?tsLoaderSetting,?" $execDir/webpack.config.js
  cp $scriptDir/tsconfig.json $execDir
  npm i -D typescript ts-loader
fi
