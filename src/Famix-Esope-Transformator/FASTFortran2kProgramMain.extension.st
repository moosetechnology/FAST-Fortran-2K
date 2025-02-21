Extension { #name : 'FASTFortran2kProgramMain' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kProgramMain >> migratedModuleName [

	^self parentProgramFile filename
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kProgramMain >> needsUseFor: aFamix77Entity [

	^aFamix77Entity needsUseForProgramMain: self
]
