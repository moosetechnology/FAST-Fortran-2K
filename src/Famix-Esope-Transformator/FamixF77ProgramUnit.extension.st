Extension { #name : 'FamixF77ProgramUnit' }

{ #category : '*Famix-Esope-Transformator' }
FamixF77ProgramUnit >> migratedModuleName [

	^(($. split: self programFile filename) first, '_mod')  
]
