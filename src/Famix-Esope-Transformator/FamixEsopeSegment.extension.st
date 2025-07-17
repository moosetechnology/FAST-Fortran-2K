Extension { #name : 'FamixEsopeSegment' }

{ #category : '*Famix-Esope-Transformator' }
FamixEsopeSegment >> generateF2kInModel: anObject [

	^FASTFortran2kUserDefinedType new
		name: self name
]

{ #category : '*Famix-Esope-Transformator' }
FamixEsopeSegment >> migratedModuleName [

	^self name, '_mod'
]

{ #category : '*Famix-Esope-Transformator' }
FamixEsopeSegment >> needsUseForModule: aFASTFortran2kModule [

	^aFASTFortran2kModule statementBlock statements noneSatisfy: [ :modStatement |
		(modStatement class = FASTFortran2kDerivedTypeDefinition) and:
		[modStatement name = self name] ]
]

{ #category : '*Famix-Esope-Transformator' }
FamixEsopeSegment >> needsUseForProcedure: aFASTFortran2kProcedure [

	^true
]

{ #category : '*Famix-Esope-Transformator' }
FamixEsopeSegment >> needsUseForProgramMain: aFASTFortran2kProgramMain [

	^true
]
