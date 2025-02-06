Class {
	#name : 'FASTFortranBehavioralTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractTransformationVisitorTest',
	#instVars : [
		'parentVisitor'
	],
	#category : 'FAST-Fortran2k-Visitors-Tests',
	#package : 'FAST-Fortran2k-Visitors-Tests'
}

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> newVisitor [ 

	parentVisitor := FASTFortranTransformationVisitor new.
	^FASTFortranProcedureTransformationVisitor new
		parentVisitor: parentVisitor.

]

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> testArrayDeclaration [
	| stmt dst |
	stmt := self arrayDeclaration: 'v' dimensions: #( #('1' '10') ).
	
	dst := stmt accept: visitor.

	self
		assert: dst class
		equals: FASTFortran2kVariableDeclarationStatement.
]

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> testAssignementStatementLiteralValue [
	| stmt res |
	stmt := self assignementStatement: #aVar value: (self logicalLiteral: '.true.').
	
	res := stmt accept: visitor.
	
	self assert: res class equals: FASTFortran2kAssignmentStatement.
	self assert: res variable class equals: FASTFortran2kScalarVariable.
	self assert: res expression class equals: FASTFortran2kBooleanLiteral.
	
	self assert: res variable name equals: 'aVar'.
	self assert: res expression primitiveValue equals: '.true.'.
]

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> testComment [
	| cmt dst |
	cmt := self comment: 'This is a comment'.
	
	dst := cmt accept: visitor.
	
	self assert: dst class equals: FASTFortran2kComment.
	self assert: dst content equals: 'This is a comment'.
]

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> testCreateModule [

	| module |

	module := visitor createModule: 'someName_mod'.

	self assert: module class equals: FASTFortran2kModule.
	self assert: module name equals: 'someName_mod'.
	
	self assert: module parentProgramFile isNotNil.
	self assert: module parentProgramFile class equals: FASTFortran2kProgramFile.
	self assert: module parentProgramFile filename equals: 'someName_mod.f90'

]

{ #category : 'tests-statement' }
FASTFortranBehavioralTransformationVisitorTest >> testDoStatement [
	| stmt res loopControl |

	stmt := self doStatement: #(i 1 max 1) statements: #().
	
	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kDoStatement.
	
	loopControl := res loopControl.
	
	self assert: loopControl class equals: FASTFortran2kLoopControlExpression.
	self assert: loopControl init class equals: FASTFortran2kAssignmentExpression.
	self assert: loopControl init variable class equals: FASTFortran2kScalarVariable.
	self assert: loopControl init expression class equals: FASTFortran2kIntegerLiteral.
]

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> testEnsureModuleOnce [

	| module |

	module := visitor ensureModule: 'someName_mod'.

	self assert: module class equals: FASTFortran2kModule.
	self assert: module name equals: 'someName_mod'.

]

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> testEnsureModuleTwice [

	| module |

	module := visitor ensureModule: 'someName_mod'.

	self assert: module class equals: FASTFortran2kModule.
	self assert: module name equals: 'someName_mod'.

	self assert: (visitor ensureModule: 'someName_mod') equals: module
]
