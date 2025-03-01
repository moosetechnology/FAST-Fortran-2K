Extension { #name : 'FamixF77PUMain' }

{ #category : '*Famix-Esope-Transformator' }
FamixF77PUMain >> migratedModuleName [

	^self programFile filename asPath basenameWithoutExtension
]
