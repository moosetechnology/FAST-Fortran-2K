Class {
	#name : 'FASTFortranArrayRangeVisitor',
	#superclass : 'FASTFortranTransformationVisitor',
	#category : 'Famix-Esope-Transformator',
	#package : 'Famix-Esope-Transformator'
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
