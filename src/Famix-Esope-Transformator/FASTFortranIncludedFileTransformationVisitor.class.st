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

{ #category : 'visiting - esope' }
FASTFortranIncludedFileTransformationVisitor >> visitFASTFortranIncludedFile: aFASTFortranIncludedFile [

	aFASTFortranIncludedFile declarations 
		collect: [ :declaration | declaration accept: self ]
		thenDo: [ :f2kModule | 
			model2k newProgramFile
				filename: (self fortran2kfilename: aFASTFortranIncludedFile);
				addProgramUnit: f2kModule
		].

	self flag: '#TODO: handle the rest of the statements'.
	aFASTFortranIncludedFile statementBlock accept: self
]
