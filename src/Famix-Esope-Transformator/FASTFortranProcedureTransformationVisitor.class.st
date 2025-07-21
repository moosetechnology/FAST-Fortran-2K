Class {
	#name : 'FASTFortranProcedureTransformationVisitor',
	#superclass : 'FASTFortranBehavioralTransformationVisitor',
	#instVars : [
		'allModules',
		'parametersToDeclare'
	],
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'helpers - parameters' }
FASTFortranProcedureTransformationVisitor >> checkForParameterDeclaration: aFASTFortran2kVariableDeclarationStatement [
	"if aFASTFortran2kVariableDeclarationStatement match the name of a parametersToDeclare
	then remove it from the list to declare and set its intent"

	aFASTFortran2kVariableDeclarationStatement ifNil: [ ^nil ].

	(aFASTFortran2kVariableDeclarationStatement detectMatchingEntityIn: parametersToDeclare)
		ifNotNil: [ :param |
			parametersToDeclare remove: param.
			aFASTFortran2kVariableDeclarationStatement addModifier: (param famixParameter propertyNamed: #intent)
		].

	^aFASTFortran2kVariableDeclarationStatement 
]

{ #category : 'helpers - segment' }
FASTFortranProcedureTransformationVisitor >> createModule: famixEntity [

	| module |
	
	module := self model2k newModule
		name: famixEntity  migratedModuleName ;
		statementBlock: (self model2k newStatementBlock
			addStatement: self model2k newImplicitStatement ;
			yourself ) ;
		yourself.
	
	
	self model2k newProgramFile
		filename: (famixEntity programFile filename copyUpToSubstring: '.') ,  '_mod.f90' ;
		programUnits: {  module }.

	^module

]

{ #category : 'helpers - parameters' }
FASTFortranProcedureTransformationVisitor >> declareMissingParameters: subrtn2k [
	"adding all missing parameterDeclarations + some comments to explain a bit
	 Because we use #addFirst:, the order of all the statement is inverted"

	parametersToDeclare ifEmpty: [ ^self ].

	subrtn2k statementBlock statements addFirst: (model2k newEmptyStatement).

	parametersToDeclare reversed do: [ :param |
		subrtn2k statementBlock statements
			addFirst: (param generateF2kDeclarationInModel: model2k)
	].

]

{ #category : 'helpers - segment' }
FASTFortranProcedureTransformationVisitor >> ensureModule: famixEntity [

	| moduleName |
	moduleName := famixEntity  migratedModuleName.
	^parentTransformator getModule: moduleName ifAbsentPut: [ self createModule: famixEntity ]
]

{ #category : 'helpers - parameters' }
FASTFortranProcedureTransformationVisitor >> paramIntentFromAccesses: paramF77 [
	"computing intent from access
	  - take into account function/subroutine invocations where the parameter is used"

	| hasIn hasOut |

	(paramF77 isArgumentOfInvocation: #inistr) ifTrue: [ ^ 'intent(out)' ].
	(paramF77 isArgumentOfInvocation: #ajpnt) ifTrue: [ ^ 'intent(inOut)' ].

	hasIn := paramF77 incomingAccesses anySatisfy: [ :acc | acc isWrite not].
	hasOut := paramF77 incomingAccesses anySatisfy: #isWrite.

	^hasIn
		ifTrue: [
			hasOut
				ifTrue: [ 'intent(inOut)' ]
				ifFalse: [ 'intent(in)' ]
		]
		ifFalse: [
			hasOut
				ifTrue: [ 'intent(out)' ]
				ifFalse: [ 'intent(in)' ]
		]
]

{ #category : 'helpers - parameters' }
FASTFortranProcedureTransformationVisitor >> parametersIntent: parametersFAST77 [
	"compute intent for a list of FASTF77Parameters
	 Sets the intent of the F77 parameters"

	parametersFAST77 do: [ :paramFast77 |
		paramFast77 famixParameter
			propertyNamed: #intent
			put: (self paramIntentFromAccesses: paramFast77 famixParameter).
	]
]

{ #category : 'accessing - private tests' }
FASTFortranProcedureTransformationVisitor >> parametersToDeclare [

	^parametersToDeclare
]

{ #category : 'visiting - statements' }
FASTFortranProcedureTransformationVisitor >> visitFASTEsopePointerDeclarator: aFASTEsopePointerDeclarator [ 

	^self checkForParameterDeclaration: (super
		visitFASTEsopePointerDeclarator: aFASTEsopePointerDeclarator)
]

{ #category : 'visiting - programUnits' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranFunction: aFASTFortranFunction [

	| function2k module2k |

	module2k := self ensureModule: aFASTFortranFunction famix.

	function2k := self model2k newFunction
		name: aFASTFortranFunction name ;
		declaredType: (aFASTFortranFunction famix declaredType generateF2kInModel: model2k);
		module: module2k ;
		backTrace: aFASTFortranFunction programFile filename ;
		yourself.
	aFASTFortranFunction transformed2k: function2k.


	stack push: function2k.

	function2k parameters: (self visitFASTFortranList: aFASTFortranFunction parameters).
	parametersToDeclare := aFASTFortranFunction parameters.
	self parametersIntent: parametersToDeclare.

	function2k statementBlock: (aFASTFortranFunction statementBlock accept: self).

	parametersToDeclare do: [ :param |
		function2k statementBlock statements addFirst: (param generateF2kDeclarationInModel: model2k)
	].

	self handleProgramUnitSegmentDeclaration: aFASTFortranFunction declarations.

	stack pop.

	^module2k programFile
]

{ #category : 'visiting - programUnits' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranSubroutine: aFASTFortranSubroutine [

	| subrtn2k module2k |

	module2k := self ensureModule: aFASTFortranSubroutine famix. 

	subrtn2k := self model2k newSubroutine
		name: aFASTFortranSubroutine name ;
		module: module2k ;
		backTrace: aFASTFortranSubroutine programFile filename ;
		yourself.
	aFASTFortranSubroutine transformed2k: subrtn2k.

	stack push: subrtn2k.

	subrtn2k parameters: (self visitFASTFortranList: aFASTFortranSubroutine parameters).
	parametersToDeclare := aFASTFortranSubroutine parameters.
	self parametersIntent: parametersToDeclare.

	subrtn2k statementBlock: (aFASTFortranSubroutine statementBlock accept: self).

	self declaredMissingParameters: subrtn2k.

	self handleProgramUnitSegmentDeclaration: aFASTFortranSubroutine declarations.

	stack pop.

	^module2k programFile
]

{ #category : 'visiting - statements' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	^self checkForParameterDeclaration: (super
		visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement)
]
