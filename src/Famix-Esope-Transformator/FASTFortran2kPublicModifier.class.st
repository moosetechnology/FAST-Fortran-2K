Class {
	#name : 'FASTFortran2kPublicModifier',
	#superclass : 'FASTFortran2kDeclarationModifier',
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'visiting' }
FASTFortran2kPublicModifier >> accept: aVisitor [

	^aVisitor visitFASTFortran2kPublicModifier: self
]
