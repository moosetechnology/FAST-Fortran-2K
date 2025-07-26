Class {
	#name : 'FASTFortran2kParameterIntent',
	#superclass : 'FASTFortran2kDeclarationModifier',
	#instVars : [
		'isIn',
		'isOut'
	],
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'visiting' }
FASTFortran2kParameterIntent >> accept: aVisitor [

	^aVisitor visitFASTFortran2kParameterIntent: self
]

{ #category : 'initialization' }
FASTFortran2kParameterIntent >> initialize [ 

	super initialize.

	isIn := isOut := false
]

{ #category : 'accessing' }
FASTFortran2kParameterIntent >> isIn [

	^ isIn
]

{ #category : 'accessing' }
FASTFortran2kParameterIntent >> isIn: anObject [

	isIn := anObject
]

{ #category : 'accessing' }
FASTFortran2kParameterIntent >> isOut [

	^ isOut
]

{ #category : 'accessing' }
FASTFortran2kParameterIntent >> isOut: anObject [

	isOut := anObject
]
