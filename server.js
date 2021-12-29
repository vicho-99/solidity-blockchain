const express = require('express');
const path = require('path');
const cors = require('cors')
const app = express();
const PORT = 3000;
app.use(cors())
app.use('/contract', express.static(path.join(__dirname, '/build/contracts')))
app.listen(PORT);