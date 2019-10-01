```
docker run --rm -p 4000:4000 --volume="$PWD:/srv/jekyll" --volume="$PWD/vendor/bundle:/usr/local/bundle" -it jekyll/jekyll:3.8 bundle install
docker run --rm -p 4000:4000 --volume="$PWD:/srv/jekyll" --volume="$PWD/vendor/bundle:/usr/local/bundle" -it jekyll/jekyll:3.8 jekyll build
docker run --rm -p 4000:4000 --volume="$PWD:/srv/jekyll" --volume="$PWD/vendor/bundle:/usr/local/bundle" -it jekyll/jekyll:3.8 jekyll serve
```
