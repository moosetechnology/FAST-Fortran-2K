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

	parametersToDeclare
		detect: [ :association |
			aFASTFortran2kVariableDeclarationStatement declarators anySatisfy: [ :declarator |
				association key name = declarator name]
		]
		ifOne: [ :assoc |
			parametersToDeclare remove: assoc.
			aFASTFortran2kVariableDeclarationStatement modifiers: (aFASTFortran2kVariableDeclarationStatement modifiers, { assoc value })
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
FASTFortranProcedureTransformationVisitor >> declaredMissingParameters: subrtn2k [
	"adding all missing parameterDeclarations + some comments to explain a bit
	 note that because we use #addFirst:, statement must be added in reverse order"

	parametersToDeclare ifEmpty: [ ^self ].

	subrtn2k statementBlock statements addFirst: (model2k newEmptyStatement).
	parametersToDeclare do: [ :param |
		subrtn2k statementBlock statements addFirst: (self missedParameterDeclaration: param)
	].
	subrtn2k statementBlock statements addFirst: (model2k newComment content: '[ooo] missing parameter declarations added')
]

{ #category : 'helpers - segment' }
FASTFortranProcedureTransformationVisitor >> ensureModule: famixEntity [

	| moduleName |
	moduleName := famixEntity  migratedModuleName.
	^self getModule: moduleName ifAbsentPut: [ self createModule: famixEntity ]
]

{ #category : 'helpers - segment' }
FASTFortranProcedureTransformationVisitor >> getModule: filename ifAbsentPut: aBlock [

	^parentTransformator getModule: filename ifAbsentPut: aBlock
]

{ #category : 'helpers - parameters' }
FASTFortranProcedureTransformationVisitor >> isItASpecialInvocation: anInvocationName with: famixParameter [
	| aString |

	aString  := anInvocationName asLowercase.

	(#( inistr ajpnt ) includes: aString) ifFalse: [ ^false ].
	famixParameter parentBehaviouralEntity ifNil: [ ^false ].

	^(famixParameter parentBehaviouralEntity outgoingInvocations collect: #fast) 
		anySatisfy: [ :fastInvoc |
			fastInvoc name asLowercase = aString 
			and: [ fastInvoc arguments 
				ifNotEmpty:  [ :args | args first name asLowercase = famixParameter name asLowercase ] 
			]
		]
]

{ #category : 'helpers - parameters' }
FASTFortranProcedureTransformationVisitor >> missedParameterDeclaration: association [
	"adding a parameter declaration that was missing in the old source"

	| fastParam intent |
	fastParam := association key.
	intent := association value.

	^model2k newVariableDeclarationStatement
		declaredType: (fastParam famixParameter declaredType accept: self);
		declarators: { model2k newVariableDeclarator
			name: fastParam name } ;
		modifiers: { intent }

]

{ #category : 'helpers - parameters' }
FASTFortranProcedureTransformationVisitor >> paramIntentFromAccesses: paramF77 [
	"computing intent from access
	  - take into account function/subroutine invocations where the parameter is used"

	| hasIn hasOut |

	(self isItASpecialInvocation: #inistr with: paramF77) ifTrue: [ ^ 'intent(out)' ].
	(self isItASpecialInvocation: #ajpnt with: paramF77) ifTrue: [ ^ 'intent(inOut)' ].

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
FASTFortranProcedureTransformationVisitor >> parametersIntent: procedure2k from: parametersF77 [
	"compute intent for procedure2k's parmeters
	 returns a list of parameters and their intent. Will be used to check that all parameters are declared
	 Note that the order of the 2 lists should match"

	^parametersToDeclare := procedure2k parameters with: parametersF77 collect: [ :param2k :paramF77 |
		self assert: param2k name = paramF77 name.

		paramF77 -> (self paramIntentFromAccesses: paramF77 famixParameter)
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
		declaredType: (aFASTFortranFunction famix declaredType accept: self);
		module: module2k ;
		backTrace: aFASTFortranFunction programFile filename ;
		yourself.
	aFASTFortranFunction transformed2k: function2k.


	stack push: function2k.

	function2k parameters: (self visitFASTFortranList: aFASTFortranFunction parameters).
	parametersToDeclare := self parametersIntent: function2k from: aFASTFortranFunction parameters.
	function2k statementBlock: (aFASTFortranFunction statementBlock accept: self).
	parametersToDeclare do: [ :param |
		function2k statementBlock statements addFirst: (self missedParameterDeclaration: param)
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
	parametersToDeclare := self parametersIntent: subrtn2k from: aFASTFortranSubroutine parameters.

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

{ #category : 'visiting' }
FASTFortranProcedureTransformationVisitor >> visitFamixTWithAccesses: aFamixEsopeSegment [ 
	"this is called from #missedParameterDeclaration:, when a pointer parameter was not declared
	 we must create a declaredType for this parameter"

	^model2k newUserDefinedType
		name: aFamixEsopeSegment name
]
