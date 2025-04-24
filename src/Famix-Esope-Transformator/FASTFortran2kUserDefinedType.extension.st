Extension { #name : 'FASTFortran2kUserDefinedType' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kUserDefinedType >> initialValue [

	^mooseModel newFunctionCall
		name: 'null' ;
		arguments: #()
]
