Class {
	#name : 'FASTFortran2kSaveModifier',
	#superclass : 'FASTFortran2kDeclarationModifier',
	#category : 'Famix-Esope-Transformator-ExtraModel',
	#package : 'Famix-Esope-Transformator',
	#tag : 'ExtraModel'
}

{ #category : 'visiting' }
FASTFortran2kSaveModifier >> accept: aVisitor [

	^aVisitor visitFASTFortran2kSaveModifier: self
]
