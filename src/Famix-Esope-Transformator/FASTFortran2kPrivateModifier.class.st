Class {
	#name : 'FASTFortran2kPrivateModifier',
	#superclass : 'FASTFortran2kDeclarationModifier',
	#category : 'Famix-Esope-Transformator-ExtraModel',
	#package : 'Famix-Esope-Transformator',
	#tag : 'ExtraModel'
}

{ #category : 'visiting' }
FASTFortran2kPrivateModifier >> accept: aVisitor [

	^aVisitor visitFASTFortran2kPrivateModifier: self
]
