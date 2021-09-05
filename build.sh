#!/bin/zsh

git add .
git commit -m "完善"
git push

git tag 0.0.12
git push --tags

pod trunk push QzLib.podspec --allow-warnings
