Class {
	#name : 'FASTFortranBehavioralTransformationVisitorTest',
	#superclass : 'FASTEsopeAbstractTransformationVisitorTest',
	#instVars : [
		'parentVisitor'
	],
	#category : 'Famix-Esope-Transformator-Tests-Visitors',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Visitors'
}

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> includeStatement: filename [

	| entity |
	entity := FamixF77ProgramFile new filename: filename.
	entity := FamixF77IncludedFile new programFile: entity.
	entity := FamixF77Include new included: entity.

	^FASTEsopeIncludeStatement new
		filename: 'included/file' ;
		famixInclude: entity ;
		startPos: 5 ;
		endPos: 42.
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testArrayDeclaration [
	| stmt dst |
	stmt := self arrayDeclaration: 'v' dimensions: #( #('1' '10') ).
	
	dst := stmt accept: visitor.

	self
		assert: dst class
		equals: FASTFortran2kVariableDeclarationStatement.
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testArrayFieldAccessElement [
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
FASTFortranBehavioralTransformationVisitorTest >> testArrayFieldAccessSize [
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
FASTFortranBehavioralTransformationVisitorTest >> testArrayVariable [
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
FASTFortranBehavioralTransformationVisitorTest >> testAssignementStatementFunctionValue [
	"in case of assigning the return value of a function, there is no famixVariable
	 associated to the FAST variable"
	| stmt res |
	stmt := self assignementStatement: #aVar value: (self logicalLiteral: '.true.').
	
	res := stmt accept: visitor.
	
	self assert: res class equals: FASTFortran2kAssignmentStatement.
	self assert: res variable class equals: FASTFortran2kScalarVariable.
	self assert: res expression class equals: FASTFortran2kBooleanLiteral.
	
	self assert: res variable name equals: 'aVar'.
	self assert: res expression primitiveValue equals: '.true.'.
]

{ #category : 'tests-statement' }
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

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testAssignementStatementPointer [
	| stmt res |
	stmt := self assignementStatement: #aVar value: (self scalarVariable: 'p').
	stmt variable famixVariable: (FamixF77Variable new
		declaredType: (FamixEsopeSegment new)).
	
	res := stmt accept: visitor.
	
	self assert: res class equals: FASTFortran2kPointerAssignmentStatement.
	self assert: res variable class equals: FASTFortran2kScalarVariable.
	self assert: res expression class equals: FASTFortran2kScalarVariable.
	
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testAssignementStatementToFieldAccess [
	| stmt res fieldAccess |
	fieldAccess := FASTFortranFieldAccess new
		field: (self scalarVariable: 'att') ;
		pointer: (self scalarVariable: 'aPtr') .
	stmt := FASTFortranAssignmentStatement new
		variable: fieldAccess ;
		expression: (self makeSimpleExpression: (self logicalLiteral: '.true.')).
	
	res := stmt accept: visitor.
	
	self assert: res class equals: FASTFortran2kAssignmentStatement.
	self assert: res variable class equals: FASTFortran2kDerivedTypeComponentAccess.
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testAsterisk [
	| stmt res |

	stmt := FASTFortranAsterisk new.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kAsterisk.

	
	
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testCloseStatement [
	| stmt res |

	stmt := FASTFortranCloseStatement new.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kCloseStatement.

]

{ #category : 'tests' }
FASTFortranBehavioralTransformationVisitorTest >> testComment [
	| cmt dst |
	cmt := self comment: 'This is a comment'.
	
	dst := cmt accept: visitor.
	
	self assert: dst class equals: FASTFortran2kComment.
	self assert: dst content equals: 'This is a comment'.
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testContinueStatement [
	| stmt res |

	stmt := FASTFortranContinueStatement new label: '42'.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kContinueStatement.
	self assert: res label equals: '42'
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

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> testEsopeCommandSegini [

	| dst segCommand |
	segCommand := self segmentCommand: FASTEsopeSegini with: { #v }.

	dst := segCommand accept: visitor.

	self assert: dst class equals: FASTFortran2kCallStatement.
	self assert: dst name equals: 'segini'.
	self assert: dst arguments size equals: 1
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testExitStatement [
	| stmt res |

	stmt := FASTFortranExitStatement new.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kExitStatement.

]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testExternalDeclaration [
	| stmt res |

	stmt := FASTFortranExternalStatement new name: 'anExternal'.

	self assert: visitor externalDeclared isEmpty.

	res := stmt accept: visitor.

	self assert: res isNil.

	self assert: visitor externalDeclared size equals: 1.
	self assert: visitor externalDeclared anyOne equals: 'anExternal'

	
	
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testGoToStatement [
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
FASTFortranBehavioralTransformationVisitorTest >> testIfBlockStatement [

	| stmt res entity |
	stmt := self
		ifBlock: (self binary: '.le.' left: #x right: 5)
		then: { self returnStatement: nil } 
		else: { self comment: 'this is the else' }.

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
	self assert: entity statements anyOne class equals: FASTFortran2kComment.
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testIfBlockStatementEmpty [

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
FASTFortranBehavioralTransformationVisitorTest >> testIfLogicalStatement [

	| stmt res entity |
	stmt := self
		logicalIf: (self binary: '.lt.' left: #x right: 5)
		statement: (self returnStatement: nil).

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kIfLogicalStatement.

	entity := res condition.
	self assert: entity class equals: FASTFortran2kBinaryExpression.
	self assert: entity operator equals: '.lt.'.
	self assert: entity leftOperand class equals: FASTFortran2kScalarVariable.
	self assert: entity rightOperand class equals: FASTFortran2kIntegerLiteral.

	entity := res statement.
	self assert: entity class equals: FASTFortran2kReturnStatement
]

{ #category : 'tests-expression' }
FASTFortranBehavioralTransformationVisitorTest >> testImpliedDoExpression [
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
FASTFortranBehavioralTransformationVisitorTest >> testIncludedStatementEmpty [

	| stmt res |
	stmt := self includeStatement: 'included/file.f'.
	visitor parentTransformator includedFiles at: 'included/file.f' put: #().

	res := stmt accept: visitor.

	self assert: res size equals: 1.
	res := res anyOne.
	
	self assert: res class equals: FASTFortran2kComment.
	self assert: res content equals: '[ooo] empty #include included/file'.
	self assert: res startPos equals: 5.
	self assert: res endPos equals: 39

]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testIncludedStatementOnlyComments [

	| stmt res |
	stmt := self includeStatement: 'included/file.f'.
	visitor parentTransformator includedFiles at: 'included/file.f' put: {
		FASTFortran2kComment new .
		FASTFortran2kComment new .
	}.

	res := stmt accept: visitor.

	self assert: res size equals: 1.
	res := res anyOne.
	
	self assert: res class equals: FASTFortran2kComment.
	self assert: res content equals: '[ooo] empty #include included/file'.
	self assert: res startPos equals: 5.
	self assert: res endPos equals: 39

]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testIncludedStatementWithVariableDeclaration [

	| stmt res entity |
	stmt := self includeStatement: 'included/file.f'.
	visitor parentTransformator includedFiles at: 'included/file.f' put: {
		FASTFortran2kVariableDeclarationStatement new
	}.

	res := stmt accept: visitor.

	self assert: res size equals: 3.

	entity := res first.
	self assert: entity class equals: FASTFortran2kComment.
	self assert: entity content equals: '[ooo] #include included/file'.

	entity := res second.
	self assert: entity class equals: FASTFortran2kVariableDeclarationStatement.

	entity := res third.
	self assert: entity class equals: FASTFortran2kComment.
	self assert: entity content equals: '[ooo] #end-include included/file'.


]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testOpenStatement [
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
FASTFortranBehavioralTransformationVisitorTest >> testReadStatement [
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
FASTFortranBehavioralTransformationVisitorTest >> testReturnStatement [

	| stmt res |
	stmt := self returnStatement: 2.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kReturnStatement.
	self assert: res expression class equals: FASTFortran2kIntegerLiteral.
	self assert: res expression primitiveValue equals: '2'
]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testScalarFieldAccess [
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
FASTFortranBehavioralTransformationVisitorTest >> testStopStatement [

	| stmt res |
	stmt := FASTFortranStopStatement new
		displayArgument: '''error''' ;
		yourself.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kStopStatement.
	self assert: res displayArgument equals: '''error'''.
]

{ #category : 'tests-expression' }
FASTFortranBehavioralTransformationVisitorTest >> testUnaryExpression [
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
FASTFortranBehavioralTransformationVisitorTest >> testVariableDeclarationForExternal [
	| stmt res |

	stmt := FASTFortranVariableDeclarationStatement new
		declarators: { self variableDeclarator: 'var' } ;
		declaredType: FASTFortranIntegerType new.
	visitor externalDeclared: { 'var' }.

	res := stmt accept: visitor.

	self assert: res isNil.

]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testVariableDeclarationsSomeExternal [
	| stmt res |

	stmt := FASTFortranVariableDeclarationStatement new
		declarators: { self variableDeclarator: 'var' .self variableDeclarator: 'otherVar' } ;
		declaredType: FASTFortranIntegerType new.
	visitor externalDeclared: { 'var' }.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: res declarators size equals: 1.
	self assert: res declarators anyOne name equals: 'otherVar'

]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testkCloseStatement [
	| stmt res |

	stmt := FASTFortranCloseStatement new
		ioParameters: { self assignementExpression: #unit value: #libunt } .

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kCloseStatement.
	self assert: res ioParameters size equals: 1.

	self assert: res ioParameters first class equals: FASTFortran2kAssignmentExpression.

]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testkOpenStatement [
	| stmt res |

	stmt := FASTFortranOpenStatement new
		ioParameters: { self assignementExpression: #unit value: #libunt } .

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kOpenStatement.
	self assert: res ioParameters size equals: 1.

	self assert: res ioParameters first class equals: FASTFortran2kAssignmentExpression.

]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testkWriteStatement [
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
FASTFortranBehavioralTransformationVisitorTest >> testprefixCallWithType [
	"prefix call to actstr with the name of the type of the variable it is assigned to"

	| res stmt |
	stmt := self assignementStatement: 'ptr' value: (self
		functionCall: 'mypnt' arguments: #( whatever )).
	stmt variable famixVariable: (FamixF77Variable new
		declaredType: (FamixEsopeSegment new
			name: 'seg')).

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kPointerAssignmentStatement.
	self assert: res expression class equals: FASTFortran2kFunctionCall.
	self assert: res expression name equals: 'seg_mypnt'
]

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> visitorClass [ 

	^FASTFortranBehavioralTransformationVisitor 
]
