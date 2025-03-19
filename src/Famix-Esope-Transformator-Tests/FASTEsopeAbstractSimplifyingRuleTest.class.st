Class {
	#name : 'FASTEsopeAbstractSimplifyingRuleTest',
	#superclass : 'FASTFortran2kAbstractVisitorTest',
	#category : 'Famix-Esope-Transformator-Tests-Simplification',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Simplification'
}

{ #category : 'running' }
FASTEsopeAbstractSimplifyingRuleTest >> newVisitor [

	^FASTEsopeAbstractSimplifyingRule new
]

{ #category : 'tests' }
FASTEsopeAbstractSimplifyingRuleTest >> testCommentOutStatementInBlock [

	| parentNode oldStatement |
	oldStatement := (self assignementStatement: #x value: 5)
		mooseModel: FASTFortran2kModel new.
	parentNode := self statementBlock: {
		self declarationStatement: #x type: #integer.
		self callStatement: #sub arguments: #() . 
		oldStatement .
		self returnStatement: #x
	}.

	visitor nodeStack push: parentNode.
	visitor commentOut: 'testing' statement: oldStatement.

	self assert: visitor simplified.
	self assert: parentNode statements size equals: 4.
	
	self assert: parentNode statements first class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: parentNode statements second class equals: FASTFortran2kCallStatement.
	self assert: parentNode statements third class equals: FASTFortran2kComment.
	self assert: parentNode statements fourth class equals: FASTFortran2kReturnStatement.

	self assert: parentNode statements first  statementContainer equals: parentNode.
	self assert: parentNode statements second statementContainer equals: parentNode.
	self assert: parentNode statements third  statementContainer equals: parentNode.
	self assert: parentNode statements fourth statementContainer equals: parentNode.

	self assert: oldStatement statementContainer isNil
]

{ #category : 'tests' }
FASTEsopeAbstractSimplifyingRuleTest >> testCommentOutStatementInLogicalIf [

	| parentNode oldStatement |
	oldStatement := (self assignementStatement: #x value: 5)
		mooseModel: FASTFortran2kModel new.
	parentNode := self
		logicalIf: (self scalarVariable: #aBoolean)
		statement: oldStatement.

	visitor nodeStack push: parentNode.
	visitor commentOut: oldStatement statement: oldStatement.

	self assert: visitor simplified.
	self assert: parentNode statement class equals: FASTFortran2kComment.
	self assert: parentNode statement parentIfStatement equals: parentNode.

	self assert: oldStatement parentIfStatement isNil
]

{ #category : 'tests' }
FASTEsopeAbstractSimplifyingRuleTest >> testMakeCommentFromStatement [

	| oldStatement newStatement |
	oldStatement := (self assignementStatement: #x value: 5)
		mooseModel: FASTFortran2kModel new.
	newStatement := visitor makeComment: 'testing' fromStatement: oldStatement.

	self assert: newStatement class equals: FASTFortran2kComment.
	self assert: newStatement content equals: '[ooo].testing: x = 5'.

	self assert: newStatement mooseModel equals: oldStatement mooseModel

]

{ #category : 'tests' }
FASTEsopeAbstractSimplifyingRuleTest >> testMakeCommentFromStatementNoTag [

	| oldStatement newStatement |
	oldStatement := (self assignementStatement: #x value: 5)
		mooseModel: FASTFortran2kModel new.
	newStatement := visitor makeComment: nil fromStatement: oldStatement.

	self assert: newStatement class equals: FASTFortran2kComment.
	self assert: newStatement content equals: '[ooo] x = 5'.

	self assert: newStatement mooseModel equals: oldStatement mooseModel

]

{ #category : 'tests' }
FASTEsopeAbstractSimplifyingRuleTest >> testMakeCommentFromStatementSegact [

	| oldStatement newStatement |
	self skip: 'still needed now that we are on FASTFortran2k instead of FASTEsope?'.
	
	oldStatement := (self segmentCommand: FASTEsopeSegact with: { #v })
		mooseModel: FASTEsopeModel new.
	newStatement := visitor makeComment: 'testing' fromStatement: oldStatement.

	self assert: newStatement class equals: FASTFortranComment.
	self assert: newStatement content equals: '[ooo].testing: segact,v'.

	self assert: newStatement mooseModel equals: oldStatement mooseModel

]
