Extension { #name : 'FASTFortran2kEmptyStatement' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kEmptyStatement >> accept: aVisitor [

	^aVisitor visitFASTFortran2kEmptyStatement: self
]
