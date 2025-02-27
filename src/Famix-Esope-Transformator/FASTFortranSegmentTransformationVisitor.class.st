Class {
	#name : 'FASTFortranSegmentTransformationVisitor',
	#superclass : 'FASTFortranBehavioralTransformationVisitor',
	#instVars : [
		'tmpStream'
	],
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'visiting' }
FASTFortranSegmentTransformationVisitor >> visitFASTEsopeSegment: aFASTEsopeSegmentNode [

	| derivedType2k |
	derivedType2k := FASTFortranDerivedTypeFactory new
		name: aFASTEsopeSegmentNode name ;
		model: self model2k ;
		fields: aFASTEsopeSegmentNode statements ;
		
		createModule.

	aFASTEsopeSegmentNode transformed2k: derivedType2k.

	^derivedType2k
]

{ #category : 'visiting' }
FASTFortranSegmentTransformationVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	^self model2k newDerivedTypeComponent
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
