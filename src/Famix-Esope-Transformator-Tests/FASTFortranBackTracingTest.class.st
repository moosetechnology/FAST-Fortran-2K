Class {
	#name : 'FASTFortranBackTracingTest',
	#superclass : 'FASTFortranAbstractTransformationVisitorTest',
	#instVars : [
		'parentVisitor'
	],
	#category : 'Famix-Esope-Transformator-Tests',
	#package : 'Famix-Esope-Transformator-Tests'
}

{ #category : 'tests-statement' }
FASTFortranBackTracingTest >> testAssignementStatementLiteralValue [
	| stmt res |
	stmt := self assignementStatement: #aVar value: (self logicalLiteral: '.true.').
	stmt
		startPos: 5 ;
		endPos: 17.

	res := stmt accept: visitor.
	
	self assert: res class equals: FASTFortran2kAssignmentStatement.

	self assert: res startPos equals: 5.
	self assert: res endPos equals: 17.
]

{ #category : 'tests-statement' }
FASTFortranBackTracingTest >> testEsopeToF2kCallStatementNoArguments [
	| stmt res |

	stmt := FASTFortranCallStatement new
		name: 'subrtn' ;
		startPos: 5 ;
		endPos: 18.

	stmt famix: (FamixF77Invocation new
		candidates: { FamixF77PUSubroutine new name: 'subrtn' }).
	visitor stack push: FASTFortran2kProgramMain new.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kCallStatement.


	self assert: res startPos equals: 5.
	self assert: res endPos equals: 18.
]

{ #category : 'tests-statement' }
FASTFortranBackTracingTest >> testEsopeToF2kVariableDeclarationStatement [
	| res stmt |

	stmt := self declarationStatement: #str type: #(character 20).

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kVariableDeclarationStatement.


	self assert: res startPos equals: 1.
	self assert: res endPos equals: 10.
]

{ #category : 'tests-statement' }
FASTFortranBackTracingTest >> testStatementNoPosition [
	| stmt res |
	stmt := self assignementStatement: #aVar value: (self logicalLiteral: '.true.').

	res := stmt accept: visitor.
	
	self assert: res class equals: FASTFortran2kAssignmentStatement.


	self assert: res startPos equals: 0.
	self assert: res endPos equals: 0.
]

{ #category : 'running' }
FASTFortranBackTracingTest >> visitorClass [ 
	"Some visit need a Program Unit container (in the visitor's stack)
	 In this case, the test must use a FamixF77PUMain"

	^FASTFortranMainTransformationVisitor 
]
