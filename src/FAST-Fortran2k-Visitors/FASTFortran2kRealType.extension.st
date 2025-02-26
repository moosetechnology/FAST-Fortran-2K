Extension { #name : 'FASTFortran2kRealType' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kRealType >> accept: aVisitor [
	<generated>

	^ aVisitor visitFASTFortran2kRealType: self.

]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kRealType >> name [ 

	^'real'
]
