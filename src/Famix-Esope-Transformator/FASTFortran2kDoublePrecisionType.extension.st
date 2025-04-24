Extension { #name : 'FASTFortran2kDoublePrecisionType' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kDoublePrecisionType >> initialValue [

	^mooseModel newDoublePrecisionLiteral primitiveValue: '0D'
]
