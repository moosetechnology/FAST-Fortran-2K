Class {
	#name : 'FASTFortranIncludedFileTransformationVisitor',
	#superclass : 'FASTFortranBehavioralTransformationVisitor',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'visiting - esope' }
FASTFortranIncludedFileTransformationVisitor >> fortran2kfilename: aFASTFortranIncludedFile [

	^(aFASTFortranIncludedFile famix programFile filename 
		copyUpToSubString: '.') , '_mod.f90'
]

{ #category : 'visiting - esope' }
FASTFortranIncludedFileTransformationVisitor >> visitFASTEsopeSegment: aFASTEsopeSegmentNode [

	^aFASTEsopeSegmentNode accept: (FASTFortranSegmentTransformationVisitor new
		model2k: self model2k
	)
]

{ #category : 'visiting - statements' }
FASTFortranIncludedFileTransformationVisitor >> visitFASTFortranCommonStatement: aFASTFortranCommonStatement [

	self flag: #TODO.
	^FASTFortran2kNullEntity new

]

{ #category : 'visiting - statements' }
FASTFortranIncludedFileTransformationVisitor >> visitFASTFortranDataStatement: aFASTFortranDataStatement [

	self flag: #TODO.
	^FASTFortran2kNullEntity new

]

{ #category : 'visiting - programUnits' }
FASTFortranIncludedFileTransformationVisitor >> visitFASTFortranIncludedFile: aFASTFortranIncludedFile [

	aFASTFortranIncludedFile declarations 
		collect: [ :declaration | declaration accept: self ]
		thenDo: [ :f2kModule | 
			f2kModule ifNotNil: [
				model2k newProgramFile
					filename: (self fortran2kfilename: aFASTFortranIncludedFile);
					addProgramUnit: f2kModule
			]
		].

	^aFASTFortranIncludedFile statementBlock accept: self
]

{ #category : 'visiting - statements' }
FASTFortranIncludedFileTransformationVisitor >> visitFASTFortranParameterStatement: aFASTFortranParameterStatement [

	self flag: #TODO.
	^FASTFortran2kNullEntity new

]

{ #category : 'visiting - statements' }
FASTFortranIncludedFileTransformationVisitor >> visitFASTFortranStatementBlock: aFASTFortranStatementBlock [
	"returning the list of statement (which are not segment declaration to the caller)
	 these statements will be injected in place of the #include of thie current file
	 We set their start/end-pos to 0 because it will not be meaningfull in the context of the #include"

	^aFASTFortranStatementBlock statements
		collect: [ :statement |
			(statement accept: self)
				startPos: 0 ;
				endPos: 0 ;
				yourself
		].

]
