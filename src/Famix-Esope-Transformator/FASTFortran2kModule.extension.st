Extension { #name : 'FASTFortran2kModule' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kModule >> addUse: usedName [

	self statementBlock statements
		addFirst: (self mooseModel newUseStatement name: usedName)
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kModule >> migratedModuleName [

	^self name
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kModule >> useSource [

	^self
]
