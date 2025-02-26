Class {
	#name : 'FASTFortranSegmentTransformationVisitor',
	#superclass : 'FASTFortranBehavioralTransformationVisitor',
	#instVars : [
		'tmpStream'
	],
	#category : 'Famix-Esope-Transformator',
	#package : 'Famix-Esope-Transformator'
}

{ #category : 'visiting' }
FASTFortranSegmentTransformationVisitor >> visitFASTEsopeSegment: aFASTEsopeSegmentNode [

	^FASTFortranDerivedTypeFactory new
		name: aFASTEsopeSegmentNode name ;
		fields: aFASTEsopeSegmentNode statements ;
		model: self model ;

		createModule.

	"module := self model newModule name: segmentName , '_mod'.
	module addProcedure: (self makeProcedureSegini2: aFASTEsopeSegmentNode).
	module procedures addAll:
		(self makeProceduresDimensions: aFASTEsopeSegmentNode).

	module statementBlock:
		(FASTFortran2kStatementBlock new statements: {
				 self makeSegmentModuleProlog.
				 (self makeTypeDefinition: aFASTEsopeSegmentNode).
				 (self makeSegmentTypeName: segmentName).
				 (self makeBoxedTypeDefinition: segmentName).
				 (self makeInterfaces: segmentName).
				 (self makeContainsStatement: segmentName).
				 (self makeProcedureIgnore: segmentName).
				 (self makeProcedureAssignPointerToPointer: segmentName).
				 (self makeProcedureSegmentType: segmentName).
				 (self makeProcedureSegini: aFASTEsopeSegmentNode).
				 (self makeProcedureSegcop: aFASTEsopeSegmentNode).
				 (self makeProcedureSegmov: aFASTEsopeSegmentNode).
				 (self makeProcedureSegadj: aFASTEsopeSegmentNode).
				 (self makeProcedureSegsup: aFASTEsopeSegmentNode).
				 (self makeProcedureSegprt: aFASTEsopeSegmentNode).
				 (self makeProcedureSegstore: aFASTEsopeSegmentNode).
				 (self makeProcedureSegload: aFASTEsopeSegmentNode).
				 (self makeProcedureSegpar: aFASTEsopeSegmentNode).
				 (self makeProcedureSeglik: aFASTEsopeSegmentNode).
				 (self makeProcedureSegloc: segmentName).
				 (self makeProcedureBoxed: segmentName) }).
	^ module"
]

{ #category : 'visiting' }
FASTFortranSegmentTransformationVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	^self model newDerivedTypeComponent
		type: (aFASTFortranVariableDeclarationStatement declaredType accept: self);
		declarators: (self visitFASTFortranList: aFASTFortranVariableDeclarationStatement declarators) ;
		yourself
]

{ #category : 'visiting' }
FASTFortranSegmentTransformationVisitor >> visitSegmentAttributes: attributes [

	| generatedCode |
	self ensureEmptyStream.
	attributes do: [ :each |
		| parameters |

		self flag: #FIXME. "handle parameters in each declaractors dimensions"
		parameters := each declarators collect: #dimensions.

		parameters ifNotEmpty: [
			parameters do: [  :parameter | 
 		tmpStream
			<<
			'integer, private :: ',  parameter name, ' = 0'
			].
			]
		].
	generatedCode := tmpStream contents.
	self ensureEmptyStream.
	^ generatedCode
]
