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
