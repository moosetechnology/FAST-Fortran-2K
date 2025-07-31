Class {
	#name : 'FASTFortran2kParameterIntent',
	#superclass : 'FASTFortran2kDeclarationModifier',
	#instVars : [
		'isIn',
		'isOut'
	],
	#category : 'Famix-Esope-Transformator-ExtraModel',
	#package : 'Famix-Esope-Transformator',
	#tag : 'ExtraModel'
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
FASTFortran2kParameterIntent >> isInOut [

	^isIn and: [ isOut ]
]

{ #category : 'accessing' }
FASTFortran2kParameterIntent >> isOut [

	^ isOut
]

{ #category : 'accessing' }
FASTFortran2kParameterIntent >> isOut: anObject [

	isOut := anObject
]
