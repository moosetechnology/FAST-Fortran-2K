Class {
	#name : 'FASTFortranBackTracingTest',
	#superclass : 'FASTFortranAbstractTransformationVisitorTest',
	#instVars : [
		'parentVisitor'
	],
	#category : 'Famix-Esope-Transformator-Tests-Visitors',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Visitors'
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
FASTFortranBackTracingTest >> testCallStatementNoArguments [
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
FASTFortranBackTracingTest >> testComment [
	| stmt res |

	stmt := FASTFortranComment new
		startPos: 5 ;
		endPos: 35.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kComment.

	self assert: res startPos equals: 5.
	self assert: res endPos equals: 35.
]

{ #category : 'tests-statement' }
FASTFortranBackTracingTest >> testDerivedTypeDeclaration [
	| res stmt |

	stmt := FASTEsopePointerDeclarationStatement new.
	stmt 
		startPos: 12 ;
		endPos: 33.
	stmt addPointerDeclarator: (FASTEsopePointerDeclarator new
		variableDeclarator: (FASTFortranVariableDeclarator new
			famixDeclaration: FamixF77Variable new) ).
	
	visitor stack push: FASTFortranSubroutine new.
	res := stmt accept: visitor.

	self assert: res size equals: 1.
	res := res anyOne.
	self assert: res class equals: FASTFortran2kVariableDeclarationStatement.

	self assert: res startPos equals: 12.
	self assert: res endPos equals: 33. 
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

{ #category : 'tests-statement' }
FASTFortranBackTracingTest >> testVariableDeclarationStatement [
	| res stmt |

	stmt := self declarationStatement: #str type: #(character 20).

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kVariableDeclarationStatement.

	self assert: res startPos equals: 1.
	self assert: res endPos equals: 10.
]

{ #category : 'running' }
FASTFortranBackTracingTest >> visitorClass [ 
	"Some visit need a Program Unit container (in the visitor's stack)
	 In this case, the test must use a FamixF77PUMain"

	^FASTFortranBehavioralTransformationVisitor 
]
