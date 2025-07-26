Class {
	#name : 'FASTFortran2kPointerModifier',
	#superclass : 'FASTFortran2kDeclarationModifier',
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'visiting' }
FASTFortran2kPointerModifier >> accept: aVisitor [

	^aVisitor visitFASTFortran2kPointerModifier: self
]
