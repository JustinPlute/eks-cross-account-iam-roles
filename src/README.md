# Node.js S3 Sample Application

This sample application connects to Amazon's [Simple Storage Service (S3)](http://aws.amazon.com/s3) and is used to demonstrate assuming a Cross-Account IAM role from an EKS cluster in another AWS account.

Instead of having the Application contain logic to upload and process file chunks, the presigned URL returned to the client can be used to upload to the AWS S3 service directly.

Check out this [article](https://advancedweb.hu/2018/10/30/s3_signed_urls/) to learn more about presigned URLs.

## Use Case

This boilerplate project is an alternative way to upload and fetch files from an S3 bucket. For client usage, no AWS SDK or AWS CLI is required.

## How it works

There are two [GET] endpoints exposed.

### [GET] `/signed-url-get`

```bash
$ curl https://{YOUR_DOMAIN}.com/signed-url-get?key=<key>
```

And response:

```json
{
  "url": "https://myBucket.s3.amazonaws.com/myKey?AWSAccessKeyId=ACCESS_KEY_ID&Expires=1457632663&Signature=Dhgp40j84yfjBS5v5qSNE4Q6l6U%3D"
}
```

You can then download the file from the presigned URL returned.

```bash
$ curl https://myBucket.s3.amazonaws.com/myKey?AWSAccessKeyId=ACCESS_KEY_ID&Expires=1457632663&Signature=Dhgp40j84yfjBS5v5qSNE4Q6l6U%3D
```

###  [GET] `/signed-url-put`

```bash
$ curl https://{YOUR_DOMAIN}.com/signed-url-put?key=<key>
```

And response:

```json
{
  "url": "https://myBucket.s3.amazonaws.com/myKey?AWSAccessKeyId=ACCESS_KEY_ID&Expires=1457632663&Signature=Dhgp40j84yfjBS5v5qSNE4Q6l6U%3D"
}
```

And to upload files with CURL using the presigned URL returned:

```bash
$ curl -k -X PUT -T "someFile" "https://myBucket.s3.amazonaws.com/myKey?AWSAccessKeyId=ACCESS_KEY_ID&Expires=1457632663&Signature=Dhgp40j84yfjBS5v5qSNE4Q6l6U%3D"
```

## Running the S3 sample

All you need to do is run it:

```bash
$ node server.js
```

### Building Your Image

Go to the directory that has the `Dockerfile` and run the following command to build the Docker image. The `-t` flag lets you tag your image so it's easier to find later using the docker images command:

```bash
$ docker build -t <your username>/node-s3-app .
```

Your image will now be listed by Docker:

```bash
$ docker images

# Example
REPOSITORY                      TAG        ID              CREATED
<your username>/node-s3-app    latest     d64d3505b0d2    1 minute ago
```

## Run the image

Running your image with `-d` runs the container in detached mode, leaving the container running in the background. The `-p` flag redirects a public port to a private port inside the container. Run the image you previously built:

```bash
docker run -p 49160:8080 -d <your username>/node-s3-app
```


Print the output of your app:

```bash
# Get container ID
$ docker ps

# Print app output
$ docker logs <container id>
```

# Example

Running on http://localhost:8080

If you need to go inside the container you can use the exec command:

# Enter the container

```bash
$ docker exec -it <container id> /bin/bash
```

## Test

To test your app, get the port of your app that Docker mapped:

```bash
$ docker ps

# Example
ID            IMAGE                                COMMAND    ...   PORTS
ecce33b30ebf  <your username>/node-s3-app:latest  npm start  ...   49160->8080
```

In the example above, Docker mapped the 8080 port inside of the container to the port 49160 on your machine.

Now you can call your app using curl (install if needed via: sudo apt-get install curl):

```bash
$ curl -i localhost:49160

HTTP/1.1 200 OK
X-Powered-By: Express
Content-Type: text/html; charset=utf-8
Content-Length: 12
ETag: W/"c-M6tWOb/Y57lesdjQuHeB1P/qTV0"
Date: Mon, 13 Nov 2017 20:53:59 GMT
Connection: keep-alive

Hello world
```