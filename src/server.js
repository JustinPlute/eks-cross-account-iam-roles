/*
 * Copyright (c) 2020 Justin Plute. All Rights Reserved.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
**/

// Load the AWS SDK and Express.js Web Framework
const express = require('express');

const s3 = require('./s3.js');

// Constants
const S3_BUCKET_NAME = process.env.S3_BUCKET_NAME;
const PORT = process.env.PORT || 8080;
const HOST = process.env.HOST || '0.0.0.0';

// App
const app = express();

app.use(function (err, req, res, next) {
  console.error(err.stack)
  res.status(500).send('Something broke!')
});

// Assync Middleware
const asyncMiddleware = fn =>
  (req, res, next) => {
    Promise.resolve(fn(req, res, next))
      .catch(next);
  };
  
app.get('/', (req, res) => {
  res.send('Hello World');
});

app.get('/signed-url-get', asyncMiddleware(async (req, res) => {
  const params = { Bucket: S3_BUCKET_NAME, Key: req.query.key };
  const response = await s3.signedUrlGet(params);
  return res.json(response);
}));

app.get('/signed-url-put', asyncMiddleware(async (req, res) => {
  const params = { Bucket: S3_BUCKET_NAME, Key: req.query.key,  };
  const response = await s3.signedUrlPut(params);
  return res.json(response);
}));

app.listen(PORT, HOST);

console.log(`Running on http://${HOST}:${PORT}`);