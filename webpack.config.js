var path = require('path')
var ExtractTextPlugin = require('extract-text-webpack-plugin')
var HtmlWebpackPlugin = require('html-webpack-plugin')

module.exports = {
  entry: ['./src/index.js', './src/scss/main.scss'],

  output: {
    path: path.resolve(__dirname + '/dist'),
    filename: '[name].[chunkhash].js',
    publicPath: '/'
  },

  module: {
    rules: [
      {
        test: /\.(scss|css)$/,
        loader: ExtractTextPlugin.extract(['css-loader?{discardComments:{removeAll:true}}', 'sass-loader'])
      },
      {
        test: /\.html$/,
        exclude: /node_modules/,
        loader: 'file-loader?name=[name].[ext]'
      },
      {
        test: /\.png$/,
        exclude: /node_modules/,
        loader: 'file-loader?name=img/[name].[ext]'
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-webpack-loader?verbose=true&warn=true'
      },
      {
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'url-loader?limit=10000&mimetype=application/font-woff'
      },
      {
        test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'file-loader'
      }
    ],

    noParse: /\.elm$/
  },

  plugins: [
    new HtmlWebpackPlugin({
      title: 'Data Stewardship Wizard'
    }),
    new ExtractTextPlugin({
      filename: '[name].[chunkhash].css',
      allChunks: true
    })
  ],

  devServer: {
    inline: true,
    stats: { colors: true },
    historyApiFallback: true
  }
}
