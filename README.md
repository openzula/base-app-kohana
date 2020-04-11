# openzula/base-app-kohana
This Docker image is most likely not useful to anybody except for us! It provides a base image to serve our legacy
Kohana applications using PHP-FPM.

## Prerequisites
There are no prerequisites.

## Deployment
This image is intended to be used as a base only and not to be ran directly. Instead you should create and build your
own image using the following structure:

```
./build
-- aws
---- app.dockerfile
./src
-- application
-- modules
-- ...
```

Your own Dockerfile could be a simple one line, or it could contain various additional instructions. At the very least
please use the following:

```dockerfile
FROM openzula/base-app-kohana:latest
```

Then build the image by running the following command in the top most directly of your project:

```shell script
docker build -f build/aws/app.dockerfile -t example/app .
```

## Configuration
There are no environmental variables to configure this image.

## License
This project is licensed under the BSD 3-clause license - see [LICENSE.md](LICENSE.md) file for details.
