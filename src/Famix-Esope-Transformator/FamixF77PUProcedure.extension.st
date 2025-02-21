Extension { #name : 'FamixF77PUProcedure' }

{ #category : '*Famix-Esope-Transformator' }
FamixF77PUProcedure >> needsUseForModule: aFASTFortran2kModule [

	^aFASTFortran2kModule procedures noneSatisfy: [ :modProcedure |
		modProcedure name = self name ]
]

{ #category : '*Famix-Esope-Transformator' }
FamixF77PUProcedure >> needsUseForProcedure: aFASTFortran2kProcedure [

	^aFASTFortran2kProcedure module procedures noneSatisfy: [ :modProcedure |
		modProcedure name = self name ]
]

{ #category : '*Famix-Esope-Transformator' }
FamixF77PUProcedure >> needsUseForProgramMain: aFASTFortran2kProgramMain [

	^true
]
