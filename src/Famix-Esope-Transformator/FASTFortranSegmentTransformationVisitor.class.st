Class {
	#name : 'FASTFortranSegmentTransformationVisitor',
	#superclass : 'FASTFortranBehavioralTransformationVisitor',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'visiting - esope' }
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
