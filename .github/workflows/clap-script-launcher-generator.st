scriptName := 'esopeToF2k'.

scriptContent := '#!/usr/bin/env bash

# shell script for clap script command launcher

set -euo pipefail

readonly PHARO_VM="{1}"
readonly PHARO_IMAGE="{2}"
readonly WORKING_DIRECTORY="{3}"

readonly HEADLESS_CLAP_COMMAND="$\{PHARO_VM} --headless $\{PHARO_IMAGE} --no-default-preferences clap"

function help() \{ 
	$HEADLESS_CLAP_COMMAND {4} --help
}

function migrate() \{ 
	$HEADLESS_CLAP_COMMAND {4} "$@"
}

function main() \{ 
	if [[ $# -lt 1 ]]; then
		help
		exit 1
	else
		echo "Migration process may take time. Please wait..."
		migrate "$@"
	fi
}

cd "$\{WORKING_DIRECTORY}"

main "$@"

exit 0
' format: { 
	('${HOME}/' , (Smalltalk vm fileName asFileReference relativeToPath: FileLocator home) pathString).
	('${HOME}/' , (SmalltalkImage current imagePath asFileReference relativeToPath: FileLocator home) pathString) .
	('${HOME}/' , (FileSystem workingDirectory relativeToPath: FileLocator home) pathString) .
	scriptName 
}.

scriptName asFileReference 
    writeStreamDo: [ :str | str truncate ;  << scriptContent withUnixLineEndings ] 
    ifPresent: [ "nothing" ]
