Extension { #name : 'FASTFortran2kProcedure' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kProcedure >> migratedModuleName [

	^self module migratedModuleName
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kProcedure >> useSource [

	^self module
]
