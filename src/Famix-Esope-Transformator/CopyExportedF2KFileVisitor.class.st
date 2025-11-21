Class {
	#name : 'CopyExportedF2KFileVisitor',
	#superclass : 'CopyVisitor',
	#category : 'Famix-Esope-Transformator-Utility',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Utility'
}

{ #category : 'visiting' }
CopyExportedF2KFileVisitor >> visitFile: anEntry [
	anEntry reference extension = 'f90' ifFalse: [ ^ self ].

	super visitFile: anEntry
]
