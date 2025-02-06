Class {
	#name : 'FASTFortranUseTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractTransformationVisitorTest',
	#category : 'FAST-Fortran2k-Visitors-Tests',
	#package : 'FAST-Fortran2k-Visitors-Tests'
}

{ #category : 'running' }
FASTFortranUseTransformationVisitorTest >> newVisitor [

	^FASTFortranUseTransformationVisitor new
		parentVisitor: FASTFortranTransformationVisitor new
]

{ #category : 'tests' }
FASTFortranUseTransformationVisitorTest >> testProcedureWithPointeurDeclaration [

    "usesNeeded:
		sub -> foo"

    |  usesNeeded |
	self subroutineWithPointeurDeclaration.

   fastProcedures anyOne accept: visitor.

	usesNeeded := visitor usesNeeded.

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

	usesNeeded := visitor usesNeeded.

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
	
	usesNeeded := visitor usesNeeded.

	self assert: usesNeeded size equals: 1.

	self assert: usesNeeded anyOne key class equals: FamixF77PUMain.
	self assert: usesNeeded anyOne value class equals: FamixF77PUFunction.
]

{ #category : 'tests' }
FASTFortranUseTransformationVisitorTest >> testStatementFunctionWithExternalFunctionCall [
	"use needed:
	demo -> toto	
	"
	| usesNeeded |
	self statementFunctionWithExternalFunctionCall.

	fastMainProgram accept: visitor.
	
	usesNeeded := visitor usesNeeded.

	self assert: usesNeeded size equals: 1.

	self assert: usesNeeded anyOne key class equals: FamixF77PUMain.
	self assert: usesNeeded anyOne value class equals: FamixF77PUFunction.
]
