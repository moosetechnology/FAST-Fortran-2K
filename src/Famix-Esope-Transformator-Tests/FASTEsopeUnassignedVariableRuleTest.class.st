Class {
	#name : 'FASTEsopeUnassignedVariableRuleTest',
	#superclass : 'FASTEsopeAbstractVisitorTest',
	#category : 'Famix-Esope-Transformator-Tests-Simplification',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Simplification'
}

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testArrayVariableAssignment [

	| varAccess body |
	varAccess := FASTFortranArrayVariable new
		name: #x ;
		indices: { self makeSimpleExpression: 1 }.
	self subroutine: #something.
	self addStatement: (FASTFortranAssignmentStatement new
		variable: varAccess ;
		expression: (self makeSimpleExpression: 6) ).

	visitor simplify: ast.

	self deny: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 1.

	self assert: body first class equals: FASTFortranAssignmentStatement
]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testArrayVariableToSimplify [

	| varAccess body writeStatement |

	varAccess := FASTFortranArrayVariable new
		name: #x ;
		indices: { self makeSimpleExpression: 1 }.
	writeStatement := (self writeStatement: { varAccess })
		mooseModel: FASTFortranModel new.

	self subroutine: #something.
	self addStatement: writeStatement.

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 1.
	
	self assert: body first class equals: FASTFortranComment.

	self assert: body first content equals: '[ooo].empty-var: write (*,*) x(1)'

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testAssignmentStatementToSimplify [

	| body stmt |
	stmt := (self assignementStatement: #x value: #v)
		mooseModel: FASTFortranModel new.
	self function: #fctBigSmall type: #(character 20).
	self addStatement: (self declarationStatement: #x type: #integer).
	self addStatement: stmt.

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 2.
	
	self assert: body first class equals: FASTFortranVariableDeclarationStatement.
	self assert: body second class equals: FASTFortranComment.

	self assert: body second content equals: '[ooo].empty-var: x = v'

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testEsopeCommandToSimplify [

	| body segStatement |
	segStatement := FASTEsopeModel new newSegadj.
	segStatement addVariable: (self scalarVariable: #v).

	self subroutine: #sub.
	self addStatement: segStatement.

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 1.

	self assert: body first class equals: FASTFortranComment.

	self assert: body first content equals: '[ooo].empty-var: segadj,v'

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testFieldAccessAssignment [

	| varAccess body |
	varAccess := FASTFortranFieldAccess new
		pointer: (self scalarVariable: #p) ;
		field: (self scalarVariable: #x).
	self subroutine: #something.
	self addStatement: (FASTFortranAssignmentStatement new
		variable: varAccess ;
		expression: (self makeSimpleExpression: 6) ).
	self addStatement: (self writeStatement: {  varAccess copy }).

	visitor simplify: ast.

	self deny: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 2.

	self assert: body first class equals: FASTFortranAssignmentStatement.
	self assert: body second class equals: FASTFortranWriteStatement.
]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testFieldAccessToSimplify [

	| varAccess body writeStatement |

	varAccess := FASTFortranFieldAccess new
		pointer: (self scalarVariable: #p) ;
		field: (self scalarVariable: #x).

	writeStatement := (self writeStatement: {  varAccess })
		mooseModel: FASTFortranModel new.

	self subroutine: #something.
	self addStatement: writeStatement.

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 1.

	self assert: body first class equals: FASTFortranComment.

	self assert: body first content equals: '[ooo].empty-var: write (*,*) p.x'

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testIfLogicalStatementConditionAndThenToSimplify [

	| body writeStatement statement |

	writeStatement := (self writeStatement: #( booleanVar ))
		mooseModel: FASTFortranModel new.
	statement := FASTFortranIfLogicalStatement new
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
	
	self assert: body anyOne class equals: FASTFortranComment.
	self assert: body anyOne content equals: '[ooo].empty-var: if (booleanVar) write (*,*) booleanVar'

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testIfLogicalStatementConditionToSimplify [

	| body statement |
	statement := FASTFortranIfLogicalStatement new
		mooseModel: FASTFortranModel new ;
		condition: (self scalarVariable: #booleanVar) ;
		statement: (self returnStatement: nil) ;
		yourself.

	self function: #fctBigSmall type: #(character 20).
	self addStatement: statement.

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.
	self assert: body size equals: 1.
	
	self assert: body anyOne class equals: FASTFortranComment.
	self assert: body anyOne content equals: '[ooo].empty-var: if (booleanVar) return'

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testIfLogicalStatementThenToSimplify [

	| body statement |
	statement := (self writeStatement: #( booleanVar ))
		mooseModel: FASTFortranModel new.

	self function: #fctBigSmall type: #(character 20).
	self addStatement: (FASTFortranIfLogicalStatement new
		condition: (self logicalLiteral: '.true.') ;
		statement: statement).

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.
	self assert: body size equals: 1.
	
	self assert: body anyOne class equals: FASTFortranIfLogicalStatement.
	self assert: body anyOne statement class equals: FASTFortranComment.

	self assert: body anyOne statement content equals: '[ooo].empty-var: write (*,*) booleanVar'
]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testVisitAssignement [

	self assert: visitor assignedVariables isEmpty.

	(self assignementStatement: #x value: 5) accept: visitor.

	self assert: visitor assignedVariables size equals: 1.
	self assert: visitor assignedVariables anyOne equals: 'x'

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testVisitParameter [

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

	self assert: body first class equals: FASTFortranVariableDeclarationStatement.
	self assert: body second class equals: FASTFortranAssignmentStatement.
	self assert: body third class equals: FASTFortranWriteStatement

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
	
	self assert: body first class equals: FASTFortranVariableDeclarationStatement.
	self assert: body second class equals: FASTFortranWriteStatement

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testWriteStatementToSimplify [

	| body writeStatement |
	writeStatement := (self writeStatement: #( y ))
		mooseModel: FASTFortranModel new.

	self function: #fctBigSmall type: #(character 20).
	self addStatement: (self declarationStatement: #x type: #integer).
	self addStatement: (self assignementStatement: #x value: 1).
	self addStatement: writeStatement.

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 3.
	
	self assert: body first class equals: FASTFortranVariableDeclarationStatement.
	self assert: body second class equals: FASTFortranAssignmentStatement.
	self assert: body third class equals: FASTFortranComment.

	self assert: body third content equals: '[ooo].empty-var: write (*,*) y'

]

{ #category : 'running' }
FASTEsopeUnassignedVariableRuleTest >> visitorClass [ 

	^FASTEsopeUnassignedVariableRule 
]
