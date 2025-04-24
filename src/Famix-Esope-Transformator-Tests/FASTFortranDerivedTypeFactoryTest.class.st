Class {
	#name : 'FASTFortranDerivedTypeFactoryTest',
	#superclass : 'FASTFortranDerivedTypeAbstractFactoryTest',
	#category : 'Famix-Esope-Transformator-Tests-Segment',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Segment'
}

{ #category : 'tests' }
FASTFortranDerivedTypeFactoryTest >> testMakeProcedureSegloc [
	| segloc |

	segFactory name: 'blah'.

	segloc := segFactory makeProcedureSegloc.

	self assert: segloc class equals: FASTFortran2kFunction.
	self assert: segloc name equals: 'blah_segloc'.

	self assert: segloc parameters size equals: 1.
	self assert: segloc parameters anyOne name equals: 'this'.

	self assert: segloc declaredType class equals: FASTFortran2kSpecialIntrinsicType.
	self assert: segloc statementBlock statements size equals: 9
]

{ #category : 'tests' }
FASTFortranDerivedTypeFactoryTest >> testMakeSegadjCheckParamsChanged [
	| statements |
	(self makeFactory: FASTFortranDerivedTypeParameterFieldFactory)
		name: 'aSegmentParam'.

	statements := segFactory makeSegadjCheckParamsChanged.

	self assert: statements size equals: 3.
	self assert: statements first class equals: FASTFortran2kFormattedCodeString.
	self assert: statements second class equals: FASTFortran2kSourceCodeString.
	self assert: statements third class equals: FASTFortran2kEmptyStatement.
]

{ #category : 'tests' }
FASTFortranDerivedTypeFactoryTest >> testMakeSegadjLocalDeclarations [
	| statements expectedStatments |

	statements := segFactory makeSegadjLocalDeclarations.

	expectedStatments := 	{
		FASTFortran2kEmptyStatement .
		FASTFortran2kSourceCodeString .	"'logical :: ooo_eq_dims'"
		FASTFortran2kSourceCodeString .	"'logical :: ooo_eq_pars'"
		FASTFortran2kEmptyStatement
	}.

	self assert: statements size equals: expectedStatments size.
	statements 
		with: expectedStatments
		do: [ :actual :expected |
			self assert: actual class equals: expected
		]

]

{ #category : 'tests' }
FASTFortranDerivedTypeFactoryTest >> testMakeSegadjLocalDeclarations1Component [
	| statements expectedStatments|

	(self makeFactory: FASTFortranDerivedTypeComponentFieldFactory)
		name: 'segmentField' ;
		type: (fastModel newIntegerType) ;
		privateRank: 1.

	statements := segFactory makeSegadjLocalDeclarations.

	expectedStatments := 	{
		FASTFortran2kEmptyStatement .
		FASTFortran2kFormattedCodeString . "declareMaxRankTemporaries: 'ooo_dim'"
		FASTFortran2kFormattedCodeString . "declareMaxRankTemporaries: 'ooo_stop'"
		FASTFortran2kVariableDeclarationStatement .
		FASTFortran2kSourceCodeString .	"'logical :: ooo_eq_dims'"
		FASTFortran2kSourceCodeString .	"'logical :: ooo_eq_pars'"
		FASTFortran2kEmptyStatement
	}.

	self assert: statements size equals: expectedStatments size.
	statements 
		with: expectedStatments
		do: [ :actual :expected |
			self assert: actual class equals: expected
		]

]

{ #category : 'tests' }
FASTFortranDerivedTypeFactoryTest >> testMakeSegadjLocalDeclarations1Parameter [
	| statements expectedStatments|

	(self makeFactory: FASTFortranDerivedTypeParameterFieldFactory)
		name: 'aSegmentParam'.

	statements := segFactory makeSegadjLocalDeclarations.

	expectedStatments := 	{
		FASTFortran2kVariableDeclarationStatement .  "FASTFortranDerivedTypeParameterFieldFactory >> createSegcmdInFieldDeclaration"
		FASTFortran2kEmptyStatement .
		FASTFortran2kSourceCodeString .	"'logical :: ooo_eq_dims'"
		FASTFortran2kSourceCodeString .	"'logical :: ooo_eq_pars'"
		FASTFortran2kEmptyStatement
	}.

	self assert: statements size equals: expectedStatments size.
	statements 
		with: expectedStatments
		do: [ :actual :expected |
			self assert: actual class equals: expected
		]

]

{ #category : 'tests' }
FASTFortranDerivedTypeFactoryTest >> testRankMax [

	(self makeFactory: FASTFortranDerivedTypeComponentFieldFactory)
		privateRank: 1.
	(self makeFactory: FASTFortranDerivedTypeComponentFieldFactory)
		privateRank: 2.

	self assert: segFactory rankMax equals: 2
]

{ #category : 'tests' }
FASTFortranDerivedTypeFactoryTest >> testRankMaxEmpty [

	self makeFactory: FASTFortranDerivedTypeParameterFieldFactory.

	self assert: segFactory rankMax equals: 0
]
