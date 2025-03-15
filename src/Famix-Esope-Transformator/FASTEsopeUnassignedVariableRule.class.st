"
Detects uses of variables that have not been assigned yet and remove the statement has it makes no sense
"
Class {
	#name : 'FASTEsopeUnassignedVariableRule',
	#superclass : 'FASTEsopeAbstractSimplifyingRule',
	#instVars : [
		'assignedVariables'
	],
	#category : 'Famix-Esope-Transformator-Simplification',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Simplification'
}

{ #category : 'initialization' }
FASTEsopeUnassignedVariableRule >> initialize [ 

	super initialize.

	assignedVariables := Set new
]

{ #category : 'visiting - expressions' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranArrayVariable: aFASTFortranArrayVariable [

	self visitFASTFortranVariable: aFASTFortranArrayVariable.

	aFASTFortranArrayVariable indices do: [ :indice |
		indice accept: self
	]
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranIfLogicalStatement: aFASTFortranIfLogicalStatement [
	"must override to not push twice the statement on the stack"

	nodeStack push: aFASTFortranIfLogicalStatement.

	aFASTFortranIfLogicalStatement condition accept: self.
	aFASTFortranIfLogicalStatement statement accept: self.

	nodeStack pop
]

{ #category : 'visiting - programUnits' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranProcedure: aFASTFortranProcedure [

	assignedVariables := Set new.

	super visitFASTFortranProcedure: aFASTFortranProcedure
]

{ #category : 'visiting - programUnits' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranProgramMain: aFASTFortranProgramMain [

	assignedVariables := Set new.

	super visitFASTFortranProgramMain: aFASTFortranProgramMain
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranStatementBlock: aFASTFortranStatementBlock [
	"must override to not push twice the statementBlock on the stack"

	nodeStack push: aFASTFortranStatementBlock.

	aFASTFortranStatementBlock statements do: [ :statement |
		statement accept: self
	].

	nodeStack pop

]

{ #category : 'visiting - traits' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranTAssignment: aFASTFortranTAssignment [
	"should check that all varibales in #expression are 'valid' (ie. assigned)"

	assignedVariables add: aFASTFortranTAssignment variable.

	super visitFASTFortranTAssignment: aFASTFortranTAssignment

]

{ #category : 'visiting - traits' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranTStatement: aFASTFortranTStatement [

	nodeStack push: aFASTFortranTStatement.

	super visitFASTFortranTStatement: aFASTFortranTStatement.
	
	nodeStack pop
]

{ #category : 'visiting - expressions' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranVariable: aFASTFortranVariable [
	"if the variable was never assigned, we want to remove the statement
	 The expressionStatement (owning the expression) is on the top of the stack
	 We check that it is not already commented out (in case 2 or more variables were not assigned)
	 To comment out this expressionStatement we need its parent to be on top of the nodeStack
	 Finally, we need to push the new statement back on the stack because there will a pop when
	   finishing to visit the parentStatement"

	| expressionStatement |
	(assignedVariables includes: aFASTFortranVariable name)
		ifTrue: [ ^self ].

	expressionStatement := nodeStack pop.
	
	nodeStack push: ((expressionStatement class = FASTFortranComment)
		ifTrue: [ expressionStatement ]
		ifFalse: [ self commentOut: 'empty-var' statement: expressionStatement ])

]

{ #category : 'visiting - traits' }
FASTEsopeUnassignedVariableRule >> visitParameter: aFASTFortranScalarVariable [
	"parameters are considered assigned when entering the subprogram"

	assignedVariables add: aFASTFortranScalarVariable.

	super visitParameter: aFASTFortranScalarVariable
]
