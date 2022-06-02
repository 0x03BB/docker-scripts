#!/bin/ash

# Check if an argument was provided.
if [[ -z $1 ]]; then
    echo 'Error: Provide the name of a volume as the first argument to this script.'
    exit 1
fi

# Check if the volume exists.
if ! docker volume inspect $1 1> /dev/null; then
    exit 1
fi

docker run --rm -v $1:/$1.volume -v $(pwd):/host alpine tar czf /host/$1.tar.gz /$1.volume
