Extension { #name : 'FASTFortran2kProcedure' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kProcedure >> accept: aVisitor [
	<generated>

	^ aVisitor visitFASTFortran2kProcedure: self.

]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kProcedure >> migratedModuleName [

	^self module migratedModuleName
]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kProcedure >> needsUseFor: aFamix77Entity [

	^aFamix77Entity needsUseForProcedure: self
]
