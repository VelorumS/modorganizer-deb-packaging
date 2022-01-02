#!/bin/bash

set -eu

tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' INT QUIT TERM EXIT

superdirname=modorganizer_super
superdir="$tmpdir"/"$superdirname"
mkdir "$superdir"
for repo in modorganizer cmake_common githubpp modorganizer-{archive,bsatk,esptk,game_fallout3,game_features,installer_manual,lootcli,uibase}; do
    destdir="$superdir"/${repo#modorganizer-}
    git clone --depth=1 https://github.com/ChipmunkV/"$repo".git "$destdir"
    rm -rf "$destdir"/.git
done

version=$(sed -nre 's|#define VER_FILEVERSION_STR "([0-9]+\.[0-9]+\.[0-9]+).*"|\1|p' "$superdir"/modorganizer/src/version.rc)

if [ -z "$version" ]; then
    echo 'ERROR: can not determine version' >&2
    exit 1
fi

tar czf modorganizer_"$version".orig.tar.gz -C "$tmpdir" "$superdirname"
