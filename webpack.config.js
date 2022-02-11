const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');

const isProduction = process.env.NODE_ENV == 'production';

// web-dev-server setting, for serve
const devServerSetting = {
  open: true,
  host: 'localhost',
};

const config = {
  entry: path.resolve(__dirname, 'src', 'index.js'),//'./src/index.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
  },
  devServer: devServerSetting,
  plugins: [
    new HtmlWebpackPlugin({
      template: 'index.html',
    }),
    new MiniCssExtractPlugin({
      filename: './css/style.css',
    }),
  ],
  module: {
    rules: [
      // for Babel
      {
        test: /\.(js|jsx)$/i,
        loader: 'babel-loader',
      },
      // for Sass
      {
        test: /\.s[ac]ss$/i,
        include: path.resolve(__dirname, 'src', 'sass'),
        use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader'],
      },
      // for assetModule
      {
        test: /\.(eot|svg|ttf|woff|woff2|png|jpg|gif)$/i,
        type: 'asset',
      },
    ],
  },
};


// TerserPlugin setting, for Production
const terserPlugin = new TerserPlugin({
  extractComments: false,// ライセンスやヘルプなどのテキストファイルが生成されることを防ぐ
  terserOptions: {
    compress: {
      drop_console: true,// console.logを消す
    },
  },
});

module.exports = () => {
if (isProduction) {
  config.mode = 'production';
  // production 用の設定追加
  config.optimization = {
    minimize: true,
    minimizer: [terserPlugin],
  };
} else {
  config.mode = 'development';
  // development 用の設定追加
  config.devtool = 'eval-cheap-module-source-map';// values recommended: eval, eval-source-map
}
  return config;
};