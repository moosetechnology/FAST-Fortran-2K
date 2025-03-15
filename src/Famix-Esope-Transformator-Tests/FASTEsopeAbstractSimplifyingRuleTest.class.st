Class {
	#name : 'FASTEsopeAbstractSimplifyingRuleTest',
	#superclass : 'FASTFortranAbstractVisitorTest',
	#category : 'Famix-Esope-Transformator-Tests',
	#package : 'Famix-Esope-Transformator-Tests'
}

{ #category : 'running' }
FASTEsopeAbstractSimplifyingRuleTest >> newVisitor [

	^FASTEsopeAbstractSimplifyingRule new
]

{ #category : 'tests' }
FASTEsopeAbstractSimplifyingRuleTest >> testSubstituteStatementNodeWithNodeInBlock [

	| parentNode oldStatement |
	oldStatement := self assignementStatement: #x value: 5.
	parentNode := self statementBlock: {
		self declarationStatement: #x type: #integer.
		self callStatement: #sub arguments: #() . 
		oldStatement .
		self returnStatement: #x
	}.

	visitor nodeStack push: parentNode.
	visitor substituteStatementNode: oldStatement withNode: (self comment: 'this is the substitution').

	self assert: parentNode statements size equals: 4.
	
	self assert: parentNode statements first class equals: FASTFortranVariableDeclarationStatement.
	self assert: parentNode statements second class equals: FASTFortranCallStatement.
	self assert: parentNode statements third class equals: FASTFortranComment.
	self assert: parentNode statements fourth class equals: FASTFortranReturnStatement.

	self assert: parentNode statements first  statementContainer equals: parentNode.
	self assert: parentNode statements second statementContainer equals: parentNode.
	self assert: parentNode statements third  statementContainer equals: parentNode.
	self assert: parentNode statements fourth statementContainer equals: parentNode.

	self assert: oldStatement statementContainer isNil
]

{ #category : 'tests' }
FASTEsopeAbstractSimplifyingRuleTest >> testSubstituteStatementNodeWithNodeInLogicalIf [

	| parentNode oldStatement |
	oldStatement := self assignementStatement: #x value: 5.
	parentNode := self
		logicalIf: (self scalarVariable: #aBoolean)
		statement: oldStatement.

	visitor nodeStack push: parentNode.
	visitor substituteStatementNode: oldStatement withNode: (self comment: 'this is the substitution').

	self assert: parentNode statement class equals: FASTFortranComment.
	self assert: parentNode statement content equals: 'this is the substitution'.
	self assert: parentNode statement parentIfStatement equals: parentNode.

	self assert: oldStatement parentIfStatement isNil
]
