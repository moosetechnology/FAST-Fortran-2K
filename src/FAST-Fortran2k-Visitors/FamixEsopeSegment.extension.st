Extension { #name : 'FamixEsopeSegment' }

{ #category : '*FAST-Fortran2k-Visitors' }
FamixEsopeSegment >> migratedModuleName [

	^self name, '_mod'
]
