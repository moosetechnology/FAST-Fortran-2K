Class {
	#name : 'Fortran2kExportAsFPMProject',
	#superclass : 'Object',
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'accessing' }
Fortran2kExportAsFPMProject class >> author [

	^'You Nous'
]

{ #category : 'accessing' }
Fortran2kExportAsFPMProject class >> baseDir [

	^FileSystem workingDirectory 
]

{ #category : 'accessing' }
Fortran2kExportAsFPMProject class >> baseSourceDir [

	^FileSystem workingDirectory / 'tmpFortranImport'
]

{ #category : 'searching' }
Fortran2kExportAsFPMProject class >> createFpmToml [

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
Fortran2kExportAsFPMProject class >> email [

	^'email@mail.com'
]

{ #category : 'accessing' }
Fortran2kExportAsFPMProject class >> fpmDotToml [

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
Fortran2kExportAsFPMProject class >> getTargetDirFrom: aFileReference [

	| baseDir |

	baseDir := self baseDir / self projectName.
	
	^(aFileReference contents lines anySatisfy: [ :each | each trim beginsWith: 'program ' caseSensitive: false ])  
		ifTrue: [ baseDir / 'app' ]
		ifFalse: [ baseDir / 'src' ]
]

{ #category : 'accessing' }
Fortran2kExportAsFPMProject class >> gitUrl [

	^'https://gitlab.inria.fr/framatome/code/f2klib.git'
]

{ #category : 'searching' }
Fortran2kExportAsFPMProject class >> make [

	self baseSourceDir exists ifFalse: [ ^self ].

	self prepareWorkingDirectory.
	
	self createFpmToml.

	self moveGeneratedCode
]

{ #category : 'searching' }
Fortran2kExportAsFPMProject class >> moveGeneratedCode [

	#(inc src) do: [ :directoryName | 
		(self baseSourceDir / directoryName ) allChildren do: [ :aFileReference | 
			(aFileReference isFile and: [  aFileReference extension asLowercase = 'f90' ])
				ifTrue: [ | relativePath destinationFile targetDir |
					targetDir := self getTargetDirFrom: aFileReference.
					relativePath := aFileReference relativeTo: (self baseSourceDir / directoryName) asAbsolute.
					destinationFile := targetDir / relativePath pathString.
					destinationFile parent ensureCreateDirectory.
					aFileReference copyTo: destinationFile			
				]
			] 
		]
]

{ #category : 'searching' }
Fortran2kExportAsFPMProject class >> prepareWorkingDirectory [

	| baseDir |

	baseDir := self baseDir / self projectName.

	baseDir ensureDeleteAll.
	baseDir ensureCreateDirectory.

	(baseDir / 'src') ensureCreateDirectory.
	(baseDir / 'app') ensureCreateDirectory.
]

{ #category : 'accessing' }
Fortran2kExportAsFPMProject class >> projectName [

	^'tmpFortran2kExport'
]

{ #category : 'initialization' }
Fortran2kExportAsFPMProject >> seeClassSide [ 
]
