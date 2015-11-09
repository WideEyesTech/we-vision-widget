var express = require('express');
var app = express();

app.get('/')
app.listen('3000')
app.use(express.static(__dirname))
