Extension { #name : 'FASTFortran2kModule' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kModule >> migratedModuleName [

	^self name
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kModule >> needsUseFor: aFamix77Entity [
1halt.
	^aFamix77Entity needsUseForModule: self
]
