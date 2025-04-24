Extension { #name : 'FASTFortran2kCharacterType' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kCharacterType >> initialValue [

	^mooseModel newCharacterLiteral primitiveValue: (' ' repeat: size primitiveValue asInteger)
]
