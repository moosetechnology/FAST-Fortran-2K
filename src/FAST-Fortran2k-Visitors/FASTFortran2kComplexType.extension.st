Extension { #name : 'FASTFortran2kComplexType' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kComplexType >> accept: aVisitor [
	<generated>

	^ aVisitor visitFASTFortran2kComplexType: self.

]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kComplexType >> name [ 

	^'complex'
]
