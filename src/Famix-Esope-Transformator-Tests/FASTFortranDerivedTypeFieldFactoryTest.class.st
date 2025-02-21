Class {
	#name : 'FASTFortranDerivedTypeFieldFactoryTest',
	#superclass : 'TestCase',
	#instVars : [
		'factory',
		'fastModel'
	],
	#category : 'Famix-Esope-Transformator-Tests',
	#package : 'Famix-Esope-Transformator-Tests'
}

{ #category : 'running' }
FASTFortranDerivedTypeFieldFactoryTest >> setUp [
	| fast2kModel |
	super setUp.

	fastModel := FASTEsopeModel new.
	fast2kModel := FASTFortran2kModel new.

	factory := FASTFortranDerivedTypeFieldFactory new.
	factory derivedTypeFactory: (Mock named: 'FASTFrotranDerivedTypeFactory').
	factory derivedTypeFactory stub model willReturn: fast2kModel
]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testCreateSegmentComponentDeclaration [

	| fast2k |
	factory
		type: fastModel newIntegerType ;
		fieldDeclarator: (fastModel newVariableDeclarator
			name: 'x' ;
			dimensions: #() ).

	fast2k := factory createSegmentComponentDeclaration.

	self assert: fast2k class equals: FASTFortran2kDerivedTypeComponent.
	self assert: fast2k declarators anyOne name equals: 'x'.
	self assert: fast2k rank equals: 0.
	self assert: fast2k declaredType class equals: FASTFortran2kIntegerType
]

{ #category : 'tests' }
FASTFortranDerivedTypeFieldFactoryTest >> testCreateSegmentParameterDeclaration [

	| fast2k |
	factory
		fieldDeclarator: (fastModel newVariableDeclarator
			name: 'x' ).

	fast2k := factory createSegmentParameterDeclaration.

	self assert: fast2k class equals: FASTFortran2kDerivedTypeParameter.
	self assert: fast2k declarators anyOne name equals: 'x'.
	self assert: fast2k declaredType class equals: FASTFortran2kIntegerType
]
