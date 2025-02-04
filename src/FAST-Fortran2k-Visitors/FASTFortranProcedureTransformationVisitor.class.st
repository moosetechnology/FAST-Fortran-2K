Class {
	#name : 'FASTFortranProcedureTransformationVisitor',
	#superclass : 'FASTFortranBehavioralTransformationVisitor',
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'visiting - programUnits' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranFunction: aFASTFortranFunction [

	| function module |

	module := self ensureModule: aFASTFortranFunction famix migratedModuleName. 

	function := self model newFunction
		name: aFASTFortranFunction name ;
		module: module ;
		yourself.

	stack push: function.
	
	function statementBlock: (aFASTFortranFunction statementBlock accept: self).

	stack pop.

	^module parentProgramFile
]

{ #category : 'visiting - programUnits' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranSubroutine: aFASTFortranSubroutine [

	| subroutine |
	subroutine := model newSubroutine
		name: aFASTFortranSubroutine name;
		yourself.
		
	stack push: subroutine.

	subroutine statementBlock: (aFASTFortranSubroutine statementBlock accept: self).
	
	stack pop.
	^subroutine.
]
