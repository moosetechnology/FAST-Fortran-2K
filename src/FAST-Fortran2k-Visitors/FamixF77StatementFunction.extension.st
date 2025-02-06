Extension { #name : 'FamixF77StatementFunction' }

{ #category : '*FAST-Fortran2k-Visitors' }
FamixF77StatementFunction >> migratedModuleName [

	^self parentEntity migratedModuleName
]

{ #category : '*FAST-Fortran2k-Visitors' }
FamixF77StatementFunction >> needsUseForModule: aFASTFortran2kModule [

	^false
]

{ #category : '*FAST-Fortran2k-Visitors' }
FamixF77StatementFunction >> needsUseForProcedure: aFASTFortran2kProcedure [

	^false
]

{ #category : '*FAST-Fortran2k-Visitors' }
FamixF77StatementFunction >> needsUseForProgramMain: aFASTFortran2kProgramMain [

	^false
]

{ #category : '*FAST-Fortran2k-Visitors' }
FamixF77StatementFunction >> programFile [

	^self parentEntity programFile
]
