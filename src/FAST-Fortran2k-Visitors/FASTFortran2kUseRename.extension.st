Extension { #name : 'FASTFortran2kUseRename' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kUseRename >> accept: aVisitor [

	^aVisitor visitFASTFortran2kUseRename: self
]
