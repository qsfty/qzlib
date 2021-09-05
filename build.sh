#!/bin/zsh

git add .
git commit -m "完善"
git push

git tag 1.0.4
git push --tags

pod trunk push QzLib QzLib.podspec --allow-warnings
