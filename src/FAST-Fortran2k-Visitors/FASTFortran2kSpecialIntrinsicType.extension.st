Extension { #name : 'FASTFortran2kSpecialIntrinsicType' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kSpecialIntrinsicType >> accept: aVisitor [
	^ aVisitor visitFASTFortran2kSpecialIntrinsicType: self
]
