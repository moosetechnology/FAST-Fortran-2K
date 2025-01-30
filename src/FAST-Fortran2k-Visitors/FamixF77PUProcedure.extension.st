Extension { #name : 'FamixF77PUProcedure' }

{ #category : '*FAST-Fortran2k-Visitors' }
FamixF77PUProcedure >> needsUseForModule: aFASTFortran2kModule [

	^aFASTFortran2kModule procedures noneSatisfy: [ :modProcedure |
		modProcedure name = self name ]
]

{ #category : '*FAST-Fortran2k-Visitors' }
FamixF77PUProcedure >> needsUseForProcedure: aFASTFortran2kProcedure [

	^aFASTFortran2kProcedure module procedures noneSatisfy: [ :modProcedure |
		modProcedure name = self name ]
]

{ #category : '*FAST-Fortran2k-Visitors' }
FamixF77PUProcedure >> needsUseForProgramMain: aFASTFortran2kProgramMain [

	^true
]
