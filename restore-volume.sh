#!/bin/ash

# Check if an argument was provided.
if [[ -z $1 ]]; then
    echo 'Error: Provide the name of an archive as the first argument to this script.'
    exit 1
fi

# Check if the argument ends in ".tar.gz".
if [[ "${1: -7}" != .tar.gz ]]; then
    echo 'Error: A .tar.gz file is expected.'
    exit 1
fi

# Check if the file exists.
if [[ ! -f $1 ]]; then
    echo 'Error: File "'$1'" not found.'
    exit 1
fi

# Get the file name without ".tar.gz".
volume=${1:0: -7}
docker run --rm -v ${volume}:/${volume}.volume -v $(pwd):/host alpine ash -c "cd /${volume}.volume && tar xzf /host/$1 --strip-components 1"
