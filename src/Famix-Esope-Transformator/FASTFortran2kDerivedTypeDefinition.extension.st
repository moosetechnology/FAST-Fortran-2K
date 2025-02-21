Extension { #name : 'FASTFortran2kDerivedTypeDefinition' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kDerivedTypeDefinition >> migratedModuleName [

	^self statementContainer fastBehaviouralParent migratedModuleName
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kDerivedTypeDefinition >> needsUseFor: aFamix77Entity [
1halt.
	^(self name = aFamix77Entity name)
		not
]
