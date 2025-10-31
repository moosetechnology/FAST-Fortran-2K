"
Export directory and f90 files
"
Class {
	#name : 'EsopeTransfoStepExport',
	#superclass : 'EsopeTransfoAbstractStep',
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'accessing' }
EsopeTransfoStepExport class >> description [

	^ 'Export directory for f90'
]

{ #category : 'running' }
EsopeTransfoStepExport >> run [

	| source |
	source := FileSystem workingDirectory / 'tmpFortranImport'.
	source exists ifFalse: [ ^ self ].

	CopyExportedF2KFileVisitor
		copy: source
		to: FileSystem workingDirectory / 'tmpExportedF2K'
]
