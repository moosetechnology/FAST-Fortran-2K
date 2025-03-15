Class {
	#name : 'FASTFortranIncludedFileTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractTransformationVisitorTest',
	#instVars : [
		'parentVisitor'
	],
	#category : 'Famix-Esope-Transformator-Tests-Visitors',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Visitors'
}

{ #category : 'running' }
FASTFortranIncludedFileTransformationVisitorTest >> setUp [ 

	super setUp.

	FASTFortranIncludedFile new
		declarations: #() ;
		statementBlock: (self statementBlock: #()) ;
		programFile: fastProgramFile
]

{ #category : 'tests' }
FASTFortranIncludedFileTransformationVisitorTest >> testNoStatement [

	| res |
	res := fastProgramFile programUnits anyOne accept: visitor.

	self assert: res isEmpty
]

{ #category : 'tests' }
FASTFortranIncludedFileTransformationVisitorTest >> testWithComments [

	| res includedFile |
	includedFile := fastProgramFile programUnits anyOne.
	includedFile statementBlock addStatement: (self comment: 'first comment').
	includedFile statementBlock addStatement:  (self comment: 'second comment').

	res := includedFile accept: visitor.

	self assert: res size equals: 2.

	res do: [ :cmt |
		self assert: cmt class equals: FASTFortran2kComment.
		self assert: cmt startPos equals: 0.
		self assert: cmt endPos equals: 0.
	]
]

{ #category : 'tests' }
FASTFortranIncludedFileTransformationVisitorTest >> testWithVariableDeclaration [

	| res includedFile |
	includedFile := fastProgramFile programUnits anyOne.
	includedFile statementBlock
		addStatement: (self arrayDeclaration: 'arr' dimensions: #()).

	res := includedFile accept: visitor.

	self assert: res size equals: 1.
	
	self assert: res anyOne class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: res anyOne startPos equals: 0.
	self assert: res anyOne endPos equals: 0.

]

{ #category : 'running' }
FASTFortranIncludedFileTransformationVisitorTest >> visitorClass [ 

	^FASTFortranIncludedFileTransformationVisitor 
]
