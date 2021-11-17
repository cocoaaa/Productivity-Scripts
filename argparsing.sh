#!/bin/bash
#source: https://stackoverflow.com/a/14203146
DIRS=()
while [[ $# -gt 0 ]]; do
	key="$1"
	case "$key" in 
		-p|--port)
		PORT="$2"
		shift # past argument
		shift # past value
		;;
		*) # Unknown option/Positional argument
		DIRS+=("$1") # save it in an array for later
		shift # past argument
		;;
	esac
done

set -- "${DIRS[@]}" # restore positional parameters

echo "Tensorboard PORT = ${PORT}"
echo "link these dirs: $@"

for arg; do
	echo "$arg"
done


