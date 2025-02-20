Extension { #name : 'FASTFortran2kProgramMain' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kProgramMain >> accept: aVisitor [
	<generated>

	^ aVisitor visitFASTFortran2kProgramMain: self.

]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kProgramMain >> migratedModuleName [

	^self parentProgramFile filename
]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kProgramMain >> needsUseFor: aFamix77Entity [

	^aFamix77Entity needsUseForProgramMain: self
]
