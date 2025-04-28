Class {
	#name : 'FASTEsopeUnassignedVariableRuleTest',
	#superclass : 'FASTFortran2kAbstractVisitorTest',
	#category : 'Famix-Esope-Transformator-Tests-Simplification',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Simplification'
}

{ #category : 'running' }
FASTEsopeUnassignedVariableRuleTest >> newVisitor [

	^FASTEsopeUnassignedVariableRule new
]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testAjpntCallNotToSimplify [

	| body ajpntCallStatement model |

	model := FASTFortran2kModel new.

	ajpntCallStatement := (self callStatement: #ajpnt arguments: #(jord))
		mooseModel: model.

	self subroutine: #sub.
	self addStatement: ((self declarationStatement: #jord type: #integer)
		mooseModel: model).
	self addStatement: ajpntCallStatement.

	visitor simplify: ast.

	body := ast statementBlock statements.

	self assert: body size equals: 2.

	self assert: body first class equals: FASTFortran2kVariableDeclarationStatement.

	self assert: body second class equals: FASTFortran2kCallStatement

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testArrayVariableAssignment [

	| varAccess body |
	varAccess := FASTFortran2kArrayVariable new
		name: #x ;
		indices: { self makeSimpleExpression: 1 }.
	self subroutine: #something.
	self addStatement: (FASTFortran2kAssignmentStatement new
		variable: varAccess ;
		expression: (self makeSimpleExpression: 6) ).

	visitor simplify: ast.

	self deny: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 1.

	self assert: body first class equals: FASTFortran2kAssignmentStatement
]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testArrayVariableToSimplify [

	| varAccess body stmt |

	varAccess := FASTFortran2kArrayVariable new
		name: #x ;
		indices: { self makeSimpleExpression: 1 }.
	stmt := (self assignementStatement: #y value: varAccess)
		mooseModel: FASTFortran2kModel new.

	self subroutine: #something.
	self addStatement: stmt.

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 1.
	
	self assert: body first class equals: FASTFortran2kComment.

	self assert: body first content equals: '[ooo].empty-var: y = x(1)'

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testAssignmentExpression [
	"SUBROUTINE sub()
	   DO i=1, 10
	     x = 5
	   END
	 END"

	| stmt body |

	stmt := FASTFortran2kDoStatement new.
	stmt loopControl: (FASTFortran2kLoopControlExpression new
		init: (self assignementExpression: #i value: 1) ;
		limit: (self integerLiteral: 10)).
	stmt body: FASTFortran2kStatementBlock new.
	stmt body addStatement: (self assignementStatement: #x value: 5).

	self subroutine: 'sub'.
	self addStatement: stmt.

	visitor simplify: ast.

	self deny: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 1.

	self assert: body first class equals: FASTFortran2kDoStatement 
]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testAssignmentStatementToSimplify [
	"CHARACTER*20 fctBigSmall()
	   INTEGER :: x
	   x = v
	"

	| body stmt |
	stmt := (self assignementStatement: #x value: #v)
		mooseModel: FASTFortran2kModel new.
	self function: #fctBigSmall type: #(character 20).
	self addStatement: (self declarationStatement: #x type: #integer).
	self addStatement: stmt.

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 2.
	
	self assert: body first class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: body second class equals: FASTFortran2kComment.

	self assert: body second content equals: '[ooo].empty-var: x = v'

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testAssignmentToSimplify [

	| body segStatement |
	segStatement := (self assignementStatement: #y value: #x)
		mooseModel: FASTFortran2kModel new.

	self subroutine: #sub.
	self addStatement: segStatement.

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 1.

	self assert: body first class equals: FASTFortran2kComment.

	self assert: body first content equals: '[ooo].empty-var: y = x'

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testDerivedTypeComponentAccess [
	"the assignment to the pointer is absurd but we are only interested in assigning something to it"

	| varAccess body |
	varAccess := FASTFortran2kDerivedTypeComponentAccess new
		instance: (self scalarVariable: #p) ;
		field: (self scalarVariable: #x).
	self subroutine: #something.
	self addStatement: (FASTFortran2kAssignmentStatement new
		variable: (self scalarVariable: #p) ;
		expression: (self makeSimpleExpression: 6) ).
	self addStatement: (self writeStatement: {  varAccess copy }).

	visitor simplify: ast.

	self deny: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 2.

	self assert: body first class equals: FASTFortran2kAssignmentStatement.
	self assert: body second class equals: FASTFortran2kWriteStatement.
]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testDerivedTypeComponentAccessToSimplify [

	| varAccess body stmt |

	varAccess := FASTFortran2kDerivedTypeComponentAccess new
		instance: (self scalarVariable: #p) ;
		field: (self scalarVariable: #x).

	stmt := (self assignementStatement: #y value: varAccess)
		mooseModel: FASTFortran2kModel new.

	self subroutine: #something.
	self addStatement: stmt.

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 1.

	self assert: body first class equals: FASTFortran2kComment.

	self assert: body first content equals: '[ooo].empty-var: y = p % x'

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testIfLogicalStatementConditionAndThenToSimplify [

	| body writeStatement statement |

	writeStatement := (self writeStatement: #( booleanVar ))
		mooseModel: FASTFortran2kModel new.
	statement := FASTFortran2kIfLogicalStatement new
		mooseModel: writeStatement mooseModel ;
		condition: (self scalarVariable: #booleanVar) ;
		statement: writeStatement ;
		yourself.

	self function: #fctBigSmall type: #(character 20).
	self addStatement: statement.

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.
	self assert: body size equals: 1.
	
	self assert: body anyOne class equals: FASTFortran2kComment.
	self assert: body anyOne content equals: '[ooo].empty-var: if (booleanVar) write (*, *) booleanVar'

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testIfLogicalStatementConditionToSimplify [

	| body statement |
	statement := FASTFortran2kIfLogicalStatement new
		mooseModel: FASTFortran2kModel new ;
		condition: (self scalarVariable: #booleanVar) ;
		statement: (self returnStatement: nil) ;
		yourself.

	self function: #fctBigSmall type: #(character 20).
	self addStatement: statement.

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.
	self assert: body size equals: 1.
	
	self assert: body anyOne class equals: FASTFortran2kComment.
	self assert: body anyOne content equals: '[ooo].empty-var: if (booleanVar) return'

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testIfLogicalStatementThenToSimplify [

	| body statement |
	statement := (self assignementStatement: #y value: #booleanVar)
		mooseModel: FASTFortran2kModel new.

	self function: #fctBigSmall type: #(character 20).
	self addStatement: (FASTFortran2kIfLogicalStatement new
		condition: (self logicalLiteral: '.true.') ;
		statement: statement).

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.
	self assert: body size equals: 1.
	
	self assert: body anyOne class equals: FASTFortran2kIfLogicalStatement.
	self assert: body anyOne statement class equals: FASTFortran2kComment.

	self assert: body anyOne statement content equals: '[ooo].empty-var: y = booleanVar'
]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testPointeLhsInAssignmentToSimplify [

	"CHARACTER*20 FUNCTION fctBigSmall()
	  INTEGER x
	  p % f => v
	END
	"
	| body stmt pointer |
	pointer := FASTFortran2kModel new
		newDerivedTypeComponentAccess
			instance: (self scalarVariable: #p) ;
			field: (self scalarVariable: #f).
	stmt := pointer mooseModel newPointerAssignmentStatement
		variable: pointer ;
		expression: (self scalarVariable: #v).

	self function: #fctBigSmall type: #(character 20).
	self addStatement: (self declarationStatement: #x type: #integer).
	self addStatement: stmt.

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 2.
	
	self assert: body first class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: body second class equals: FASTFortran2kComment.

	self assert: body second content equals: '[ooo].empty-var: p % f => v'

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testPointeRhsrInAssignmentToKeep [

	"CHARACTER*20 FUNCTION fctBigSmall()
	  p % f => 5
	  x = p % f
	END
	"
	| body stmt pointer |

	pointer := FASTFortran2kModel new
		newDerivedTypeComponentAccess
			instance: (self scalarVariable: #p) ;
			field: (self scalarVariable: #f).
	stmt := pointer mooseModel newPointerAssignmentStatement
		variable: pointer ;
		expression: ((self makeSimpleExpression: 5)).

	self function: #fctBigSmall type: #(character 20).
	self addStatement: stmt.
	self addStatement: (self assignementStatement: #x value: pointer copy).

	visitor simplify: ast.

	self deny: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 2.
	
	self assert: body first class equals: FASTFortran2kPointerAssignmentStatement.
	self assert: body second class equals: FASTFortran2kAssignmentStatement.

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testPointeRhsrInAssignmentToSimplify [

	"CHARACTER*20 FUNCTION fctBigSmall()
	  INTEGER x
	  x = p % f
	END
	"
	| body stmt pointer |
	pointer := FASTFortran2kModel new
		newDerivedTypeComponentAccess
			instance: (self scalarVariable: #p) ;
			field: (self scalarVariable: #f).
	stmt := (self assignementStatement: #x value: pointer)
		mooseModel: pointer mooseModel.

	self function: #fctBigSmall type: #(character 20).
	self addStatement: (self declarationStatement: #x type: #integer).
	self addStatement: stmt.

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 2.
	
	self assert: body first class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: body second class equals: FASTFortran2kComment.

	self assert: body second content equals: '[ooo].empty-var: x = p % f'

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testReadStatementToKeep [
	"CHARACTER*20 fctBigSmall()
	   INTEGER :: x
	   READ (1), v
	   x = v
	"

	| body |

	self function: #fctBigSmall type: #(character 20).
	self addStatement: (self declarationStatement: #x type: #integer).
	self addStatement: (self readStatement: #(v) ioParams: #(1)).
	self addStatement: (self assignementStatement: #x value: #v).

	visitor simplify: ast.

	self deny: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 3.
	
	self assert: body first class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: body second class equals: FASTFortran2kReadStatement.
	self assert: body third class equals: FASTFortran2kAssignmentStatement 
]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testVisitAssignement [

	self assert: visitor assignedVariables isEmpty.

	(self assignementStatement: #x value: 5) accept: visitor.

	self assert: visitor assignedVariables size equals: 1.
	self assert: visitor assignedVariables anyOne equals: 'x'

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testVisitFunctionParameter [

	self function: #fctBigSmall type: #(character 20).
	self addParameter: #x type: #integer.
	self addParameter: #y type: #integer.

	self assert: visitor assignedVariables isEmpty.

	ast accept: visitor.

	self assert: visitor assignedVariables size equals: 2.
	self assert: (visitor assignedVariables includes: 'x').
	self assert: (visitor assignedVariables includes: 'y').

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testVisitSubroutineParameter [

	self subroutine: #sub.
	self addParameter: #x type: #integer.
	self addParameter: #y type: #integer.

	self assert: visitor assignedVariables isEmpty.

	ast accept: visitor.

	self assert: visitor assignedVariables size equals: 2.
	self assert: (visitor assignedVariables includes: 'x').
	self assert: (visitor assignedVariables includes: 'y').

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testWriteStatementAfterAssignment [

	| body writeStatement |
	writeStatement := (self writeStatement: #( x ))
		mooseModel: FASTFortranModel new.

	self function: #fctBigSmall type: #(character 20).
	self addStatement: (self declarationStatement: #x type: #integer).
	self addStatement: (self assignementStatement: #x value: 1).
	self addStatement: writeStatement.


	visitor simplify: ast.

	self deny: visitor simplified.

	body := ast statementBlock statements.

	self assert: body first class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: body second class equals: FASTFortran2kAssignmentStatement.
	self assert: body third class equals: FASTFortran2kWriteStatement

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testWriteStatementForParameter [

	| body writeStatement |
	writeStatement := (self writeStatement: #( x ))
		mooseModel: FASTFortranModel new.

	self function: #fctBigSmall type: #(character 20).
	self addParameter: #x type: #integer.
	self addStatement: writeStatement.

	visitor simplify: ast.

	self deny: visitor simplified.

	body := ast statementBlock statements.
	self assert: body size equals: 2.
	
	self assert: body first class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: body second class equals: FASTFortran2kWriteStatement

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testWriteStatementToSimplify [

	| body writeStatement |
	writeStatement := (self assignementStatement: #z value: #y)
		mooseModel: FASTFortran2kModel new.

	self function: #fctBigSmall type: #(character 20).
	self addStatement: (self declarationStatement: #x type: #integer).
	self addStatement: (self assignementStatement: #x value: 1).
	self addStatement: writeStatement.

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 3.
	
	self assert: body first class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: body second class equals: FASTFortran2kAssignmentStatement.
	self assert: body third class equals: FASTFortran2kComment.

	self assert: body third content equals: '[ooo].empty-var: z = y'

]
