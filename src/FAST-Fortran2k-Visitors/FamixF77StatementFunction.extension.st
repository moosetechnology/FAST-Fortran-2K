Extension { #name : 'FamixF77StatementFunction' }

{ #category : '*FAST-Fortran2k-Visitors' }
FamixF77StatementFunction >> migratedModuleName [

	^(($. split: self parentEntity programFile filename) first, '_mod')  
]
