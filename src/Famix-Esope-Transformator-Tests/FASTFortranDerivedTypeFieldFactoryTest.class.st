Class {
	#name : 'FASTFortranDerivedTypeFieldFactoryTest',
	#superclass : 'TestCase',
	#instVars : [
		'fastModel',
		'segFactory',
		'fast2kModel'
	],
	#category : 'Famix-Esope-Transformator-Tests',
	#package : 'Famix-Esope-Transformator-Tests'
}

{ #category : 'running' }
FASTFortranDerivedTypeFieldFactoryTest >> makeFactory: factoryClass [

	| factory |
	factory := factoryClass new.
	factory derivedTypeFactory: (Mock named: 'FASTFrotranDerivedTypeFactory').
	factory derivedTypeFactory stub model willReturn: fast2kModel.

	^factory
]

{ #category : 'running' }
FASTFortranDerivedTypeFieldFactoryTest >> setUp [

	super setUp.

	fastModel := FASTEsopeModel new.
	fast2kModel := FASTFortran2kModel new.

]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testComponentAsFieldAccess1Rank [

	| string factory |
	factory := self makeFactory: FASTFortranDerivedTypeComponentFieldFactory.
	factory 
		type: fastModel newIntegerType ;
		fieldDeclarator: (fastModel newVariableDeclarator
			name: 'x' ;
			dimensions: {  fastModel newArrayRange } ).

	string := factory asFieldAccess.

	self assert: string equals: 'x(:)'
]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testComponentAsFieldAccess3Rank [

	| string factory |
	factory := self makeFactory: FASTFortranDerivedTypeComponentFieldFactory.
	factory 
		type: fastModel newIntegerType ;
		fieldDeclarator: (fastModel newVariableDeclarator
			name: 'x' ;
			dimensions: { fastModel newArrayRange . fastModel newArrayRange . fastModel newArrayRange } ).

	string := factory asFieldAccess.

	self assert: string equals: 'x(:,:,:)'
]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testComponentAsFieldAccessNoRank [

	| string factory |
	factory := self makeFactory: FASTFortranDerivedTypeComponentFieldFactory.
	factory 
		type: fastModel newIntegerType ;
		fieldDeclarator: (fastModel newVariableDeclarator
			name: 'x' ;
			dimensions: #() ).

	string := factory asFieldAccess.

	self assert: string equals: 'x'
]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testCreateSegadjComponentTemporaryDeclaration [

	| fast2k factory |
	factory := self makeFactory: FASTFortranDerivedTypeComponentFieldFactory.
	factory
		type: fastModel newIntegerType ;
		fieldDeclarator: (fastModel newVariableDeclarator
			name: 'x' ;
			dimensions: {  fastModel newArrayRange } ).

	fast2k := factory createSegadjTemporaryDeclaration.

	self assert: fast2k class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: fast2k declaredType class equals: FASTFortran2kIntegerType.
	self assert: fast2k declarators anyOne name equals: 'ooo_x'.
	self assert: fast2k declarators anyOne dimensions size equals: 1.
]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testCreateSeginiComponentInitialization [

	| fast2k factory paramFactory |
	factory := self makeFactory: FASTFortranDerivedTypeComponentFieldFactory.
	factory
		type: fastModel newIntegerType ;
		fieldDeclarator: (fastModel newVariableDeclarator
			name: 'x' ;
			dimensions: {  fastModel newArrayRange } ).

	paramFactory := self makeFactory: FASTFortranDerivedTypeParameterFieldFactory.
	paramFactory name: 'idim'.

	factory derivedTypeFactory: FASTFortranDerivedTypeFactory new.
	factory derivedTypeFactory model: fast2kModel.
	factory derivedTypeFactory privateFields: { factory . paramFactory }.
	factory derivedTypeFactory name: 'bar'.

	fast2k := factory createSeginiFieldInitialization.

	self assert: fast2k size equals: 2.

	self assert: fast2k first content equals: 'allocate(this%x(x_dim1(idim))'.
	self assert: fast2k second content equals: 'this%x(:) = segment_integer_default_value'.

]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testCreateSeginiParameterDeclaration [

	| fast2k factory |
	factory := self makeFactory: FASTFortranDerivedTypeParameterFieldFactory.
	factory name: 'x'.

	fast2k := factory createSeginiFieldDeclaration.

	self assert: fast2k class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: fast2k declarators anyOne name equals: 'x'.
	self assert: fast2k declaredType class equals: FASTFortran2kIntegerType
]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testCreateSeginiParameterInitialization [

	| fast2k factory |
	factory := self makeFactory: FASTFortranDerivedTypeParameterFieldFactory.
	factory name: 'x'.

	fast2k := factory createSeginiFieldInitialization.

	self assert: fast2k class equals: FASTFortran2kAssignmentStatement.

	self assert: fast2k variable class equals: FASTFortran2kDerivedTypeComponentAccess.
	self assert: fast2k variable instance name equals: 'this'.
	self assert: fast2k variable field name equals: 'x'.

	self assert: fast2k expression class equals: FASTFortran2kScalarVariable.
	self assert: fast2k expression name equals: 'x'.
]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testCreateSeginiThisFieldDeclaration [

	| fast2k factory |
	factory := (self makeFactory: FASTFortranDerivedTypeThisFieldFactory)
		name: 'this'.
	factory derivedTypeFactory: FASTFortranDerivedTypeFactory new.
	factory derivedTypeFactory model: fast2kModel.
	factory derivedTypeFactory fields: #().
	factory derivedTypeFactory name: 'bar'.

	fast2k := factory createSeginiFieldDeclaration.

	self assert: fast2k class equals: FASTFortran2kVariableDeclarationStatement.

	self assert: fast2k declarators size equals: 1.
	self assert: fast2k declarators anyOne name equals: 'this'.

	self assert: fast2k declaredType class equals: FASTFortran2kUserDefinedType.
	self assert: fast2k declaredType name equals: 'bar'.
]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testCreateSeginiThisFieldInitialization [

	| fast2k factory |
	factory := (self makeFactory: FASTFortranDerivedTypeThisFieldFactory)
		name: 'this'.

	fast2k := factory createSeginiFieldInitialization.

	self assert: fast2k class equals: FASTFortran2kFunctionCallStatement.
	self assert: fast2k name equals: 'allocate'.
	self assert: fast2k arguments size equals: 1.
	self assert: fast2k arguments anyOne class equals: FASTFortran2kScalarVariable.
	self assert: fast2k arguments anyOne name equals: 'this'.
]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testCreateSegmentComponentDeclaration [

	| fast2k factory |
	factory := self makeFactory: FASTFortranDerivedTypeComponentFieldFactory.
	factory 
		type: fastModel newIntegerType ;
		fieldDeclarator: (fastModel newVariableDeclarator
			name: 'x' ;
			dimensions: #() ).

	fast2k := factory createSegmentFieldDeclaration.

	self assert: fast2k class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: fast2k declaredType class equals: FASTFortran2kIntegerType.
	
	self assert: fast2k declarators size equals: 1.
	self assert: fast2k declarators anyOne name equals: 'x'.
	self assert: fast2k declarators anyOne dimensions size equals: 0.
]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testCreateSegmentParameterDeclaration [

	| fast2k factory |
	factory := self makeFactory: FASTFortranDerivedTypeParameterFieldFactory.
	factory name: 'x'.

	fast2k := factory createSegmentFieldDeclaration.

	self assert: fast2k class equals: FASTFortran2kVariableDeclarationStatement.

	self assert: fast2k declarators size equals: 1.
	self assert: fast2k declarators anyOne name equals: 'x'.

	self assert: fast2k modifiers size equals: 1.
	self assert: fast2k modifiers anyOne equals: 'private'.

	self assert: fast2k declaredType class equals: FASTFortran2kIntegerType
]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testCreateSegmentThisFieldDeclaration [

	| fast2k factory |
	factory := self makeFactory: FASTFortranDerivedTypeThisFieldFactory.

	fast2k := factory createSegmentFieldDeclaration.

	self assert: fast2k isNil
]
