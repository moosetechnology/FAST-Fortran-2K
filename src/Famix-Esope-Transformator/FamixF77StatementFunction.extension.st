Extension { #name : 'FamixF77StatementFunction' }

{ #category : '*Famix-Esope-Transformator' }
FamixF77StatementFunction >> migratedModuleName [

	^self parentEntity migratedModuleName
]

{ #category : '*Famix-Esope-Transformator' }
FamixF77StatementFunction >> needsUseForModule: aFASTFortran2kModule [

	^false
]

{ #category : '*Famix-Esope-Transformator' }
FamixF77StatementFunction >> needsUseForProcedure: aFASTFortran2kProcedure [

	^false
]

{ #category : '*Famix-Esope-Transformator' }
FamixF77StatementFunction >> needsUseForProgramMain: aFASTFortran2kProgramMain [

	^false
]
