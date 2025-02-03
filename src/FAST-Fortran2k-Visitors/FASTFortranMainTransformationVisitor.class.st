Class {
	#name : 'FASTFortranMainTransformationVisitor',
	#superclass : 'FASTFortranBehavioralTransformationVisitor',
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'helpers' }
FASTFortranMainTransformationVisitor >> fortran2kFilename: f77ProgramMain [
	"assuming F77 filename is of the form: 'xyz.f' "
	
	^f77ProgramMain parentProgramFile famix filename , '90'
]

{ #category : 'visiting - programUnits' }
FASTFortranMainTransformationVisitor >> visitFASTFortranFunction: aFASTFortranFunction [
]

{ #category : 'visiting - programUnits' }
FASTFortranMainTransformationVisitor >> visitFASTFortranProgramMain: aProgramNode [

	| programMain programFile |
	
	programFile := FASTFortran2kProgramFile new
		mooseModel: model;
		filename: (self fortran2kFilename: aProgramNode) ;
		yourself.

	programMain := FASTFortran2kProgramMain new 
		name: aProgramNode name;
		parentProgramFile: programFile ;
		mooseModel: model; 
		yourself.

	stack push: programMain.
	
	programMain statementBlock: (aProgramNode statementBlock accept: self).
	
	programMain statementBlock statements
		detect: [ :statement | statement class = FASTFortran2kImplicitStatement ]
		ifNone: [ programMain statementBlock statements addFirst: FASTFortran2kImplicitStatement new ].

	stack pop.
	^programMain
]

{ #category : 'visiting - programUnits' }
FASTFortranMainTransformationVisitor >> visitFASTFortranSubroutine: aFASTFortranSubroutine [
]
