"
Commandline to migrate Esope source to Fortran-2k source

`esopeToF2k --srcFolder /path/to/src [--incFolder /path/to/inc]`
"
Class {
	#name : 'EsopeToF2kCommand',
	#superclass : 'ClapApplication',
	#instVars : [
		'sourceFolderPathString',
		'includeFolderPathString',
		'outStream'
	],
	#category : 'Famix-Esope-Transformator-Commandline',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Commandline'
}

{ #category : 'execution' }
EsopeToF2kCommand class >> esopeToF2k [
	<script>
	<commandline>

	^(ClapCommandSpec id: #esopeToF2k)
		description: 'Transpile esope source to fortran-2k' ;
		commandClass: self ;
		addHelp ;
		addFlag: #srcFolder 
			description: 'Path of esope source'
			positionalSpec: [ :positional |
				positional
					symbol ;
					defaultValue: [ :arg :app | app defaultSourceFolder ] 
		] ;
		addFlag: #incFolder
			description: 'Path of include folder'
			positionalSpec: [ :positional |
				positional
					symbol ;
					defaultValue: [ :arg :app | app defaultIncludeFolder ] 
		] ;
		yourself
]

{ #category : 'accessing' }
EsopeToF2kCommand >> defaultIncludeFolder [

	^''
]

{ #category : 'accessing' }
EsopeToF2kCommand >> defaultSourceFolder [

	^''
]

{ #category : 'execution' }
EsopeToF2kCommand >> esopeToF2k [

	self hasSrcFolderFlag ifFalse: [ 
		^self outStream
			<< 'Provide mandatory flag: --srcFolder <srcFolder-value>' ;
			lf
	].

	self 
		sourceFolder: self sourceFolderPathString
		includeFolder: self includeFolderPathString.

	self outStream 
		<< 'ExportFolder: ' ;
		<< (FileSystem workingDirectory / 'tmpFortran2kExport') pathString ;
		lf

]

{ #category : 'execution' }
EsopeToF2kCommand >> esopeTransformerClass [ 

	^EsopeTransformationController
]

{ #category : 'execution' }
EsopeToF2kCommand >> execute [

	self esopeToF2k
]

{ #category : 'execution' }
EsopeToF2kCommand >> hasIncFolderFlag [

	^self hasFlag: #incFolder
]

{ #category : 'execution' }
EsopeToF2kCommand >> hasSrcFolderFlag [

	^self hasFlag: #srcFolder
]

{ #category : 'execution' }
EsopeToF2kCommand >> includeFolderPathString [
	"if incFolder is not provided, we use srcFolder by default"

	^self hasIncFolderFlag 
		ifTrue: [ self positional: #incFolder ]
		ifFalse: [ self positional: #srcFolder ]
]

{ #category : 'execution' }
EsopeToF2kCommand >> outStream [

	^outStream ifNil: [ outStream := VTermOutputDriver on: self context stdout ]
]

{ #category : 'execution' }
EsopeToF2kCommand >> sourceFolder: srcFolderPathString includeFolder: incFolderPathString [

	self esopeTransformerClass 
		sourceFolder: srcFolderPathString
		includeFolder: incFolderPathString
]

{ #category : 'execution' }
EsopeToF2kCommand >> sourceFolderPathString [

	^self positional: #srcFolder
]
