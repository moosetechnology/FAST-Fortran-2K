Extension { #name : 'FASTFortran2kUseStatement' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kUseStatement >> accept: aVisitor [
	<generated>

	^ aVisitor visitFASTFortran2kUseStatement: self.

]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kUseStatement >> useNoRenamedStatements [

	^#()
]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kUseStatement >> useNoRenames [
	"for compatibility with other kind of use"

	^#()
]
