Class {
	#name : 'FASTFortran2kIntrinsicModifier',
	#superclass : 'FASTFortran2kDeclarationModifier',
	#category : 'Famix-Esope-Transformator-ExtraModel',
	#package : 'Famix-Esope-Transformator',
	#tag : 'ExtraModel'
}

{ #category : 'visiting' }
FASTFortran2kIntrinsicModifier >> accept: aVisitor [

	^aVisitor visitFASTFortran2kIntrinsicModifier: self
]
