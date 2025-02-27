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

	| function2k module2k |

	module2k := self ensureModule: aFASTFortranFunction famix migratedModuleName.

	function2k := self model2k newFunction
		name: aFASTFortranFunction name ;
		declaredType: (aFASTFortranFunction famix declaredType accept: self);
		module: module2k ;
		backTrace: aFASTFortranFunction programFile filename ;
		yourself.
	aFASTFortranFunction transformed2k: function2k.


	stack push: function2k.

	function2k parameters: (self visitFASTFortranList: aFASTFortranFunction parameters).
	function2k statementBlock: (aFASTFortranFunction statementBlock accept: self).

	self handleProgramUnitSegmentDeclaration: aFASTFortranFunction declarations.

	stack pop.

	^module2k programFile
]

{ #category : 'visiting - programUnits' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranSubroutine: aFASTFortranSubroutine [

	| subrtn2k module2k |

	module2k := self ensureModule: aFASTFortranSubroutine famix migratedModuleName. 

	subrtn2k := self model2k newSubroutine
		name: aFASTFortranSubroutine name ;
		module: module2k ;
		backTrace: aFASTFortranSubroutine programFile filename ;
		yourself.
	aFASTFortranSubroutine transformed2k: subrtn2k.

	stack push: subrtn2k.

	subrtn2k parameters: (self visitFASTFortranList: aFASTFortranSubroutine parameters).
	subrtn2k statementBlock: (aFASTFortranSubroutine statementBlock accept: self).

	self handleProgramUnitSegmentDeclaration: aFASTFortranSubroutine declarations.

	stack pop.

	^module2k programFile
]
