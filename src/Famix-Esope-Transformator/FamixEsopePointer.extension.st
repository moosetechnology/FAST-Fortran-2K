Extension { #name : 'FamixEsopePointer' }

{ #category : '*Famix-Esope-Transformator' }
FamixEsopePointer >> migratedModuleName [

	^ self declaredType name, '_m'
]

{ #category : '*Famix-Esope-Transformator' }
FamixEsopePointer >> needsUseForProgramMain: aFASTFortran2kProgramMain [

	^ true
]
