docker build -t nosce .
docker run -d -p 8889:8888 -v $(pwd):/code --rm --user root nosce
