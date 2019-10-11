#!/bin/bash

set -e

if [ "$#" -ne 1 ]; then
  echo "Wrong number of arguments."
  exit 1
fi

title=$1
name=$(echo "${title,,}" | sed -e 's/ /-/g')
filename=_posts/$(date +"%Y-%m-%d")-$name.md

echo $filename

if test -f "$filename"; then
  echo "$filename exist"
fi

cat << EOF > $filename
---
title: $title
description: New blog post.
header: $title
duration: 1 minute read
---

&nbsp;

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent 
ultricies lacinia euismod. Morbi id enim sapien. Quisque quis 
imperdiet quam, vitae consequat nunc. Nunc ultricies gravida urna 
et semper. Quisque vehicula aliquam magna, a finibus quam eleifend 
vitae. Suspendisse tristique est malesuada, auctor odio eu, feugiat 
nulla. Aliquam rhoncus mi vitae mi euismod vehicula. Vestibulum 
malesuada gravida ipsum eu imperdiet. Cras suscipit eleifend lectus 
id interdum. Nunc tristique porta enim, ultricies vulputate metus 
pulvinar eget.

EOF

echo "Created file $filename."

vim $filename
