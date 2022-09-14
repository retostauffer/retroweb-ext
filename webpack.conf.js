
const path = require('path');

module.exports = {
    mode: "development", // or production
    entry: "./node_modules/jquery/src/jquery.js",
    output: {
        path: path.resolve(__dirname, "js"),
        filename: "rotorweb-bundle.min.js"
    }
};
