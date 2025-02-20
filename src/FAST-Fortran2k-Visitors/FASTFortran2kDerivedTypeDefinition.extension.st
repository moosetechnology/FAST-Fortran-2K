Extension { #name : 'FASTFortran2kDerivedTypeDefinition' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kDerivedTypeDefinition >> accept: aVisitor [
	<generated>

	^ aVisitor visitFASTFortran2kDerivedTypeDefinition: self.

]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kDerivedTypeDefinition >> migratedModuleName [

	^self statementContainer fastBehaviouralParent migratedModuleName
]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kDerivedTypeDefinition >> needsUseFor: aFamix77Entity [
1halt.
	^(self name = aFamix77Entity name)
		not
]
