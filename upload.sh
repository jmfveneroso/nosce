# #!/bin/bash

docker run --rm -p 4000:4000 --volume="$PWD:/srv/jekyll" --volume="$PWD/vendor/bundle:/usr/local/bundle" -it jekyll/jekyll:3.8 jekyll build
cd ./_site

aws s3 cp . s3://www.joaoveneroso.com/ --recursive

for filename in *.html; do
    if [ $filename != "index.html" ];
    then
        original="$filename"

        # Get the filename without the path/extension
        filename=$(basename "$filename")
        extension="${filename##*.}"
        filename="${filename%.*}"

        # Move it
        sudo mv $original $filename
        aws s3 cp $filename s3://www.joaoveneroso.com/ --content-type "text/html"
    fi
done
