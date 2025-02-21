Extension { #name : 'FASTFortran2kProcedure' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kProcedure >> migratedModuleName [

	^self module migratedModuleName
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kProcedure >> needsUseFor: aFamix77Entity [

	^aFamix77Entity needsUseForProcedure: self
]
