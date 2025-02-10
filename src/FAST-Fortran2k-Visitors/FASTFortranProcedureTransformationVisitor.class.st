Class {
	#name : 'FASTFortranProcedureTransformationVisitor',
	#superclass : 'FASTFortranBehavioralTransformationVisitor',
	#instVars : [
		'allModules'
	],
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'helpers - segment' }
FASTFortranProcedureTransformationVisitor >> createModule: moduleName [

	| module |
	module := self model newModule
		name: moduleName ;
		statementBlock: (self model newStatementBlock
			addStatement: self model newImplicitStatement ;
			yourself ) ;
		yourself.
	
	
	self model newProgramFile
		filename: (moduleName , '.f90') ;
		programUnit: {  module } ;
		yourself.

	^module

]

{ #category : 'helpers - segment' }
FASTFortranProcedureTransformationVisitor >> ensureModule: filename [

	^self getModule: filename ifAbsentPut: [ self createModule: filename ]
]

{ #category : 'helpers - segment' }
FASTFortranProcedureTransformationVisitor >> getModule: filename ifAbsentPut: aBlock [

	^parentTransformator getModule: filename ifAbsentPut: aBlock
]

{ #category : 'visiting - programUnits' }
FASTFortranProcedureTransformationVisitor >> visitFASTEsopeSegment: aFASTEsopeSegmentNode [

	^nil
]

{ #category : 'visiting - programUnits' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranFunction: aFASTFortranFunction [

	| function module |

	module := self ensureModule: aFASTFortranFunction famix migratedModuleName. 

	function := self model newFunction
		name: aFASTFortranFunction name ;
		returnType: (aFASTFortranFunction famix declaredType accept: self);
		module: module ;
		yourself.

	stack push: function.

	function parameters: (aFASTFortranFunction parameters collect: [ :parameter | parameter accept: self ]).
	function statementBlock: (aFASTFortranFunction statementBlock accept: self).

	stack pop.

	^module parentProgramFile
]

{ #category : 'visiting - programUnits' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranSubroutine: aFASTFortranSubroutine [

	| subrtn module |

	module := self ensureModule: aFASTFortranSubroutine famix migratedModuleName. 

	subrtn := self model newSubroutine
		name: aFASTFortranSubroutine name ;
		module: module ;
		yourself.

	stack push: subrtn.

	subrtn parameters: (aFASTFortranSubroutine parameters collect: [ :parameter | parameter accept: self ]).	
	subrtn statementBlock: (aFASTFortranSubroutine statementBlock accept: self).

	stack pop.

	^module parentProgramFile
]
