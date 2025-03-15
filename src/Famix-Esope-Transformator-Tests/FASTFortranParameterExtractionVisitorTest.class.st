Class {
	#name : 'FASTFortranParameterExtractionVisitorTest',
	#superclass : 'TestCase',
	#instVars : [
		'visitor'
	],
	#classInstVars : [
		'visitor'
	],
	#category : 'Famix-Esope-Transformator-Tests-Segment',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Segment'
}

{ #category : 'running' }
FASTFortranParameterExtractionVisitorTest >> setUp [
	super setUp.

	"Put here a common initialization logic for tests"
	visitor := FASTFortranParameterExtractionVisitor new
]

{ #category : 'tests' }
FASTFortranParameterExtractionVisitorTest >> testExpressionSameVariable [

	| entity res |
	entity := FASTFortranArrayRange new 
		upperBound: (FASTFortranBinaryExpression new 
			operator: '+';
			leftOperand: (FASTFortranScalarVariable new name: 'N');
			rightOperand: (FASTFortranScalarVariable new name: 'N');
			yourself
		);
		yourself.
	
	res := entity accept: visitor.
	
	self assert: res size equals: 1.
	self assert: res anyOne equals: 'N'


]

{ #category : 'tests' }
FASTFortranParameterExtractionVisitorTest >> testExpressionUpperBound [

	| entity res |
	entity := FASTFortranArrayRange new 
		upperBound: (FASTFortranBinaryExpression new 
			operator: '+';
			leftOperand: (FASTFortranScalarVariable new name: 'M');
			rightOperand: (FASTFortranScalarVariable new name: 'N');
			yourself
		);
		yourself.
	
	res := entity accept: visitor.

	self assertCollection: res hasSameElements: #(N M)


]

{ #category : 'tests' }
FASTFortranParameterExtractionVisitorTest >> testSimpleExpressionUpperBound [

	| entity res |
	entity := FASTFortranArrayRange new 
		upperBound: (FASTFortranBinaryExpression new 
			operator: '+';
			leftOperand: (FASTFortranScalarVariable new name: 'M');
			rightOperand: (FASTFortranIntegerLiteral new primitiveValue: '1');
			yourself
		);
		yourself.
	
	res := entity accept: visitor.
	
	self assert: res size equals: 1.
	self assert: res anyOne equals: 'M'


]

{ #category : 'tests' }
FASTFortranParameterExtractionVisitorTest >> testSimpleVariableLowerAndUpperBound [

	| entity res |
	entity := FASTFortranArrayRange new 
		lowerBound: (FASTFortranScalarVariable new name: 'N');
		upperBound: (FASTFortranScalarVariable new name: 'M');
		yourself.
	
	res := entity accept: visitor.

	self assertCollection: res hasSameElements: #(N M)

]

{ #category : 'tests' }
FASTFortranParameterExtractionVisitorTest >> testSimpleVariableUpperBound [

	| entity res |
	entity := FASTFortranArrayRange new 
		upperBound: (FASTFortranScalarVariable new name: 'N');
		yourself.
	
	res := entity accept: visitor.
	
	self assert: res size equals: 1.
	self assert: res anyOne equals: 'N'

]
