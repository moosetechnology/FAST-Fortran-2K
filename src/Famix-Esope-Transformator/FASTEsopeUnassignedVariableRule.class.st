"
Detects uses of variables that have not been assigned yet and remove the statement has it makes no sense
"
Class {
	#name : 'FASTEsopeUnassignedVariableRule',
	#superclass : 'FASTEsopeAbstractSimplifyingRule',
	#instVars : [
		'assignedVariables',
		'inAssignment'
	],
	#category : 'Famix-Esope-Transformator-Simplification',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Simplification'
}

{ #category : 'accessing - private tests' }
FASTEsopeUnassignedVariableRule >> assignedVariables [ 

	^assignedVariables 
]

{ #category : 'initialization' }
FASTEsopeUnassignedVariableRule >> initialize [ 

	super initialize.

	assignedVariables := Set new.
	inAssignment := false
]

{ #category : 'visiting - expressions' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kArrayVariable: aFASTFortranArrayVariable [

	| tmpAssignment |
	self visitFASTFortran2kVariable: aFASTFortranArrayVariable.

	tmpAssignment := inAssignment.
	inAssignment := false.
	aFASTFortranArrayVariable indices do: [ :indice |
		indice accept: self
	].
	inAssignment := tmpAssignment
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kAssignmentStatement: aFASTFortranAssignmentStatement [

	nodeStack push: aFASTFortranAssignmentStatement.

	self visitFASTTAssignment: aFASTFortranAssignmentStatement.

	nodeStack pop

]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kBackspaceStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kBackspaceStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kCallStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kCallStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kCloseStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kCloseStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kDataStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kDataStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kDecodeStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kDecodeStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kDerivedTypeComponentAccess: aFASTFortran2kDerivedTypeComponentAccess [ 

	self visitFASTFortran2kVariable: aFASTFortran2kDerivedTypeComponentAccess instance.

]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kDimensionStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kDimensionStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kDoStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kDoStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kDoWhileStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kDoWhileStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kEncodeStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kEncodeStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kEndFileStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kEndFileStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kEquivalenceStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kEquivalenceStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kFormatStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kFormatStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kFunctionStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kFunctionStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kGoToComputedStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kGoToComputedStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kIfArithmeticStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kIfArithmeticStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kIfBlockStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kIfBlockStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kInquireStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kInquireStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kIntrinsicStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kIntrinsicStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - expressions' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kLoopControlExpression: aFASTFortran2kLoopControlExpression [

	aFASTFortran2kLoopControlExpression init ifNotNil: [ :node | node accept: self].
	aFASTFortran2kLoopControlExpression limit ifNotNil: [ :node | node accept: self].
	aFASTFortran2kLoopControlExpression increment ifNotNil: [ :node | node accept: self].

]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kOpenStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kOpenStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kPointerAssignmentStatement: aFASTFortran2kPointerAssignmentStatement [

	nodeStack push: aFASTFortran2kPointerAssignmentStatement.

	self visitFASTTAssignment: aFASTFortran2kPointerAssignmentStatement.

	nodeStack pop

]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kPrintStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kPrintStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - programUnits' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kProcedure: aFASTFortranProcedure [

	assignedVariables := Set new.

	super visitFASTFortran2kProcedure: aFASTFortranProcedure
]

{ #category : 'visiting - programUnits' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kProgramMain: aFASTFortranProgramMain [

	assignedVariables := Set new.

	super visitFASTFortran2kProgramMain: aFASTFortranProgramMain
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kReadStatement: aFASTFortranNode [

	self visitFASTFortran2kAbstractIOStatement: aFASTFortranNode.

	inAssignment := true.
	self visitFASTTWithArguments: aFASTFortranNode.
	inAssignment := false.

]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kReturnStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kReturnStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kRewindStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kRewindStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - expressions' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kScalarVariable: aFASTFortranScalarVariable [

	self visitFASTFortran2kVariable: aFASTFortranScalarVariable 

]

{ #category : 'visiting - expressions' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kVariable: aFASTFortranVariable [
	"If we are in an assignment then register that this variable is assigned.
	 Otherwise, it's a use of the variable.
 	 If it was never assigned, we want to remove the statement
	 The expressionStatement (owning the expression) is on the top of the stack
	 We check that it is not already commented out (in case 2 or more variables were not assigned)
	 To comment out this expressionStatement we need its parent to be on top of the nodeStack
	 Finally, we need to push the new statement back on the stack because there will a pop when
	   finishing to visit the parentStatement"

	| expressionStatement |

	inAssignment ifTrue: [
		assignedVariables add: aFASTFortranVariable name.
		^self
	].

	(assignedVariables includes: aFASTFortranVariable name) ifTrue: [ ^self ].

	expressionStatement := nodeStack pop.
	
	nodeStack push: ((expressionStatement class = FASTFortran2kComment)
		ifTrue: [ expressionStatement ]
		ifFalse: [ self commentOut: 'empty-var' statement: expressionStatement ])

]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kVariableDeclarationStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kVariableDeclarationStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortran2kWriteStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortran2kWriteStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - traits' }
FASTEsopeUnassignedVariableRule >> visitFASTTAssignment: aFASTFortranTAssignment [
	"should check that all variables in #expression are 'valid' (ie. assigned)"

	inAssignment := true.
	aFASTFortranTAssignment variable accept: self.
	inAssignment := false.

	aFASTFortranTAssignment expression accept: self

]

{ #category : 'visiting - traits' }
FASTEsopeUnassignedVariableRule >> visitFASTTWithParameters: aFASTFortran2kTWithParameters [
	"parameters are considered assigned when entering the subprogram"

	aFASTFortran2kTWithParameters parameters do: [ :param |
		assignedVariables add: param name ]

]
