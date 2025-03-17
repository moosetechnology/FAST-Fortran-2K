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
FASTEsopeUnassignedVariableRule >> visitFASTFortranArrayVariable: aFASTFortranArrayVariable [

	| tmpAssignment |
	self visitFASTFortranVariable: aFASTFortranArrayVariable.

	tmpAssignment := inAssignment.
	inAssignment := false.
	aFASTFortranArrayVariable indices do: [ :indice |
		indice accept: self
	].
	inAssignment := tmpAssignment
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranAssignmentStatement: aFASTFortranAssignmentStatement [

	self visitFASTFortranTAssignment: aFASTFortranAssignmentStatement
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranBackspaceStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranBackspaceStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranCallStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranCallStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranCloseStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranCloseStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranDataStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranDataStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranDecodeStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranDecodeStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranDimensionStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranDimensionStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranDoStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranDoStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranDoWhileStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranDoWhileStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranEncodeStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranEncodeStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranEndFileStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranEndFileStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranEquivalenceStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranEquivalenceStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - expressions' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranFieldAccess: aFASTFortranFieldAccess [ 
	"similar to #visitFASTFortranVariable, but variable name includes pointer name"

	| fullname expressionStatement |

	fullname := aFASTFortranFieldAccess pointer name , aFASTFortranFieldAccess field name.

	inAssignment ifTrue: [
		assignedVariables add: fullname.
		^self
	].

	(assignedVariables includes: fullname) ifTrue: [ ^self ].

	expressionStatement := nodeStack pop.
	
	nodeStack push: ((expressionStatement class = FASTFortranComment)
		ifTrue: [ expressionStatement ]
		ifFalse: [ self commentOut: 'empty-var' statement: expressionStatement ]).

]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranFormatStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranFormatStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranFunctionStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranFunctionStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranFunctionTypeDeclarationStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranFunctionTypeDeclarationStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranGoToComputedStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranGoToComputedStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranIfArithmeticStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranIfArithmeticStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranIfBlockStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranIfBlockStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranInquireStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranInquireStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranIntrinsicStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranIntrinsicStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranOpenStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranOpenStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranPrintStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranPrintStatement: aFASTFortranNode.

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
FASTEsopeUnassignedVariableRule >> visitFASTFortranReadStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranReadStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranReturnStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranReturnStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranRewindStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranRewindStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - expressions' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranScalarVariable: aFASTFortranScalarVariable [

	self visitFASTFortranVariable: aFASTFortranScalarVariable 

]

{ #category : 'visiting - traits' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranTAssignment: aFASTFortranTAssignment [
	"should check that all variables in #expression are 'valid' (ie. assigned)"

	inAssignment := true.
	aFASTFortranTAssignment variable accept: self.
	inAssignment := false.

	aFASTFortranTAssignment expression accept: self

]

{ #category : 'visiting - expressions' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranVariable: aFASTFortranVariable [
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
	
	nodeStack push: ((expressionStatement class = FASTFortranComment)
		ifTrue: [ expressionStatement ]
		ifFalse: [ self commentOut: 'empty-var' statement: expressionStatement ])

]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranVariableDeclarationStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranVariableDeclarationStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeUnassignedVariableRule >> visitFASTFortranWriteStatement: aFASTFortranNode [

	nodeStack push: aFASTFortranNode.

	super visitFASTFortranWriteStatement: aFASTFortranNode.

	nodeStack pop
]

{ #category : 'visiting - traits' }
FASTEsopeUnassignedVariableRule >> visitParameter: aFASTFortranScalarVariable [
	"parameters are considered assigned when entering the subprogram"

	assignedVariables add: aFASTFortranScalarVariable name.

	super visitParameter: aFASTFortranScalarVariable
]
