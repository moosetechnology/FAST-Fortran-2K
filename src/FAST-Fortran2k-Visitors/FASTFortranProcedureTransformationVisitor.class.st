Class {
	#name : 'FASTFortranProcedureTransformationVisitor',
	#superclass : 'FASTFortranBehavioralTransformationVisitor',
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'visiting - programUnits' }
FASTFortranProcedureTransformationVisitor >> visitFASTEsopeSegment: aFASTEsopeSegmentNode [

	^aFASTEsopeSegmentNode accept: (self subVisitor: aFASTEsopeSegmentNode transformationVisitorClass)
]

{ #category : 'visiting - programUnits' }
FASTFortranProcedureTransformationVisitor >> visitFASTFortranFunction: aFASTFortranFunction [

	| subroutine |
	subroutine := FASTFortran2kFunction new
		name: aFASTFortranFunction name;
		mooseModel: model;
		yourself.
		
	stack push: subroutine.
	
	super visitFASTFortranFunction: aFASTFortranFunction.
	
	stack pop.
	^subroutine.
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
