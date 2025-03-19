Class {
	#name : 'FASTEsopeUselessDeclarationRuleTest',
	#superclass : 'FASTEsopeAbstractVisitorTest',
	#category : 'Famix-Esope-Transformator-Tests-Simplification',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Simplification'
}

{ #category : 'tests' }
FASTEsopeUselessDeclarationRuleTest >> testVariableDeclarationStatementIsUseful [

	self subroutine: 'sub'.
	self addStatement: (self declarationStatement: #x type: #integer).
	self addStatement: (self writeStatement: { #x }).

	visitor simplify: ast.

	self assert: visitor uselessDeclarations size equals: 0

]

{ #category : 'tests' }
FASTEsopeUselessDeclarationRuleTest >> testVariableDeclarationStatementIsUseless [

	self subroutine: 'sub'.
	self addStatement: (self declarationStatement: #x type: #integer).

	visitor simplify: ast.

	self assert: visitor uselessDeclarations size equals: 1.
	self assert: visitor uselessDeclarations keys anyOne equals: 'x'.

]

{ #category : 'running' }
FASTEsopeUselessDeclarationRuleTest >> visitorClass [ 

	^FASTEsopeUselessDeclarationRule 
]
