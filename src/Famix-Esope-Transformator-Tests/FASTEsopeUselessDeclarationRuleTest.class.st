Class {
	#name : 'FASTEsopeUselessDeclarationRuleTest',
	#superclass : 'FASTFortran2kAbstractVisitorTest',
	#category : 'Famix-Esope-Transformator-Tests-Simplification',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Simplification'
}

{ #category : 'running' }
FASTEsopeUselessDeclarationRuleTest >> newVisitor [

	^FASTEsopeUselessDeclarationRule new
]

{ #category : 'tests' }
FASTEsopeUselessDeclarationRuleTest >> testArgumentIsUseful [

	| model |
	model := FASTFortran2kModel new.
	ast := self function: #fctBigSmall type: #(character 20).
	self addStatement: (self callStatement: #aCall arguments: #(arg1 arg2)).
	self addStatement: ((self declarationStatement: #arg1 type: #integer)
		mooseModel: model; yourself).
	self addStatement: ((self declarationStatement: #arg2 type: #real)
		mooseModel: model; yourself).

	visitor simplify: ast.

	self assert: visitor uselessDeclarations size equals: 0

]

{ #category : 'tests' }
FASTEsopeUselessDeclarationRuleTest >> testAssignedVariableInLoopBodyIsUseful [
	"SUBROUTINE sub()
	   INTEGER x
	   DO i=1, 10
	     x = 5
	   END
	 END"

	| stmt |

	stmt := FASTFortran2kDoStatement new.
	stmt loopControl: (FASTFortran2kLoopControlExpression new
		init: (self assignementExpression: #i value: 1) ;
		limit: (self integerLiteral: 10)).
	stmt body: FASTFortran2kStatementBlock new.
	stmt body addStatement: (self assignementStatement: #x value: 5).

	self subroutine: 'sub'.
	self addStatement: (self declarationStatement: #x type: #integer).
	self addStatement: stmt.

	visitor simplify: ast.

	self assert: visitor uselessDeclarations size equals: 0

]

{ #category : 'tests' }
FASTEsopeUselessDeclarationRuleTest >> testAssignedVariableInLoopInitIsUseful [
	"SUBROUTINE sub()
	   INTEGER i
	   DO i=1, 10
	     x = 5
	   END
	 END"

	| stmt |

	stmt := FASTFortran2kDoStatement new.
	stmt loopControl: (FASTFortran2kLoopControlExpression new
		init: (self assignementExpression: #i value: 1) ;
		limit: (self integerLiteral: 10)).
	stmt body: FASTFortran2kStatementBlock new.
	stmt body addStatement: (self assignementStatement: #x value: 5).

	self subroutine: 'sub'.
	self addStatement: (self declarationStatement: #i type: #integer).
	self addStatement: stmt.

	visitor simplify: ast.

	self assert: visitor uselessDeclarations size equals: 0

]

{ #category : 'tests' }
FASTEsopeUselessDeclarationRuleTest >> testAssignedVariableInLoopLimitIsUseful [
	"SUBROUTINE sub()
	   INTEGER max
	   DO i=1, max
	     x = 5
	   END
	 END"

	| stmt |

	stmt := FASTFortran2kDoStatement new.
	stmt loopControl: (FASTFortran2kLoopControlExpression new
		init: (self assignementExpression: #i value: 1) ;
		limit: (self scalarVariable: #max)).
	stmt body: FASTFortran2kStatementBlock new.
	stmt body addStatement: (self assignementStatement: #x value: 5).

	self subroutine: 'sub'.
	self addStatement: (self declarationStatement: #max type: #integer).
	self addStatement: stmt.

	visitor simplify: ast.

	self assert: visitor uselessDeclarations size equals: 0

]

{ #category : 'tests' }
FASTEsopeUselessDeclarationRuleTest >> testAssignedVariableInLoopStepIsUseful [
	"SUBROUTINE sub()
	   INTEGER step
	   DO i=1, 10, step
	     x = 5
	   END
	 END"

	| stmt |

	stmt := FASTFortran2kDoStatement new.
	stmt loopControl: (FASTFortran2kLoopControlExpression new
		init: (self assignementExpression: #i value: 1) ;
		limit: (self integerLiteral: 10) ;
		increment: (self scalarVariable: #step)).
	stmt body: FASTFortran2kStatementBlock new.
	stmt body addStatement: (self assignementStatement: #x value: 5).

	self subroutine: 'sub'.
	self addStatement: (self declarationStatement: #step type: #integer).
	self addStatement: stmt.

	visitor simplify: ast.

	self assert: visitor uselessDeclarations size equals: 0

]

{ #category : 'tests' }
FASTEsopeUselessDeclarationRuleTest >> testAssignedVariableIsUseful [

	self subroutine: 'sub'.
	self addStatement: (self declarationStatement: #x type: #integer).
	self addStatement: (self assignementStatement: #x value: 5).

	visitor simplify: ast.

	self assert: visitor uselessDeclarations size equals: 0

]

{ #category : 'tests' }
FASTEsopeUselessDeclarationRuleTest >> testExpressionInPointerAssignmentIsUseful [
	"SUBROUTINE sub()
	   INTEGER lib
	   ptr => mypnt(lib,1)
	 END"

	self subroutine: 'sub'.
	self addStatement: (self declarationStatement: #lib type: #integer).
	self addStatement: (FASTFortran2kPointerAssignmentStatement new
		variable: (self scalarVariable: #ptr) ;
		expression: (self functionCall: #mypnt arguments: #( lib 1 ) )).

	visitor simplify: ast.

	self assert: visitor uselessDeclarations size equals: 0

]

{ #category : 'tests' }
FASTEsopeUselessDeclarationRuleTest >> testMainHaveNoParameters [

	| stmt |
	ast := FASTFortran2kProgramMain new
		name: #main ;
		statementBlock: (self statementBlock: #()) ;
		yourself.
	stmt := self declarationStatement: #x type: #integer.
	stmt mooseModel: FASTFortran2kModel new.
	self addStatement: stmt.

	visitor simplify: ast.

	self assert: visitor uselessDeclarations size equals: 1

]

{ #category : 'tests' }
FASTEsopeUselessDeclarationRuleTest >> testParameterIsUseful [

	self function: #fctBigSmall type: #(character 20).
	self addParameter: #x type: #integer.
	self addParameter: #y type: #integer.

	visitor simplify: ast.

	self assert: visitor uselessDeclarations size equals: 0

]

{ #category : 'tests' }
FASTEsopeUselessDeclarationRuleTest >> testVariableDeclarationStatementIsUseful [

	self subroutine: 'sub'.
	self addStatement: (self declarationStatement: #x type: #integer).
	self addStatement: (self writeStatement: { #x }).

	visitor simplify: ast.

	self assert: visitor uselessDeclarations size equals: 0

]

{ #category : 'tests' }
FASTEsopeUselessDeclarationRuleTest >> testVariableDeclarationStatementToSimplify [

	| stmt body |
	stmt := self declarationStatement: #x type: #integer.
	stmt mooseModel: FASTFortran2kModel new.

	self subroutine: 'sub'.
	self addStatement: stmt.

	visitor simplify: ast.

	self assert: visitor simplified.

	body := ast statementBlock statements.

	self assert: body size equals: 1.
	self assert: body anyOne class equals: FASTFortran2kComment.
	self assert: body anyOne content equals: '[ooo].not-used: integer :: x'
]
