#!/bin/bash
lastSaved=$(date "+%s")
saveInterval=600
saveCount=0

function say {
	echo -e "\033[1;30m[$$ $(date "+%Y-%m-%d %T")]\033[0m" $@
}

function savePerInterval {
	currentTime=$(date "+%s")
	if [ "$(($currentTime-$lastSaved))" -ge "$saveInterval" ]; then
		lastSaved=$currentTime
		saveCount=$(($saveCount+1))
		say "Save attempt #${saveCount} started."
		git stage -A
		git commit -m "Automated save." > /dev/null
		if [ "$?" == 0 ]; then
			git push
		else
			say "Commit creation failed."
		fi
	fi
}

say "Auto-saver started."
savePerInterval
while : ; do
	sleep 2s
	savePerInterval
done