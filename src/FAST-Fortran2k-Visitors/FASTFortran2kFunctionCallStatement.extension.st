Extension { #name : 'FASTFortran2kFunctionCallStatement' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kFunctionCallStatement >> accept: aVisitor [

	^aVisitor visitFASTFortran2kFunctionCallStatement: self
]
