const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');

// npm script's argument '--mode_env' is received here.
const isProduction = process.env.NODE_ENV == 'production';

// web-dev-server setting
const webDevServerSetting = {
  open: true,
  host: 'localhost',
};

// Plugins ############
// Plugin: MiniCssExtractPlugin setting
const MiniCssExtractPluginSetting = new MiniCssExtractPlugin({
  filename: './css/style.css',
});

// Plugin: HtmlWebpackplugin setting
const HtmlWebpackPluginSetting = new HtmlWebpackPlugin({
  template: './src/index.html',
});

// Modules ############
// Module: ts-loader
const tsLoaderSetting = {
  test: /\.tsx?$/,
  use: 'ts-loader',
  exclude: /node_modules/,
},

// Module: babel-loader
const babelLoaderSetting = {
  test: /\.(js|jsx)$/i,
  loader: 'babel-loader',
}

// Module: sass-loader css-loader extractPlugin-loaders setting, MiniCssExtractPlugin is necessary.
const sassLoadersSetting = {
  test: /\.s[ac]ss$/i,
  include: path.resolve(__dirname, 'src', 'sass'),
  use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader'],
}

// Module: assetModule
const assetModuleSetting = {
  test: /\.(eot|svg|ttf|woff|woff2|png|jpg|gif)$/i,
  type: 'asset/resource',
}

// common config ############
const config = {
  entry: path.resolve(__dirname, 'src', 'index.js'),//'./src/index.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
  },
  devServer: webDevServerSetting,
  plugins: [
    HtmlWebpackPluginSetting,
    MiniCssExtractPluginSetting,
  ],
  module: {
    rules: [
      // tsLoaderSetting,
      // babelLoaderSetting,
      sassLoadersSetting,
      assetModuleSetting,
    ],
  },
};

// TerserPlugin setting, for Production, use to delete unnecessary text file and logs.
const terserPluginSetting = new TerserPlugin({
  extractComments: false,// prevent to output unnecessary text files. default is True
  terserOptions: {
    compress: {
      drop_console: true,// delete console.log
    },
  },
});
// optimization setting
const optimizationSetting = {
  minimize: true,
  minimizer: [terserPluginSetting],
}

// finaly, setting is branched by whether Production or Development.
module.exports = () => {
if (isProduction) {
  config.mode = 'production';
  config.optimization = optimizationSetting;
  // you can add another settings for Production.
} else {
  config.mode = 'development';
  config.devtool = 'eval-cheap-module-source-map';// sourcemap. recommended values are: eval, eval-source-map
  // you can add another settings for Development.
}
  return config;
};
