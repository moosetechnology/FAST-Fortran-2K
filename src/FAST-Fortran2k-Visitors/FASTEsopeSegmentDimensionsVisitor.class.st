Class {
	#name : 'FASTEsopeSegmentDimensionsVisitor',
	#superclass : 'FASTFortranTransformationVisitor',
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'as yet unclassified' }
FASTEsopeSegmentDimensionsVisitor >> visitDeclarationDimension: aFASTExpression [

	^ aFASTExpression upperBound accept: self
]

{ #category : 'visiting' }
FASTEsopeSegmentDimensionsVisitor >> visitFASTFortranArrayRange: aFASTFortranArrayRange [

	^ (aFASTFortranArrayRange lowerBound
		   ifNotNil: [ :lb | lb accept: self ]
		   ifNil: [ #(  ) ])
	  , (aFASTFortranArrayRange upperBound accept: self)
]

{ #category : 'visiting' }
FASTEsopeSegmentDimensionsVisitor >> visitFASTFortranBinaryExpression: aFASTFortranBinaryExpression [

	^ (aFASTFortranBinaryExpression leftOperand accept: self)
	  , (aFASTFortranBinaryExpression rightOperand accept: self)
]

{ #category : 'visiting' }
FASTEsopeSegmentDimensionsVisitor >> visitFASTFortranIntegerLiteral: aFASTFortranIntegerLitteral [

	^ #(  )
]

{ #category : 'visiting' }
FASTEsopeSegmentDimensionsVisitor >> visitFASTFortranScalarVariable: aFASTFortranScalarVariable [

	^ { aFASTFortranScalarVariable name }
]

{ #category : 'visiting - programUnits' }
FASTEsopeSegmentDimensionsVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	^ aFASTFortranVariableDeclarationStatement declarators flatCollect: [
		  :declarator |
		  declarator dimensions flatCollect: [ :declarationDimension |
			  declarationDimension accept: self ] ]
]
