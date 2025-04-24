Extension { #name : 'FASTFortran2kLogicalType' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kLogicalType >> initialValue [

	^mooseModel newBooleanLiteral primitiveValue: '.false.'
]
