
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
                test: /\.(svg|eot|woff|woff2|ttf)$/,
                type: 'asset/inline'
            },
            {
                test: /\.scss$/,
                loader: 'sass-loader'
            },
        ]
    }
};

