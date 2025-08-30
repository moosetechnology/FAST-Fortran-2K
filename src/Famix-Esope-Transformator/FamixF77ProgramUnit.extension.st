Extension { #name : 'FamixF77ProgramUnit' }

{ #category : '*Famix-Esope-Transformator' }
FamixF77ProgramUnit >> migratedModuleName [

	^self programFile filename asPath basenameWithoutExtension , '_m'
]
