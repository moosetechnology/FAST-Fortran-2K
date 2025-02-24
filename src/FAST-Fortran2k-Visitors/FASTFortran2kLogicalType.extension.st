Extension { #name : 'FASTFortran2kLogicalType' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kLogicalType >> accept: aVisitor [
	<generated>

	^ aVisitor visitFASTFortran2kLogicalType: self.

]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kLogicalType >> name [

	^ 'logical'
]
