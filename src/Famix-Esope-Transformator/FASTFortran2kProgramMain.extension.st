Extension { #name : 'FASTFortran2kProgramMain' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kProgramMain >> addUse: usedName [

	self statementBlock statements
		addFirst: (self mooseModel newUseStatement name: usedName)
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kProgramMain >> migratedModuleName [

	^self parentProgramFile filename
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kProgramMain >> useSource [

	^self
]
