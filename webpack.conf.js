
const path = require('path');

module.exports = {
    entry: {
        'rotorweb': path.resolve(__dirname, "./src/rotorweb.js")
    },
    output: {
        path: path.resolve(__dirname, "dist"),
        filename: "[name]-bundle.min.js"
    },
    //module: {
    //    rules: [
    //        {
    //            test: /\.css$/,
    //            use: ["style-loader", "css-loader"]
    //        },
    //        {
    //            test: /\.scss$/,
    //            use: ["style-loader", "css-loader", "scss-loader"]
    //        },
    //        {
    //            test: /\.(woff|woff2|ttf)(\?[a-z0-9=.]+)?$/,
    //            use: [{
    //                loader: "file-loader",
    //                options: {
    //                    name: "[name].[ext]",
    //                    path: path.resolve(__dirname, "fonts"),
    //                    outputPath: "../fonts" // not really used but required for processing
    //                }
    //            }]
    //        }
    //    ]
    //}

};

