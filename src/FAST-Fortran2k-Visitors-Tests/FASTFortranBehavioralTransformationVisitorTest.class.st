Class {
	#name : 'FASTFortranBehavioralTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractTransformationVisitorTest',
	#instVars : [
		'parentVisitor'
	],
	#category : 'FAST-Fortran2k-Visitors-Tests',
	#package : 'FAST-Fortran2k-Visitors-Tests'
}

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> testArrayDeclaration [
	| stmt dst |
	stmt := self arrayDeclaration: 'v' dimensions: #( #('1' '10') ).
	
	dst := stmt accept: visitor.

	self
		assert: dst class
		equals: FASTFortran2kVariableDeclarationStatement.
]

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> testAssignementStatementLiteralValue [
	| stmt res |
	stmt := self assignementStatement: #aVar value: (self logicalLiteral: '.true.').
	
	res := stmt accept: visitor.
	
	self assert: res class equals: FASTFortran2kAssignmentStatement.
	self assert: res variable class equals: FASTFortran2kScalarVariable.
	self assert: res expression class equals: FASTFortran2kBooleanLiteral.
	
	self assert: res variable name equals: 'aVar'.
	self assert: res expression primitiveValue equals: '.true.'.
]

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> testComment [
	| cmt dst |
	cmt := self comment: 'This is a comment'.
	
	dst := cmt accept: visitor.
	
	self assert: dst class equals: FASTFortran2kComment.
	self assert: dst content equals: 'This is a comment'.
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testDoStatement [
	| stmt res loopControl |

	stmt := self doStatement: #(i 1 max 1) statements: #().
	
	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kDoStatement.
	
	loopControl := res loopControl.
	
	self assert: loopControl class equals: FASTFortran2kLoopControlExpression.
	self assert: loopControl init class equals: FASTFortran2kAssignmentExpression.
	self assert: loopControl init variable class equals: FASTFortran2kScalarVariable.
	self assert: loopControl init expression class equals: FASTFortran2kIntegerLiteral.
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kExternalStatement [
	| stmt res |

	self programEmpty.

	stmt := (self externalStatement: 'mypnt').
	fastMainProgram statementBlock addStatement: stmt.
	stmt famix: (
		FamixF77ExternalDeclaration new 
			name: 'mypnt'; 
			programUnit: fastMainProgram famix; 
			yourself
	).

	res := stmt accept: visitor.

	self assert: res isNil.
	self assert: visitor parentTransformator usesNeeded size equals: 1.
	self assert: visitor parentTransformator usesNeeded anyOne key equals: fastMainProgram famix.
	self assert: visitor parentTransformator usesNeeded anyOne value isNil.
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kIfBlockStatement [

	| stmt res entity |
	stmt := self
		ifBlock: (self binary: '.le.' left: #x right: 5)
		then: { self returnStatement: nil } 
		else: { self assignementStatement: #x value: 5 }.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kIfBlockStatement.

	entity := res condition.
	self assert: entity class equals: FASTFortran2kBinaryExpression.
	self assert: entity operator equals: '.le.'.
	self assert: entity leftOperand class equals: FASTFortran2kScalarVariable.
	self assert: entity rightOperand class equals: FASTFortran2kIntegerLiteral.

	entity := res thenStatementBlock.
	self assert: entity statements size equals: 1.
	self assert: entity statements anyOne class equals: FASTFortran2kReturnStatement.
	self assert: entity statements anyOne expression isNil.

	entity := res elseStatementBlock.
	self assert: entity statements size equals: 1.
	self assert: entity statements anyOne class equals: FASTFortran2kAssignmentStatement.
	self assert: entity statements anyOne variable name equals: 'x'.
	self assert: entity statements anyOne expression class equals: FASTFortran2kIntegerLiteral.

]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kIfBlockStatementEmpty [

	| stmt res |
	stmt := self ifBlock: (self binary: '.gt.' left: #y right: 5) then: #() else:  #().

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kIfBlockStatement.
	self assert: res condition class equals: FASTFortran2kBinaryExpression.
	self assert: res condition operator equals: '.gt.'.
	self assert: res thenStatementBlock statements size equals: 0.
	self assert: res elseStatementBlock statements size equals: 0.
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kReturnStatement [

	| stmt res |
	stmt := self returnStatement: 2.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kReturnStatement.
	self assert: res expression class equals: FASTFortran2kIntegerLiteral.
	self assert: res expression primitiveValue equals: '2'
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kWriteStatement [
	| stmt res entity |

	stmt := self writeStatement: #( 'message' ).

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kWriteStatement.
	self assert: res ioParameters size equals: 2.
	self assert: res arguments size equals: 1.

	entity := res arguments anyOne.
	self assert: entity class equals: FASTFortran2kCharacterLiteral.
	self assert: entity primitiveValue equals: 'message'.

	self assert: res ioParameters first class equals: FASTFortran2kAsterisk.
	self assert: res ioParameters second class equals: FASTFortran2kAsterisk.

]

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> visitorClass [ 

	^FASTFortranBehavioralTransformationVisitor 
]
