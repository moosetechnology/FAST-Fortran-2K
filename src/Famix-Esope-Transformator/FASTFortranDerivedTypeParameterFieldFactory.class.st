Class {
	#name : 'FASTFortranDerivedTypeParameterFieldFactory',
	#superclass : 'FASTFortranDerivedTypeFieldFactory',
	#category : 'Famix-Esope-Transformator-Segment',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Segment'
}

{ #category : 'entity-creation' }
FASTFortranDerivedTypeParameterFieldFactory >> createSegadjFieldDeclaration [

	^self createSeginiFieldDeclaration
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeParameterFieldFactory >> createSegcopFieldDeclaration [

	^self model newVariableDeclarationStatement
		addDeclarator: (self model newVariableDeclarator name: name) ;
		declaredType: self model newIntegerType
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeParameterFieldFactory >> createSeginiFieldDeclaration [

	^self model newVariableDeclarationStatement
		"addModifier: (self model newModifier: 'intent(in)') ;"
		addDeclarator: (self model newVariableDeclarator name: name) ;
		declaredType: self model newIntegerType
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeParameterFieldFactory >> createSeginiFieldInitialization [

	^self model newAssignmentStatement
		variable: (self model newDerivedTypeComponentAccess
			instance: (self model newScalarVariable name: 'this') ;
			field: (self model newScalarVariable name: name) ) ;
		expression: (self model newScalarVariable name: name)
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeParameterFieldFactory >> createSegmentFieldDeclaration [

	^self model newVariableDeclarationStatement
		"addModifier: 'private' ;"
		addDeclarator: (self model newVariableDeclarator name: name) ;
		declaredType: self model newIntegerType
]

{ #category : 'testing' }
FASTFortranDerivedTypeParameterFieldFactory >> isSegmentParameter [

	^true
]

{ #category : 'testing' }
FASTFortranDerivedTypeParameterFieldFactory >> isSegmentThisParameter [

	^false
]
