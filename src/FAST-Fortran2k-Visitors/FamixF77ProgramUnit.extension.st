Extension { #name : 'FamixF77ProgramUnit' }

{ #category : '*FAST-Fortran2k-Visitors' }
FamixF77ProgramUnit >> migratedModuleName [

	^(($. split: self programFile filename) first, '_mod')  
]
