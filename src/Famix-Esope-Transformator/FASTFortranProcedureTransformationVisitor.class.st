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

	aFASTFortran2kVariableDeclarationStatement ifNil: [ ^ nil ].

	(aFASTFortran2kVariableDeclarationStatement detectMatchingEntityIn:
		parametersToDeclare) ifNotNil: [ :param |
			parametersToDeclare remove: param.
			aFASTFortran2kVariableDeclarationStatement addModifier:
				(param famixParameter cacheAt: #intent) 
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
		filename: (famixEntity programFile filename copyUpToSubstring: '.') ,  '_m.f90' ;
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
FASTFortranProcedureTransformationVisitor >> parameterIntent: paramF77 [
	"computing intent for a parameter.
	 There are various possible rules that may apply"

	Fortran2kIntentAbstractRule checkAllRulesFor: paramF77.

	^ paramF77 cacheAt: #intent
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
	"create a Fortran2k subroutine, migrate the code, return the programFile"

	stack push: (self makeProcedure: FASTFortran2kFunction fromF77: aFASTFortranFunction).

	self visitFASTFortranProcedure: aFASTFortranFunction.
	stack top declaredType: (aFASTFortranFunction famix declaredType generateF2kInModel: model2k).

	^stack pop module programFile

]

{ #category : 'visiting - programUnits' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranProcedure: aFASTFortran77Procedure [
	"- migrate parameters
	 - migrate procedure's body
	 - add declarations for parameters that were not explicitly declared
	 - don't know what the last step does"

	| fortran2kProcedure |
	
	fortran2kProcedure := stack top.

	self visitFASTFortranTWithParameters: aFASTFortran77Procedure.

	fortran2kProcedure statementBlock: (aFASTFortran77Procedure statementBlock accept: self).

	self declareMissingParameters: fortran2kProcedure.

	self handleProgramUnitSegmentDeclaration: aFASTFortran77Procedure declarations.

	^fortran2kProcedure
]

{ #category : 'visiting - programUnits' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranSubroutine: aFASTFortranSubroutine [
	"create a Fortran2k subroutine, migrate the code, return the programFile"

	stack push: (self makeProcedure: FASTFortran2kSubroutine fromF77: aFASTFortranSubroutine).

	self visitFASTFortranProcedure: aFASTFortranSubroutine.
	
	^stack pop module programFile
]

{ #category : 'visiting - traits' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranTWithParameters: aFASTFortran77Procedure [
	"compute 'intent' for each parameter then migrate all of them
	Note: need to keep all paramters in instance variable #parametersToDeclare to know, after statements
	 migration, which parameters were not explicitly declared"

	parametersToDeclare := aFASTFortran77Procedure parameters.

	parametersToDeclare do: [ :paramFast77 |
			paramFast77 famixParameter
				cacheAt: #intent
				ifAbsentPut: [ self parameterIntent: paramFast77 famixParameter ] ].

	self stack top parameters:
		(self visitFASTFortranList: parametersToDeclare)
]

{ #category : 'visiting - statements' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	^self checkForParameterDeclaration: (super
		visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement)
]
