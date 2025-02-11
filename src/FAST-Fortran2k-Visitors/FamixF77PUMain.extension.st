Extension { #name : 'FamixF77PUMain' }

{ #category : '*FAST-Fortran2k-Visitors' }
FamixF77PUMain >> migratedModuleName [

	^($. split: self programFile filename) first
]
