
const path = require('path');

module.exports = {
    entry: {
        'rotorweb': path.resolve(__dirname, "./src/js/rotorweb.js")
    },
    output: {
        path: path.resolve(__dirname, "dist"),
        filename: "[name]-bundle.min.js"
    },
    module: {
        rules: [
            {
                test: /\.css$/,
                use: ["style-loader", "css-loader"]
            },
            {
                test: /\.(woff|woff2|ttf)(\?[a-z0-9=.]+)?$/,
                use: [{
                    loader: "file-loader",
                    options: {
                        name: "[name].[ext]",
                        path: path.resolve(__dirname, "dist"),
                        outputPath: "../fonts" // not really used but required for processing
                    }
                }]
            }
        ] // end rules
    },
    // Performance args to ensure not exceeding recommended file size (fonts)
    performance: {
        hints: false,
        maxEntrypointSize: 512000,
        maxAssetSize: 512000
    }


};

    // trash
    //        {
    //            test: /\.scss$/,
    //            use: ["style-loader", "css-loader", "scss-loader"]
    //        },
