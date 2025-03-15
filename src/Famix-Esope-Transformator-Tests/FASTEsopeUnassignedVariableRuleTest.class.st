Class {
	#name : 'FASTEsopeUnassignedVariableRuleTest',
	#superclass : 'FASTEsopeAbstractVisitorTest',
	#category : 'Famix-Esope-Transformator-Tests-Simplification',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Simplification'
}

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

	ast accept: visitor.

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

	ast accept: visitor.

	body := ast statementBlock statements.
	self assert: body size equals: 2.
	
	self assert: body first class equals: FASTFortranVariableDeclarationStatement.
	self assert: body second class equals: FASTFortranWriteStatement

]

{ #category : 'tests' }
FASTEsopeUnassignedVariableRuleTest >> testWriteStatementToRemove [

	| body writeStatement |
	writeStatement := (self writeStatement: #( y ))
		mooseModel: FASTFortranModel new.

	self function: #fctBigSmall type: #(character 20).
	self addStatement: (self declarationStatement: #x type: #integer).
	self addStatement: (self assignementStatement: #x value: 1).
	self addStatement: writeStatement.

	ast accept: visitor.

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
