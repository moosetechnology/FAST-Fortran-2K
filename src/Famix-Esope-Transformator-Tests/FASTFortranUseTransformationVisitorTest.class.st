Class {
	#name : 'FASTFortranUseTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractTransformationVisitorTest',
	#category : 'Famix-Esope-Transformator-Tests',
	#package : 'Famix-Esope-Transformator-Tests'
}

{ #category : 'tests-statement' }
FASTFortranUseTransformationVisitorTest >> testEsopeToF2kExternalStatement [
	| stmt res |

	self programEmpty.

	stmt := (self externalStatement: 'mypnt').
	fastMainProgram statementBlock addStatement: stmt.
	stmt famix: (
		FamixF77ExternalDeclaration new 
			name: 'mypnt'; 
			programUnit: fastMainProgram famix; 
			yourself
	).

	res := stmt accept: visitor.

	self assert: res isNil.
	self assert: visitor parentTransformator usesNeeded size equals: 1.
	self assert: visitor parentTransformator usesNeeded anyOne key equals: fastMainProgram famix.
	self assert: visitor parentTransformator usesNeeded anyOne value isNil.
]

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
