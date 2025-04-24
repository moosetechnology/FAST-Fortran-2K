Extension { #name : 'FASTFortran2kIntegerType' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kIntegerType >> initialValue [

	^mooseModel newIntegerLiteral primitiveValue: 0
]
