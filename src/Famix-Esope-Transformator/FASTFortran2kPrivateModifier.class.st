Class {
	#name : 'FASTFortran2kPrivateModifier',
	#superclass : 'FASTFortran2kDeclarationModifier',
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'visiting' }
FASTFortran2kPrivateModifier >> accept: aVisitor [

	^aVisitor visitFASTFortran2kPrivateModifier: self
]
