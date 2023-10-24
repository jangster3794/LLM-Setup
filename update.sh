#!/bin/bash

version_file="branch.info"
dos2unix $version_file
dos2unix wait-for-it.sh

git submodule update --init --recursive

while IFS=: read -r repo branch
do
	if [ "$repo" == "" ]; then
		break
	else
		echo "Fetching $branch for $repo"
		cd $repo
		git stash
		git fetch && git checkout $branch
		git pull
		echo "-----------------------------------------------------------------"
		cd ..
	fi
done < $version_file
