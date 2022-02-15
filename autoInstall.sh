# #!/bin/bash
set -Ceu

# argment receive
needSass=true
needTS=true

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

# node
echo '16' > $execDir/.nvmrc
sh ~/.nvm/nvm.sh use

# cp files:
cp $scriptDir/.gitignore $execDir
cp $scriptDir/package.json $execDir
cp $scriptDir/default.code-workspace $execDir/$projectName.code-workspace
cp $scriptDir/webpack.config.js $execDir

# cp src dir:
cp -r $scriptDir/src/ $execDir

# index.js か index.ts を削除
if [[ ${needTS} = true ]]; then
    rm $execDir/src/script/index.js
  else
    rm $execDir/src/script/index.ts
fi

# 構造表示
tree

# install するパッケージ名の配列を生成
packages=()
packages+=(webpack)
packages+=(webpack-cli)
packages+=(webpack-dev-server)
packages+=(html-webpack-plugin)
packages+=(terser-webpack-plugin)
packages+=(css-loader)
packages+=(mini-css-extract-plugin)
packages+=(sass)
packages+=(sass-loader)

if [[ ${needTS} = true ]]; then
    sed -e "s?// tsLoaderSetting,?tsLoaderSetting,?g" -e "s?index.js?index.ts?g" $execDir/webpack.config.js > $execDir/webpack.tmp.js
    rm $execDir/webpack.config.js
    mv $execDir/webpack.tmp.js $execDir/webpack.config.js
    cp $scriptDir/tsconfig.json $execDir
    # packages 配列にTS用のパッケージをpush
    packages+=(typescript)
    packages+=(ts-loader)
fi

echo "execution: npm i -D ${packages[@]}"
npm i -D ${packages[@]}
npm ls

# git
git init
echo "# ${projectName}"
git add -A .
git commit -m "first commit"
# git branch -M main

# Other commands that require manual input 
echo -e "\n** The following are the commands that require manual input. **"
echo "git remote add origin git@github.com:keijiek/${projectName}.git"
echo "git push -u origin main"
echo "nvm install"
