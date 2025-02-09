Class {
	#name : 'FASTFortranUseTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractTransformationVisitorTest',
	#category : 'FAST-Fortran2k-Visitors-Tests',
	#package : 'FAST-Fortran2k-Visitors-Tests'
}

{ #category : 'tests' }
FASTFortranUseTransformationVisitorTest >> testProcedureWithPointeurDeclaration [

    "usesNeeded:
		sub -> foo"

    |  usesNeeded |
	self subroutineWithPointeurDeclaration.

   fastProcedures anyOne accept: visitor.

	usesNeeded := self usesNeeded.

	self assert: usesNeeded size equals: 1.

	self assert: usesNeeded anyOne key class equals: FamixF77PUSubroutine.
	self assert: usesNeeded anyOne value class equals: FamixEsopeSegment.
]

{ #category : 'tests' }
FASTFortranUseTransformationVisitorTest >> testProcedureWithSegment [
	"usesNeeded: N/A"

	| usesNeeded |
	self functionWithSegment.

	fastProcedures anyOne accept: visitor.

	usesNeeded := self usesNeeded.

	self assert: usesNeeded size equals: 0
]

{ #category : 'tests' }
FASTFortranUseTransformationVisitorTest >> testProgramWithExternalFunctionCall [
	"use needed:
	demo -> fct	
	"
	| usesNeeded |
	self programWithExternalFunctionCall.

	fastMainProgram accept: visitor.
	
	usesNeeded := self usesNeeded.

	self assert: usesNeeded size equals: 1.

	self assert: usesNeeded anyOne key class equals: FamixF77PUMain.
	self assert: usesNeeded anyOne value class equals: FamixF77PUFunction.
]

{ #category : 'tests' }
FASTFortranUseTransformationVisitorTest >> testProgramWithProcedureInvoked [
	"usesNeeded:
		demo -> sub"

	| usesNeeded |
	self programWithProcedureInvoked.

	fastMainProgram accept: visitor.

	usesNeeded := self usesNeeded.

	self assert: usesNeeded size equals: 1.

	self assert: usesNeeded anyOne key class equals: FamixF77PUMain.
	self assert: usesNeeded anyOne value class equals: FamixF77PUSubroutine.
]

{ #category : 'tests' }
FASTFortranUseTransformationVisitorTest >> testProgramWithSegment [
	"usesNeeded: N/A"

	| usesNeeded |
	self programWithSegment.

	fastMainProgram accept: visitor.

	usesNeeded := self usesNeeded.

	self assert: usesNeeded size equals: 0
]

{ #category : 'tests' }
FASTFortranUseTransformationVisitorTest >> testStatementFunctionWithExternalFunctionCall [
	"use needed:
	fct -> toto	
	"
	| usesNeeded |
	self statementFunctionWithExternalFunctionCall.

	fastMainProgram accept: visitor.
	
	usesNeeded := self usesNeeded.

	self assert: usesNeeded size equals: 1.

	self assert: usesNeeded anyOne key class equals: FamixF77StatementFunction.
	self assert: usesNeeded anyOne value class equals: FamixF77PUFunction.
]

{ #category : 'tests' }
FASTFortranUseTransformationVisitorTest >> testSubroutineAndFunctionWithCall [

    "usesNeeded:
		sub -> sub2"

    |  usesNeeded |
	self subroutineWithExternalSubroutineInvocation.

   fastProcedures anyOne accept: visitor.

	usesNeeded := self usesNeeded.

	self assert: usesNeeded size equals: 1.

	self assert: usesNeeded anyOne key class equals: FamixF77PUSubroutine.
	self assert: usesNeeded anyOne key name equals: 'sub'.

	self assert: usesNeeded anyOne value class equals: FamixF77PUSubroutine.
	self assert: usesNeeded anyOne value name equals: 'sub2'.
]

{ #category : 'tests' }
FASTFortranUseTransformationVisitorTest >> testSubroutineWithFunctionStatement [

    "usesNeeded: N/A"

    |  usesNeeded |
	self subroutineWithFunctionStatement.

   fastProcedures anyOne accept: visitor.

	usesNeeded := self usesNeeded.

	self assert: usesNeeded size equals: 0
]

{ #category : 'tests' }
FASTFortranUseTransformationVisitorTest >> testSubroutineWithFunctionStatementCalled [

    "usesNeeded: N/A"

    |  usesNeeded |
	self subroutineWithFunctionStatementCalled.

   fastProcedures anyOne accept: visitor.

	usesNeeded := self usesNeeded.

	self assert: usesNeeded size equals: 0
]

{ #category : 'running' }
FASTFortranUseTransformationVisitorTest >> usesNeeded [ 

	^visitor parentTransformator usesNeeded
]

{ #category : 'running' }
FASTFortranUseTransformationVisitorTest >> visitorClass [ 

	^FASTFortranUseTransformationVisitor
]
