Extension { #name : 'FamixF77PUMain' }

{ #category : '*Famix-Esope-Transformator' }
FamixF77PUMain >> migratedModuleName [

	^($. split: self programFile filename) first
]
