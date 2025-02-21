Class {
	#name : 'FASTFortranBehavioralTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractTransformationVisitorTest',
	#instVars : [
		'parentVisitor'
	],
	#category : 'Famix-Esope-Transformator-Tests',
	#package : 'Famix-Esope-Transformator-Tests'
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
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kArrayFieldAccessElement [
	| stmt res |

	self programEmpty.

	stmt := FASTFortranFieldAccess new 
		pointer: (self scalarVariable: 'aPtr');
		field: (self arrayVariable: 'aField' indice: 2);
		yourself.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kDerivedTypeComponentAccess.
	self assert: res instance class equals: FASTFortran2kScalarVariable.
	self assert: res instance name equals: 'aPtr'.
	self assert: res field class equals: FASTFortran2kArrayVariable.
	self assert: res field name equals: 'aField'.
	self assert: res field indices size equals: 1.
	self assert: res field indices anyOne class equals: FASTFortran2kIntegerLiteral.
	self assert: res field indices anyOne primitiveValue equals: 2.
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kArrayFieldAccessSize [
	| stmt res expression argument |

	self programEmpty.

	expression := FASTFortranArrayVariable new
		name: 'aField' ;
		indices: { self unary: '/' operand: (self integerLiteral: 2) };
		yourself.

	stmt := FASTFortranFieldAccess new 
		pointer: (self scalarVariable: 'aPtr');
		field: expression;
		yourself.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kFunctionCall.
	self assert: res name equals: 'size'.
	self assert: res arguments size equals: 2.

	argument := res arguments first.
	self assert: argument class equals: FASTFortran2kDerivedTypeComponentAccess.
	self assert: argument instance class equals: FASTFortran2kScalarVariable.
	self assert: argument field class equals: FASTFortran2kScalarVariable.

	argument := res arguments second.
	self assert: argument class equals: FASTFortran2kIntegerLiteral.
	self assert: argument primitiveValue equals: 2.
	
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kArrayVariable [
	| stmt res indice |

	stmt := self arrayVariable: #b indice: '1'.
	
	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kArrayVariable.
	self assert: res name equals: 'b'.
	self assert: res indices size equals: 1.
	
	indice := res indices anyOne.
	
	self assert: indice class equals: FASTFortran2kIntegerLiteral.
	self assert: indice primitiveValue equals: '1'
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kAssignementStatement [
	| stmt res |

	self skip: 'firts, need to correct binding of FASTAssignement to FamixAccess'.

	stmt := FASTFortranAssignmentStatement new.
	stmt famix: FamixF77Access new.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kAssignmentStatement.
	self assert: res backTrace isNotNil.
	self assert: res backTrace class equals: FamixF77Access.
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kAsterisk [
	| stmt res |

	stmt := FASTFortranAsterisk new.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kAsterisk.

	
	
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kCallStatementNoArguments [
	| stmt res invok |

	self programEmpty.
	self subroutineEmpty.

	stmt := FASTFortranCallStatement new name: 'subrtn'.
	fastMainProgram statementBlock addStatement: stmt.
	invok := FamixF77Invocation new
		sender: fastMainProgram famix ;
		candidates: { fastProcedures anyOne famix }.
	stmt famix: invok.


	res := fastMainProgram accept: visitor.

	res := res programUnits anyOne statementBlock statements
		detect: [:fast2kstatement | fast2kstatement class = FASTFortran2kCallStatement].
	self assert: res name equals: 'subrtn'.

	self assert: res backTrace isNotNil.
	self assert: res backTrace class equals: FamixF77Invocation.
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kCloseStatement [
	| stmt res |

	stmt := FASTFortranCloseStatement new.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kCloseStatement.

]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kContinueStatement [
	| stmt res |

	stmt := FASTFortranContinueStatement new label: '42'.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kContinueStatement.
	self assert: res label equals: '42'
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
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kGoToStatement [
	| stmt res entity |

	stmt := self gotoStatement: 100.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kGoToStatement.
	self assert: res labelReferences size equals: 1.
	
	entity := res labelReferences anyOne.
	self assert: entity class equals: FASTFortran2kLabelReference.
	self assert: entity label equals: '100'
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
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kIfLogicalStatement [

	| stmt res entity |
	stmt := self
		logicalIf: (self binary: '.lt.' left: #x right: 5)
		statement: (self assignementStatement: #x value: 5).

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kIfLogicalStatement.

	entity := res condition.
	self assert: entity class equals: FASTFortran2kBinaryExpression.
	self assert: entity operator equals: '.lt.'.
	self assert: entity leftOperand class equals: FASTFortran2kScalarVariable.
	self assert: entity rightOperand class equals: FASTFortran2kIntegerLiteral.

	entity := res statement.
	self assert: entity class equals: FASTFortran2kAssignmentStatement.
	self assert: entity variable name equals: 'x'.
	self assert: entity expression class equals: FASTFortran2kIntegerLiteral.

]

{ #category : 'tests-expression' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kImpliedDoExpression [
	| res expression entity |

	self programEmpty.

	expression := FASTFortranImpliedDoExpression new
		loopControl: (self loopControlInit: #(i 1) increment: 1 limit: #max) ;
		variables: (self scalarVariables: #(v)) .

	res := expression accept: visitor.

	self assert: res class equals: FASTFortran2kImpliedDoExpression.

	entity := res loopControl.
	self assert: entity class equals: FASTFortran2kLoopControlExpression.
	self assert: entity init class equals: FASTFortran2kAssignmentExpression.
	self assert: entity init variable class equals: FASTFortran2kScalarVariable.
	self assert: entity init expression class equals: FASTFortran2kIntegerLiteral.
	self assert: entity increment class equals: FASTFortran2kIntegerLiteral.
	self assert: entity limit class equals: FASTFortran2kScalarVariable.
	
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kOpenStatement [
	| stmt res entity |

	stmt := FASTFortranOpenStatement new
		ioParameters: {
			self integerLiteral: '3' .
			self ioParameter: #file value: 'projectA/data.test'.
			self ioParameter: #err value: 99
		}.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kOpenStatement.
	self assert: res ioParameters size equals: 3.

	entity := res ioParameters first.
	self assert: entity class equals: FASTFortran2kIntegerLiteral.
	self assert: entity primitiveValue equals: '3'.

	entity := res ioParameters second.
	self assert: entity class equals: FASTFortran2kIOParameter.
	self assert: entity name equals: 'file'.
	self assert: entity expression class equals: FASTFortran2kCharacterLiteral.
	self assert: entity expression primitiveValue equals: 'projectA/data.test'.

	entity := res ioParameters third.
	self assert: entity class equals: FASTFortran2kIOParameter.
	self assert: entity name equals: 'err'.
	self assert: entity expression class equals: FASTFortran2kIntegerLiteral.
	self assert: entity expression primitiveValue equals: '99'.


]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kReadStatement [
	| stmt res entity |

	stmt := self readStatement: #( 'x' ).

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kReadStatement.
	self assert: res ioParameters size equals: 2.
	self assert: res arguments size equals: 1.

	entity := res arguments anyOne.
	self assert: entity class equals: FASTFortran2kCharacterLiteral.
	self assert: entity primitiveValue equals: 'x'.

	self assert: res ioParameters first class equals: FASTFortran2kAsterisk.
	self assert: res ioParameters second class equals: FASTFortran2kAsterisk.

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
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kScalarFieldAccess [
	| stmt res |

	self programEmpty.

	stmt := FASTFortranFieldAccess new 
		pointer: (self scalarVariable: 'aPtr');
		field: (self scalarVariable: 'aField');
		yourself.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kDerivedTypeComponentAccess.
	self assert: res instance class equals: FASTFortran2kScalarVariable.
	self assert: res instance name equals: 'aPtr'.
	self assert: res field class equals: FASTFortran2kScalarVariable.
	self assert: res field name equals: 'aField'.
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kStopStatement [

	| stmt res |
	stmt := FASTFortranStopStatement new
		displayArgument: '''error''' ;
		yourself.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kStopStatement.
	self assert: res displayArgument equals: '''error'''.
]

{ #category : 'tests-expression' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kUnaryExpression [
	| res expression |

	self programEmpty.

	expression := self unary: '/' operand: (self integerLiteral: 2).

	res := expression accept: visitor.

	self assert: res class equals: FASTFortran2kUnaryExpression.
	self assert: res operator equals: '/'.
	self assert: res expression class equals: FASTFortran2kIntegerLiteral.
	self assert: res expression primitiveValue equals: 2.
	
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeToF2kVariableDeclarationStatement [
	| res |

	self programWithDeclarationStatement.
	fastMainProgram statementBlock statements anyOne declarators anyOne
		famixDeclaration: (FamixF77Variable new name: 'str').

	res := fastMainProgram accept: visitor.

	res := res programUnits anyOne statementBlock statements
		detect: [:fast2kstatement | fast2kstatement class = FASTFortran2kVariableDeclarationStatement].
	self assert: res declarators anyOne name equals: 'str'.

	self assert: res backTrace isNotNil.
	self assert: res backTrace class equals: FamixVirtualBackTrace.
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
	"Some visit need a Program Unit container (in the visitor's stack)
	 In this case, the test must use a FamixF77PUMain"

	^FASTFortranMainTransformationVisitor 
]
