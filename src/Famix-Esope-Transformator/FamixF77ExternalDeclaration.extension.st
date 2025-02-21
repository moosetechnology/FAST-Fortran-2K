Extension { #name : 'FamixF77ExternalDeclaration' }

{ #category : '*Famix-Esope-Transformator' }
FamixF77ExternalDeclaration >> migratedModuleName [

	^ self externalProcedure migratedModuleName
]
