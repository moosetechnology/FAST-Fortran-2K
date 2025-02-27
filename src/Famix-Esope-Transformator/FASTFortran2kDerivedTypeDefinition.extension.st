Extension { #name : 'FASTFortran2kDerivedTypeDefinition' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kDerivedTypeDefinition >> migratedModuleName [

	^self statementContainer fastBehaviouralParent migratedModuleName
]
