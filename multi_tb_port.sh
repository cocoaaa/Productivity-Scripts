#!/bin/bash
#source: https://stackoverflow.com/a/14203146
set -eu
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

echo "Tensorboard PORT = ${PORT}"
echo "link these dirs: $@"
# Call Tensorboard on mUltiple logdirs 
# source: https://github.com/tensorflow/tensorboard/issues/179#issuecomment-518729885
tmpdir="$(mktemp -d)"
set -- "${DIRS[@]}" # restore positional parameters
for arg; do
	echo "$arg"
	case "${arg}" in 
		/*) ln -s "${arg}" "${tmpdir}/" ;;
		*) ln -s "${PWD}"/"${arg}" "${tmpdir}/" ;;
	esac
done
exit_code=0
\command ls -l "${tmpdir}"
printf 'tensorboard --logdir %s\n' "${tmpdir}"
echo "hi"
tensorboard --logdir "${tmpdir}" --bind_all --port "${PORT}" || exit_code=$?

# remove temps
rm -f "${tmpdir}"/*
rmdir "${tmpdir}"
#return "${exit_code}"
