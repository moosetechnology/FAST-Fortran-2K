Class {
	#name : 'FASTFortranMainTransformationVisitor',
	#superclass : 'FASTFortranBehavioralTransformationVisitor',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'helpers' }
FASTFortranMainTransformationVisitor >> fortran2kFilename: f77ProgramMain [
	"assuming F77 filename is of the form: 'xyz.f' "
	
	^f77ProgramMain famix programFile filename , '90'
]

{ #category : 'visiting - programUnits' }
FASTFortranMainTransformationVisitor >> visitFASTFortranFunction: aFASTFortranFunction [

	^nil
]

{ #category : 'visiting - programUnits' }
FASTFortranMainTransformationVisitor >> visitFASTFortranProgramMain: aProgramNode [

	| programMain programFile |
	
	programFile := self model newProgramFile
		filename: (self fortran2kFilename: aProgramNode) ;
		yourself.

	programMain := self model newProgramMain 
		name: aProgramNode name;
		programFile: programFile ;
		backTrace: aProgramNode programFile filename ;
		yourself.

	stack push: programMain.
	
	programMain statementBlock: (aProgramNode statementBlock accept: self).
	programMain statementBlock statements addFirst: self model newImplicitStatement.

	self handleProgramUnitSegmentDeclaration: aProgramNode declarations.

	stack pop.

	^programFile
]

{ #category : 'visiting - programUnits' }
FASTFortranMainTransformationVisitor >> visitFASTFortranSubroutine: aFASTFortranSubroutine [

	^nil
]
