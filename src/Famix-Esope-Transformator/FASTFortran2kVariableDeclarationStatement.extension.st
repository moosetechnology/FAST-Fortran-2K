Extension { #name : 'FASTFortran2kVariableDeclarationStatement' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kVariableDeclarationStatement >> addModifier: aString [

	modifiers := modifiers
		ifNil: [ { aString } ]
		ifNotNil: [ modifiers , { aString } ]
]
