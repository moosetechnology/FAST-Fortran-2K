Extension { #name : 'FamixF77ExternalDeclaration' }

{ #category : '*FAST-Fortran2k-Visitors' }
FamixF77ExternalDeclaration >> migratedModuleName [

	^ self externalProcedure migratedModuleName
]
