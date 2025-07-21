"
A transformation step to organise the exported code for handling with `fpm`
- organise the file hierarchy
- generate the configuration file for `fpm`
"
Class {
	#name : 'EsopeTransfoStepAsFpmProject',
	#superclass : 'EsopeTransfoAbstractStep',
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'accessing' }
EsopeTransfoStepAsFpmProject class >> description [ 

		^'Create FPM project'
]

{ #category : 'accessing' }
EsopeTransfoStepAsFpmProject >> author [

	^'You Nous'
]

{ #category : 'accessing' }
EsopeTransfoStepAsFpmProject >> baseDir [

	^FileSystem workingDirectory 
]

{ #category : 'accessing' }
EsopeTransfoStepAsFpmProject >> baseSourceDir [

	^FileSystem workingDirectory / 'tmpFortranImport'
]

{ #category : 'searching' }
EsopeTransfoStepAsFpmProject >> createFpmToml [

	| baseDir |

	baseDir := self baseDir / self projectName.

	(baseDir / 'fpm.toml')
		writeStreamDo: [ :stream | 
			stream << (self fpmDotToml format: { 
				self projectName .
				self author .
				self email .
				self gitUrl }
			)
		]
]

{ #category : 'accessing' }
EsopeTransfoStepAsFpmProject >> email [

	^'email@mail.com'
]

{ #category : 'accessing' }
EsopeTransfoStepAsFpmProject >> fpmDotToml [

	^'name = "{1}"
version = "0.1.0"
license = "license"
author = "{2}"
maintainer = "{3}"
copyright = "Copyright 2025, {2}"
[build]
auto-executables = true
auto-tests = true
auto-examples = true
module-naming = false
[install]
library = false
[fortran]
implicit-typing = false
implicit-external = false
source-form = "free"

[dependencies]
f2klib =  \{ git = "{4}" \}
'
]

{ #category : 'searching' }
EsopeTransfoStepAsFpmProject >> getTargetDirFrom: aFileReference [

	| baseDir |

	baseDir := self baseDir / self projectName.
	
	^(aFileReference contents lines anySatisfy: [ :each | each trim beginsWith: 'program ' caseSensitive: false ])  
		ifTrue: [ baseDir / 'app' ]
		ifFalse: [ baseDir / 'src' ]
]

{ #category : 'accessing' }
EsopeTransfoStepAsFpmProject >> gitUrl [

	^'https://gitlab.inria.fr/framatome/code/f2klib.git'
]

{ #category : 'searching' }
EsopeTransfoStepAsFpmProject >> moveGeneratedCode [

	#(inc src) do: [ :directoryName | 
		(self baseSourceDir / directoryName ) allChildren do: [ :aFileReference | 
			(aFileReference isFile and: [  aFileReference extension asLowercase = 'f90' ])
				ifTrue: [ | relativePath destinationFile targetDir |
					targetDir := self getTargetDirFrom: aFileReference.
					relativePath := aFileReference relativeTo: (self baseSourceDir / directoryName) asAbsolute.
					destinationFile := targetDir / relativePath pathString.
					destinationFile parent ensureCreateDirectory.
					aFileReference moveTo: destinationFile			
				]
			] 
		]
]

{ #category : 'searching' }
EsopeTransfoStepAsFpmProject >> prepareWorkingDirectory [

	| baseDir |

	baseDir := self baseDir / self projectName.

	baseDir ensureDeleteAll.
	baseDir ensureCreateDirectory.

	(baseDir / 'src') ensureCreateDirectory.
	(baseDir / 'app') ensureCreateDirectory.
]

{ #category : 'accessing' }
EsopeTransfoStepAsFpmProject >> projectName [

	^'tmpFortran2kExport'
]

{ #category : 'running' }
EsopeTransfoStepAsFpmProject >> run [ 

	self baseSourceDir exists ifFalse: [ ^self ].

	self prepareWorkingDirectory.
	
	self createFpmToml.

	self moveGeneratedCode
]
