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

{ #category : 'visiting' }
FASTFortranUseTransformationVisitor >> visitFASTEsopePointerDeclarationStatement: aFASTEsopePointerDeclarationStatement [

	self visitFASTFortranList: aFASTEsopePointerDeclarationStatement pointerDeclarators
	
]

{ #category : 'visiting' }
FASTFortranUseTransformationVisitor >> visitFASTEsopePointerDeclarator: aFASTEsopePointerDeclarator [ 
	
	| programUnit segment |
	programUnit := aFASTEsopePointerDeclarator pointerDeclarationStatement statementContainer fastBehaviouralParent famix.
	segment := aFASTEsopePointerDeclarator variableDeclarator famixDeclaration declaredType.

	usesNeeded add: (programUnit -> segment)

]

{ #category : 'visiting - expressions' }
FASTFortranUseTransformationVisitor >> visitFASTEsopeSegment: aFASTEsopeSegmentNode [

	self visitFASTFortranList: aFASTEsopeSegmentNode statements
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
