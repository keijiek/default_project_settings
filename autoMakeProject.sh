# #!/bin/sh

echo $1

echo 'lts/galliun' > .nvmrc
echo -e "node_modules/\ndist/" > .gitignore

# package.json
echo -e '{
  "scripts": {
    "dev": "webpack --mode=development",
    "prod": "webpack --mode=production --node-env=production",
    "serve": "webpack serve"
  }
}' > ./package.json

# webpack.config.json
echo -e '{
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');

const isProduction = process.env.NODE_ENV == 'production';

const config = {
    entry: './src/index.js',
    output: {
        path: path.resolve(__dirname, 'dist'),
    },
    devServer: {
        open: true,
        host: 'localhost',
    },
    plugins: [
        new HtmlWebpackPlugin({
            template: 'index.html',
        }),

        new MiniCssExtractPlugin(),

        // Add your plugins here
        // Learn more about plugins from https://webpack.js.org/configuration/plugins/
    ],
    module: {
        rules: [
            {
                test: /\.(js|jsx)$/i,
                loader: 'babel-loader',
            },
            {
                test: /\.s[ac]ss$/i,
                use: [stylesHandler, 'css-loader', 'sass-loader'],
            },
            {
                test: /\.(eot|svg|ttf|woff|woff2|png|jpg|gif)$/i,
                type: 'asset',
            },

            // Add your rules for custom modules here
            // Learn more about loaders from https://webpack.js.org/loaders/
        ],
    },
};
}
' > ./webpack.config.json

# npm i -D webpack webpack-cli webpack-dev-server sass sass-loader css-loader html-webpack-plugin mini-css-extract-plugin terser-webpack-plugin