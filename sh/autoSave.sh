#!/bin/bash
lastSaved=$(date "+%s")
saveInterval=2
saveCount=0

function say {
	echo -e "\033[1;30m[$$ $(date "+%Y-%M-%d %T")]\033[0m" $@
}

function savePerInterval {
	currentTime=$(date "+%s")
	if [ "$(($currentTime-$lastSaved))" -ge "$saveInterval" ]; then
		lastSaved=$currentTime
		saveCount=$(($saveCount+1))
		say "Save attempt #${saveCount} started."
		git stage -A
	fi
}

say "Auto-saver started."
savePerInterval
while : ; do
	sleep 1s
	savePerInterval
done