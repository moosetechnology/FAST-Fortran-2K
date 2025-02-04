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
FASTFortranMainTransformationVisitor >> visitFASTEsopeSegment: aFASTEsopeSegmentNode [

	"aFASTEsopeSegmentNode accept: (self subVisitor: aFASTEsopeSegmentNode transformationVisitorClass)"
	^nil
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
		parentProgramFile: programFile ;
		yourself.

	stack push: programMain.
	
	programMain statementBlock: (aProgramNode statementBlock accept: self).
	programMain statementBlock statements addFirst: self model newImplicitStatement.

	stack pop.

	^programFile
]

{ #category : 'visiting - programUnits' }
FASTFortranMainTransformationVisitor >> visitFASTFortranSubroutine: aFASTFortranSubroutine [

	^nil
]
