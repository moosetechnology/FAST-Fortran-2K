Class {
	#name : 'FASTFortranProcedureTransformationVisitor',
	#superclass : 'FASTFortranBehavioralTransformationVisitor',
	#instVars : [
		'allModules'
	],
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'helpers - segment' }
FASTFortranProcedureTransformationVisitor >> createModule: moduleName [

	| module |
	
	module := self model2k newModule
		name: (($/ split: moduleName) last) ;
		statementBlock: (self model2k newStatementBlock
			addStatement: self model2k newImplicitStatement ;
			yourself ) ;
		yourself.
	
	
	self model2k newProgramFile
		filename: (moduleName , '.f90') ;
		programUnits: {  module }.

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
FASTFortranProcedureTransformationVisitor >> visitFASTFortranFunction: aFASTFortranFunction [

	| function module |

	module := self ensureModule: aFASTFortranFunction famix migratedModuleName. 

	function := self model2k newFunction
		name: aFASTFortranFunction name ;
		declaredType: (aFASTFortranFunction famix declaredType accept: self);
		module: module ;
		backTrace: aFASTFortranFunction programFile filename ;
		yourself.

	stack push: function.

	function parameters: (self visitFASTFortranList: aFASTFortranFunction parameters).
	function statementBlock: (aFASTFortranFunction statementBlock accept: self).

	self handleProgramUnitSegmentDeclaration: aFASTFortranFunction declarations.

	stack pop.

	^module programFile
]

{ #category : 'visiting - programUnits' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranSubroutine: aFASTFortranSubroutine [

	| subrtn module |

	module := self ensureModule: aFASTFortranSubroutine famix migratedModuleName. 

	subrtn := self model2k newSubroutine
		name: aFASTFortranSubroutine name ;
		module: module ;
		backTrace: aFASTFortranSubroutine programFile filename ;
		yourself.

	stack push: subrtn.

	subrtn parameters: (self visitFASTFortranList: aFASTFortranSubroutine parameters).
	subrtn statementBlock: (aFASTFortranSubroutine statementBlock accept: self).

	self handleProgramUnitSegmentDeclaration: aFASTFortranSubroutine declarations.

	stack pop.

	^module programFile
]
