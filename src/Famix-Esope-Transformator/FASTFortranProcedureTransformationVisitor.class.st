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

{ #category : 'helpers' }
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

{ #category : 'helpers' }
FASTFortranProcedureTransformationVisitor >> ensureModule: famixEntity [

	| moduleName |
	moduleName := famixEntity  migratedModuleName.
	^parentTransformator getModule: moduleName ifAbsentPut: [ self createModule: famixEntity ]
]

{ #category : 'helpers' }
FASTFortranProcedureTransformationVisitor >> makeProcedure: aFASTFortran2kProcedureClass fromF77: aFASTFortran77Procedure [
	"In FASTFortran2k, procedures (subroutines and functions) are created whithin their own module"

	| fortran2kProcedure |

	fortran2kProcedure := aFASTFortran2kProcedureClass new
		mooseModel: self model2k ;
		name: aFASTFortran77Procedure name ;
		module: (self ensureModule: aFASTFortran77Procedure famix) ;
		backTrace: aFASTFortran77Procedure programFile filename ;
		yourself.
	aFASTFortran77Procedure transformed2k: fortran2kProcedure.

	^fortran2kProcedure 
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

	| fortran2kFunction |

	fortran2kFunction := self visitFASTFortranProcedure: aFASTFortranFunction toType: FASTFortran2kFunction.
	fortran2kFunction declaredType: (aFASTFortranFunction famix declaredType generateF2kInModel: model2k).

	^fortran2kFunction	module programFile
]

{ #category : 'visiting - programUnits' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranProcedure: aFASTFortran77Procedure toType: aFASTFortran2kProcedureClass [
	"need to
	 - create a Fortran2k procedure
	 - compute intents of the parameters
	 - migrate parameters and statements
	 - handle parameters that were not explicitly declared
	 - extra step that I don't understand"

	| fortran2kProcedure |

	fortran2kProcedure := self makeProcedure: aFASTFortran2kProcedureClass fromF77: aFASTFortran77Procedure.

	stack push: fortran2kProcedure.

	parametersToDeclare := aFASTFortran77Procedure parameters.
	self parametersIntent: parametersToDeclare.

	fortran2kProcedure parameters: (self visitFASTFortranList: parametersToDeclare).
	fortran2kProcedure statementBlock: (aFASTFortran77Procedure statementBlock accept: self).

	self declareMissingParameters: fortran2kProcedure.

	self handleProgramUnitSegmentDeclaration: aFASTFortran77Procedure declarations.

	stack pop.

	^fortran2kProcedure
]

{ #category : 'visiting - programUnits' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranSubroutine: aFASTFortranSubroutine [

	^(self visitFASTFortranProcedure: aFASTFortranSubroutine toType: FASTFortran2kSubroutine)
		module programFile
]

{ #category : 'visiting - statements' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	^self checkForParameterDeclaration: (super
		visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement)
]
