Class {
	#name : 'FASTFortran2kPointerModifier',
	#superclass : 'FASTFortran2kDeclarationModifier',
	#category : 'Famix-Esope-Transformator-ExtraModel',
	#package : 'Famix-Esope-Transformator',
	#tag : 'ExtraModel'
}

{ #category : 'visiting' }
FASTFortran2kPointerModifier >> accept: aVisitor [

	^aVisitor visitFASTFortran2kPointerModifier: self
]
