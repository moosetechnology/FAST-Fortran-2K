Class {
	#name : 'FASTFortranParameterExtractionVisitor',
	#superclass : 'FASTFortranVisitor',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'visiting' }
FASTFortranParameterExtractionVisitor >> visitFASTFortranArrayRange: aFASTFortranArrayRange [

	^ ((aFASTFortranArrayRange lowerBound
		   ifNotNil: [ :lb | lb accept: self ]
		   ifNil: [ #() ]
		)
	  , (aFASTFortranArrayRange upperBound accept: self)) asSet
]

{ #category : 'visiting - expressions' }
FASTFortranParameterExtractionVisitor >> visitFASTFortranBinaryExpression: aFASTFortranBinaryExpression [

	^ (aFASTFortranBinaryExpression leftOperand accept: self)
	, ( aFASTFortranBinaryExpression rightOperand accept: self)
]

{ #category : 'visiting - expressions' }
FASTFortranParameterExtractionVisitor >> visitFASTFortranFunctionCall: aFASTFortranFunctionCall [

	^#()
]

{ #category : 'visiting - expressions' }
FASTFortranParameterExtractionVisitor >> visitFASTFortranIntegerLiteral: aFASTFortranIntegerLiteral [

	^#()
]

{ #category : 'visiting - expressions' }
FASTFortranParameterExtractionVisitor >> visitFASTFortranScalarVariable: aFASTFortranScalarVariable [

	^{ aFASTFortranScalarVariable name }
]
