Class {
	#name : 'FASTFortranDerivedTypeFieldFactoryTest',
	#superclass : 'FASTFortranDerivedTypeAbstractFactoryTest',
	#category : 'Famix-Esope-Transformator-Tests',
	#package : 'Famix-Esope-Transformator-Tests'
}

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
FASTFortranDerivedTypeFieldFactoryTest >> testComponentAsFieldAccess1RankWithSlicing [

	| string factory |
	factory := self makeFactory: FASTFortranDerivedTypeComponentFieldFactory.
	factory 
		type: fastModel newIntegerType ;
		fieldDeclarator: (fastModel newVariableDeclarator
			name: 'x' ;
			dimensions: {  fastModel newArrayRange } ).

	string := factory asFieldAccess: 'oo'.

	self assert: string equals: 'x(:oo1)'
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

	string := factory asFieldAccess: ''.

	self assert: string equals: 'x(:, :, :)'
]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testComponentAsFieldAccess3RankWithSlicing [

	| string factory |
	factory := self makeFactory: FASTFortranDerivedTypeComponentFieldFactory.
	factory 
		type: fastModel newIntegerType ;
		fieldDeclarator: (fastModel newVariableDeclarator
			name: 'x' ;
			dimensions: { fastModel newArrayRange . fastModel newArrayRange . fastModel newArrayRange } ).

	string := factory asFieldAccess: 'stop'.

	self assert: string equals: 'x(:stop1, :stop2, :stop3)'
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
FASTFortranDerivedTypeFieldFactoryTest >> testCreateSegcmdInParameterDeclaration [

	| fast2k factory |
	factory := self makeFactory: FASTFortranDerivedTypeParameterFieldFactory.
	factory name: 'x'.

	fast2k := factory createSegcmdInFieldDeclaration.

	self assert: fast2k class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: fast2k declaredType class equals: FASTFortran2kIntegerType.
	self assertCollection: fast2k modifiers hasSameElements: #( 'intent(in)' ).
	self assert: fast2k declarators anyOne name equals: 'x'.
]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testCreateSegcmdInoutThisFieldDeclaration [

	| fast2k factory |
	factory := (self makeFactory: FASTFortranDerivedTypeThisFieldFactory)
		name: 'this'.
	factory derivedTypeFactory: FASTFortranDerivedTypeFactory new.
	factory privateDerivedTypeFactory model: fast2kModel.
	factory privateDerivedTypeFactory fields: #().
	factory privateDerivedTypeFactory name: 'bar'.

	fast2k := factory createSegcmdInoutFieldDeclaration.

	self assert: fast2k class equals: FASTFortran2kVariableDeclarationStatement.
	self assertCollection: fast2k modifiers hasSameElements: #( pointer 'intent(inout)' ).

	self assert: fast2k declarators size equals: 1.
	self assert: fast2k declarators anyOne name equals: 'this'.

	self assert: fast2k declaredType class equals: FASTFortran2kUserDefinedType.
	self assert: fast2k declaredType name equals: 'bar'.
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
	factory privateDerivedTypeFactory model: fast2kModel.
	factory privateDerivedTypeFactory privateFields: { factory . paramFactory }.
	factory privateDerivedTypeFactory name: 'bar'.

	fast2k := factory createSeginiFieldInitialization.

	self assert: fast2k size equals: 3.

	"ooo_dim1 = x_dim1(idim)"
	self assert: fast2k first class equals: FASTFortran2kAssignmentStatement.
	self assert: fast2k first variable name equals: 'ooo_dim1'.
	self assert: fast2k first expression class equals: FASTFortran2kFunctionCall.

	"allocate(this%x(ooo_dim1)"
	self assert: fast2k second class equals: FASTFortran2kFunctionCallStatement.
	self assert: fast2k second name equals: 'allocate'.
	self assert: fast2k second arguments size equals: 1.

	"this%x(:) = segment_integer_default_value"
	self assert: fast2k third class equals: FASTFortran2kAssignmentStatement.
	self assert: fast2k third variable class equals: FASTFortran2kDerivedTypeComponentAccess.
	self assert: fast2k third expression class equals: FASTFortran2kScalarVariable

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

	self assert: fast2k modifiers size equals: 1.
	self assert: fast2k modifiers anyOne equals: 'public'.

	self assert: fast2k declarators size equals: 1.
	self assert: fast2k declarators anyOne name equals: 'x'.
	self assert: fast2k declarators anyOne dimensions size equals: 0.
]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testCreateSegmentComponentDeclarationWithDim [

	| fast2k factory |
	factory := self makeFactory: FASTFortranDerivedTypeComponentFieldFactory.
	factory 
		type: fastModel newIntegerType ;
		fieldDeclarator: (fastModel newVariableDeclarator
			name: 'x' ;
			addDimension: (fastModel newArrayRange upperBound: (fastModel newScalarVariable name: 'dim1')) ;
			yourself
		).

	fast2k := factory createSegmentFieldDeclaration.

	self assert: fast2k class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: fast2k declaredType class equals: FASTFortran2kIntegerType.
	
	self assert: fast2k modifiers size equals: 2.
	self assert: fast2k modifiers first equals: 'pointer'.
	self assert: fast2k modifiers second equals: 'public'.

	self assert: fast2k declarators size equals: 1.
	self assert: fast2k declarators anyOne name equals: 'x'.
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
