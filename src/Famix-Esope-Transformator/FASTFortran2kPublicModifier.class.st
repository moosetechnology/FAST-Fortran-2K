Class {
	#name : 'FASTFortran2kPublicModifier',
	#superclass : 'FASTFortran2kDeclarationModifier',
	#category : 'Famix-Esope-Transformator-ExtraModel',
	#package : 'Famix-Esope-Transformator',
	#tag : 'ExtraModel'
}

{ #category : 'visiting' }
FASTFortran2kPublicModifier >> accept: aVisitor [

	^aVisitor visitFASTFortran2kPublicModifier: self
]
