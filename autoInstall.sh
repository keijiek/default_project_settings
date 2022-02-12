# #!/bin/sh
# npm i -D webpack webpack-cli webpack-dev-server html-webpack-plugin mini-css-extract-plugin terser-webpack-plugin
current=`pwd`

echo "./package.json"
echo "$current/package.json"

for arg in "$@"
  do
    case $arg in
      # ts) npm i -D typescript ts-loader;;
      ts) echo 'npm i -D typescript ts-loader';;
    esac
  done
