#!/bin/zsh

git add .
git commit -m "完善"
git push

git tag 1.1.0
git push --tags

pod trunk push QzLib.podspec --allow-warnings
