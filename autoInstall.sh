# #!/bin/bash
set -Ceu

# paths
readonly execDir=$(pwd)
readonly projectName=$(basename $execDir)
readonly scriptDir=$(dirname $0)

# package.json が存在するなら開発環境があるとみなして停止
if [[ -e package.json ]] ; then
  echo 'Warning: package.json already exists. Therefore, the script will stop. '
  exit 1;
fi

if [[ -e node_modules ]] ; then
  rm -rf node_modules
fi

# cp files: .gitignore, package.json .code-workspace
cp $scriptDir/.gitignore $execDir
cp $scriptDir/package.json $execDir
cp $scriptDir/default.code-workspace $execDir/$projectName.code-workspace
# cp $scriptDir/webpack.config.js $execDir

sed -e "s?// typescriptSetting,?typescriptSetting,?" webpack.config.js > webpack.config.js

# 
# argment receive
needSass=true
needTS=true


# npm i -D webpack webpack-cli webpack-dev-server
# npm i -D html-webpack-plugin terser-webpack-plugin
if [[ ${needSass} = true ]]; then
  echo 'with sass'
  else
  echo 'no sass'
fi

function cssInstalation() {
  npm i -D css-loader mini-css-extract-plugin
  npm i -D sass sass-loader
}

function installBasics() {
  npm i -D webpack webpack-cli webpack-dev-server
  npm i -D html-webpack-plugin terser-webpack-plugin
}

function installTypeScript() {
  npm i -D typescript ts-loader
}


# installBasics

# echo 'do you use TypeScript?'
# select i in yes no
#   do
#     case $i in
#       yes) installTypeScript; break ;;
#       no) break;;
#     esac
#   done


# current=`pwd`
# scriptDir=$(dirname $0)

# node $scriptDir/nodejs/makeProject.js
# if [ $? -ne 0 ]
#   then
#     exit '異常終了' 0
# fi

