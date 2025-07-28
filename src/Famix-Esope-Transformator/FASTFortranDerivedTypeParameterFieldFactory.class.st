Class {
	#name : 'FASTFortranDerivedTypeParameterFieldFactory',
	#superclass : 'FASTFortranDerivedTypeFieldFactory',
	#category : 'Famix-Esope-Transformator-Segment',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Segment'
}

{ #category : 'entity-creation' }
FASTFortranDerivedTypeParameterFieldFactory >> createSegcmdFieldDeclaration [

	^self model newVariableDeclarationStatement
		addDeclarator: (self model newVariableDeclarator name: name) ;
		declaredType: self model newIntegerType
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeParameterFieldFactory >> createSegcmdInFieldDeclaration [

	^self createSegcmdFieldDeclaration 
		modifiers: { FASTFortran2kParameterIntent new isIn: true } ;
		yourself
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeParameterFieldFactory >> createSegcmdInoutFieldDeclaration [

	^self createSegcmdFieldDeclaration
		modifiers: { FASTFortran2kParameterIntent new isIn: true ; isOut: true } ;
		yourself
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeParameterFieldFactory >> createSegcmdOutFieldDeclaration [

	^self createSegcmdFieldDeclaration 
		modifiers: { FASTFortran2kParameterIntent new isOut: true } ;
		yourself
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeParameterFieldFactory >> createSegcopFieldDeclaration [

	^self model newVariableDeclarationStatement
		addDeclarator: (self model newVariableDeclarator name: name) ;
		declaredType: self model newIntegerType
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeParameterFieldFactory >> createSeginiFieldInitialization [

	^self model newAssignmentStatement
		variable: (self model newDerivedTypeComponentAccess
			instance: (self scalarVariable: 'this') ;
			field: (self scalarVariable: name) ) ;
		expression: (self scalarVariable: name)
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeParameterFieldFactory >> createSegmentFieldDeclaration [


	| declaredType |
	declaredType := self model newIntegerType.

	^self model newVariableDeclarationStatement
		modifiers: {  FASTFortran2kPrivateModifier new } ;
		addDeclarator: (self model newVariableDeclarator 
			name: name ;
			expression: declaredType initialValue 
		) ;
		declaredType: declaredType
]

{ #category : 'testing' }
FASTFortranDerivedTypeParameterFieldFactory >> isSegmentParameter [

	^true
]

{ #category : 'testing' }
FASTFortranDerivedTypeParameterFieldFactory >> isSegmentThisParameter [

	^false
]
