Class {
	#name : 'FASTFortranArrayRangeVisitor',
	#superclass : 'FASTFortranTransformationVisitor',
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'visiting' }
FASTFortranArrayRangeVisitor >> visitFASTFortranArrayRange: aFASTFortranArrayRange [

	^ aFASTFortranArrayRange upperBound accept: self
]

{ #category : 'visiting' }
FASTFortranArrayRangeVisitor >> visitFASTFortranBinaryExpression: aFASTFortranBinaryExpression [

	^ (aFASTFortranBinaryExpression leftOperand accept: self)
	  , aFASTFortranBinaryExpression operator
	  , (aFASTFortranBinaryExpression rightOperand accept: self)
]

{ #category : 'visiting' }
FASTFortranArrayRangeVisitor >> visitFASTFortranIntegerLiteral: aFASTFortranIntegerLiteral [

	^ aFASTFortranIntegerLiteral primitiveValue
]

{ #category : 'visiting' }
FASTFortranArrayRangeVisitor >> visitFASTFortranScalarVariable: aFASTFortranScalarVariable [

	^ aFASTFortranScalarVariable name
]
