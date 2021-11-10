#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
pushd $SCRIPT_DIR

for expt in e21b09 e21e13 e21a14 e21d15 e21a17 e21e18; do
	for band in 1 2 3 4; do
		notesfile=../templates/230G/band$band/notes_$expt.v2d
		if [[ ! -f $notesfile ]]; then
			echo "Making initial $notesfile"
			echo "# Track $expt band $band" > $notesfile
			echo "# Notes: ..." >> $notesfile
		fi
	done
done

for expt in e21f19; do
	for band in 1 2 3 4; do
		notesfile=../templates/345G/band$band/notes_$expt.v2d
		if [[ ! -f $notesfile ]]; then
			echo "Making initial $notesfile"
			echo "# Track $expt band $band" > $notesfile
			echo "# Notes: ..." >> $notesfile
		fi
	done
done
