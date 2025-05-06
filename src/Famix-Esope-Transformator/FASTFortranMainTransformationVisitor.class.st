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
FASTFortranMainTransformationVisitor >> makeProcedureOoossgSegmentRegister [
| statementBlock |

	statementBlock := model2k newStatementBlock.
	
	statementBlock	addStatement: 
		(model2k newSourceCodeString content: 'write (*, *) ''prolog: ...''').
	statementBlock	addStatement: (model2k newEmptyStatement).

	(model2k allWithType: FASTFortran2kDerivedTypeDefinition)
		do: [ :aSegment |
			statementBlock	addStatement: (model2k newFormattedCodeString 
				content: 'call register_seg_loader({1}_type_name, {1}_load)';
				values: { aSegment name })
		].
	statementBlock	addStatement: (model2k newEmptyStatement).

	statementBlock addStatement: 
		(model2k newSourceCodeString content: 'write (*, *) ''prolog: done''').

	^model2k newInternalSubroutine
		name: 'ooossg';
		parameters: #();
		statementBlock: statementBlock;
		yourself
]

{ #category : 'visiting - programUnits' }
FASTFortranMainTransformationVisitor >> visitFASTFortranFunction: aFASTFortranFunction [

	^nil
]

{ #category : 'visiting - programUnits' }
FASTFortranMainTransformationVisitor >> visitFASTFortranProgramMain: aMainProgramNode [

	| programMain2k programFile2k |
	
	programFile2k := self model2k newProgramFile
		filename: (self fortran2kFilename: aMainProgramNode) ;
		yourself.
	aMainProgramNode programFile transformed2k: programFile2k.

	programMain2k := self model2k newProgramMain 
		name: aMainProgramNode name;
		programFile: programFile2k ;
		backTrace: aMainProgramNode programFile filename ;
		yourself.
	aMainProgramNode transformed2k: programMain2k.

	stack push: programMain2k.
	
	programMain2k statementBlock: (aMainProgramNode statementBlock accept: self).
	programMain2k statementBlock statements addFirst: self model2k newImplicitStatement.

	self handleProgramUnitSegmentDeclaration: aMainProgramNode declarations.

	programMain2k addInternalProcedure: self makeProcedureOoossgSegmentRegister.

	stack pop.

	^programFile2k
]

{ #category : 'visiting - programUnits' }
FASTFortranMainTransformationVisitor >> visitFASTFortranSubroutine: aFASTFortranSubroutine [

	^nil
]
