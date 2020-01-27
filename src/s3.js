/*
 * AWS S3 Boilerplate API -- https://gitlab.nordstrom.com/public-cloud/aws-s3-boilerplate-api
 * Authored by Public Cloud <cloudengineering@nordstrom.com>
 */

// ----------------------
// Import AWS SDK
const AWS = require('aws-sdk')

// Constructs an S3 service interface object
const s3 = new AWS.S3()

// Initialize Expiration Constants
// 5 Minute expirations are used; otherwise, defaults to 15 minutes (900)
const UPLOAD_EXPIRATION = 60 * 5
const GET_EXPIRATION = 60 * 5

// ----------------------

/**
 * function: signedUrlGet
 * This returns a temporary signed URL to fetch an S3 object
 *
 * @param {String} key Querystring parameter of S3 keypath
 *
 * @example  {domain_name}/signed-url-get?key=<my_key>
 *
 * @returns {JSON} Returns JSON object of presigned URL for get S3 object
 * { url: "https://myBucket.s3.amazonaws.com/myKey?AWSAccessKeyId=ACCESS_KEY_ID&Expires=1457632663&Signature=Dhgp40j84yfjBS5v5qSNE4Q6l6U%3D" }
 */
exports.signedUrlGet = (bucket, key) => {
  const params = {
    Bucket: bucket,
    Key: key,
    Expires: GET_EXPIRATION,
  }

  // create signed URL with getObject permissions
  const url = s3.getSignedUrl('getObject', params)
  
  return {
    "statusCode": 200,
    "body": JSON.stringify({ url }),
  }
}

/**
 * function: signedUrlPut
 * This returns a temporary signed URL to put an S3 object
 * Instead of uploading files via API Gateway + Lambda and dealing with file chunks,
 * we send the client a presigned URL with a short expiration time to upload to S3 directly
 *
 * @param {String} key Querystring parameter of S3 keypath
 *
 * @example {domain_name}/signed-url-put?key=<my_key>
 *
 * @returns {JSON} Returns JSON object of presigned URL for put S3 object
 * // returns { url: "https://myBucket.s3.amazonaws.com/myKey?AWSAccessKeyId=ACCESS_KEY_ID&Expires=1457632663&Signature=Dhgp40j84yfjBS5v5qSNE4Q6l6U%3D" }
 */
exports.signedUrlPut = (bucket, key) => {
  const params = {
    Bucket: bucket,
    Key: key,
    Expires: UPLOAD_EXPIRATION,
  }

  // create signed URL with putObject permissions
  const url = s3.getSignedUrl('putObject', params)

  return {
    "statusCode": 200,
    "body": JSON.stringify({ url }),
  }
}