Extension { #name : 'FASTFortran2kModifier' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kModifier >> accept: aVisitor [

	^aVisitor visitFASTFortran2kModifier: self
]
