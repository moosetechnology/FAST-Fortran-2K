Extension { #name : 'FamixEsopeSegment' }

{ #category : '*FAST-Fortran2k-Visitors' }
FamixEsopeSegment >> migratedModuleName [

	^self name, '_mod'
]

{ #category : '*FAST-Fortran2k-Visitors' }
FamixEsopeSegment >> needsUseForModule: aFASTFortran2kModule [

	^aFASTFortran2kModule statementBlock statements noneSatisfy: [ :modStatement |
		(modStatement class = FASTFortran2kDerivedTypeDefinition) and:
		[modStatement name = self name] ]
]

{ #category : '*FAST-Fortran2k-Visitors' }
FamixEsopeSegment >> needsUseForProcedure: aFASTFortran2kProcedure [

	^true
]

{ #category : '*FAST-Fortran2k-Visitors' }
FamixEsopeSegment >> needsUseForProgramMain: aFASTFortran2kProgramMain [

	^true
]
