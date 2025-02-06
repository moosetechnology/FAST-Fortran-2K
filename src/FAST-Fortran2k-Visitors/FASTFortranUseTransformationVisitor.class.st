Class {
	#name : 'FASTFortranUseTransformationVisitor',
	#superclass : 'FASTFortranAbstractTransformationVisitor',
	#instVars : [
		'parentVisitor',
		'usesNeeded'
	],
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'initialization' }
FASTFortranUseTransformationVisitor >> initialize [ 

	super initialize.

	usesNeeded := Set new
]

{ #category : 'accessing' }
FASTFortranUseTransformationVisitor >> parentVisitor [

	^ parentVisitor
]

{ #category : 'accessing' }
FASTFortranUseTransformationVisitor >> parentVisitor: anObject [

	parentVisitor := anObject
]

{ #category : 'accessing' }
FASTFortranUseTransformationVisitor >> usesNeeded [

	^usesNeeded 
]

{ #category : 'visiting - expressions' }
FASTFortranUseTransformationVisitor >> visitFASTFortranFunctionCall: aFASTFortranFunctionCall [

	| caller called |
	caller := aFASTFortranFunctionCall famix sender.
	called := aFASTFortranFunctionCall famix candidates anyOne.
	
	(caller programFile = called programFile)
		ifFalse: [ usesNeeded add: (caller -> called) ].

	super visitFASTFortranFunctionCall: aFASTFortranFunctionCall
]
