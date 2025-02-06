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
