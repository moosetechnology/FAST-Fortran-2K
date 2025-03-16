Class {
	#name : 'FASTEsopeObsoleteCommandRuleTest',
	#superclass : 'FASTEsopeAbstractVisitorTest',
	#category : 'Famix-Esope-Transformator-Tests-Simplification',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Simplification'
}

{ #category : 'tests' }
FASTEsopeObsoleteCommandRuleTest >> testVisitCallStatementToKeep [

	| statementBlock oldStatement |
	oldStatement := (self callStatement: #sub arguments: #())
		mooseModel: FASTFortranModel new.
	statementBlock := self statementBlock: {
		self declarationStatement: #x type: #integer.
		self assignementStatement: #x value: 5. 
		oldStatement .
		self returnStatement: #x
	}.

	visitor simplify: statementBlock.

	self deny: visitor simplified.
	self assert: statementBlock statements size equals: 4.
	
	self assert: statementBlock statements first class equals: FASTFortranVariableDeclarationStatement.
	self assert: statementBlock statements second class equals: FASTFortranAssignmentStatement.
	self assert: statementBlock statements third class equals: FASTFortranCallStatement.
	self assert: statementBlock statements fourth class equals: FASTFortranReturnStatement.

]

{ #category : 'tests' }
FASTEsopeObsoleteCommandRuleTest >> testVisitCallStatementToSimplify [

	| statementBlock oldStatement |
	oldStatement := (self callStatement: #oooeta arguments: #())
		mooseModel: FASTFortranModel new.
	statementBlock := self statementBlock: {
		self declarationStatement: #x type: #integer.
		self assignementStatement: #x value: 5. 
		oldStatement .
		self returnStatement: #x
	}.

	visitor simplify: statementBlock.

	self assert: visitor simplified.
	self assert: statementBlock statements size equals: 4.
	
	self assert: statementBlock statements first class equals: FASTFortranVariableDeclarationStatement.
	self assert: statementBlock statements second class equals: FASTFortranAssignmentStatement.
	self assert: statementBlock statements third class equals: FASTFortranComment.
	self assert: statementBlock statements fourth class equals: FASTFortranReturnStatement.

]

{ #category : 'tests' }
FASTEsopeObsoleteCommandRuleTest >> testVisitSegactToIgnore [

	| statementBlock oldStatement |
	oldStatement := (self segmentCommand: FASTEsopeSegact with: { #v })
		mooseModel: FASTEsopeModel new.
	statementBlock := self statementBlock: {
		self declarationStatement: #x type: #integer.
		self assignementStatement: #x value: 5. 
		oldStatement .
		self returnStatement: #x
	}.

	visitor simplify: statementBlock.

	self assert: visitor simplified.
	self assert: statementBlock statements size equals: 4.
	
	self assert: statementBlock statements first class equals: FASTFortranVariableDeclarationStatement.
	self assert: statementBlock statements second class equals: FASTFortranAssignmentStatement.
	self assert: statementBlock statements third class equals: FASTFortranComment.
	self assert: statementBlock statements fourth class equals: FASTFortranReturnStatement.

]

{ #category : 'tests' }
FASTEsopeObsoleteCommandRuleTest >> testVisitSegdesToIgnore [

	| statementBlock oldStatement |
	oldStatement := (self segmentCommand: FASTEsopeSegdes with: { #v })
		mooseModel: FASTEsopeModel new.
	statementBlock := self statementBlock: {
		self declarationStatement: #x type: #integer.
		self assignementStatement: #x value: 5. 
		oldStatement .
		self returnStatement: #x
	}.

	visitor simplify: statementBlock.

	self assert: visitor simplified.
	self assert: statementBlock statements size equals: 4.
	
	self assert: statementBlock statements first class equals: FASTFortranVariableDeclarationStatement.
	self assert: statementBlock statements second class equals: FASTFortranAssignmentStatement.
	self assert: statementBlock statements third class equals: FASTFortranComment.
	self assert: statementBlock statements fourth class equals: FASTFortranReturnStatement.

]

{ #category : 'running' }
FASTEsopeObsoleteCommandRuleTest >> visitorClass [ 

	^FASTEsopeObsoleteCommandRule
]
