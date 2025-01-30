Extension { #name : 'FASTFortran2kModule' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kModule >> accept: aVisitor [
	<generated>
	^ aVisitor visitFASTFortran2kModule: self.

]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kModule >> migratedModuleName [

	^self name
]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kModule >> needsUseFor: aFamix77Entity [
1halt.
	^aFamix77Entity needsUseForModule: self
]
