Extension { #name : 'FamixEsopePointer' }

{ #category : '*FAST-Fortran2k-Visitors' }
FamixEsopePointer >> migratedModuleName [

	^ self declaredType name, '_mod'
]

{ #category : '*FAST-Fortran2k-Visitors' }
FamixEsopePointer >> needsUseForProgramMain: aFASTFortran2kProgramMain [

	^ true
]
