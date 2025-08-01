"
Fortran-2k PARAMETER modifier that is actually not for (program units) parameters but to create a  named constant.
Therefore that this modifier is very different from ParameterIntent
"
Class {
	#name : 'FASTFortran2kParameterModifier',
	#superclass : 'FASTFortran2kDeclarationModifier',
	#category : 'Famix-Esope-Transformator-ExtraModel',
	#package : 'Famix-Esope-Transformator',
	#tag : 'ExtraModel'
}

{ #category : 'visiting' }
FASTFortran2kParameterModifier >> accept: aVisitor [

	^aVisitor visitFASTFortran2kParameterModifier: self
]
