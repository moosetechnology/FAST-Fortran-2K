Extension { #name : 'FASTFortran2kVariableDeclarationStatement' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kVariableDeclarationStatement >> addModifier: aString [

	modifiers := modifiers
		ifNil: [ { aString } ]
		ifNotNil: [ modifiers , { aString } ]
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kVariableDeclarationStatement >> detectMatchingEntityIn: namedEntities [

	^namedEntities
		detect: [ :entity |
			self declarators anySatisfy: [ :declarator | entity name = declarator name]
		]
		ifNone: [ nil ]
]
