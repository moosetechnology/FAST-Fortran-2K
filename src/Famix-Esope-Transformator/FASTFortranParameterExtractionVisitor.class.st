Class {
	#name : 'FASTFortranParameterExtractionVisitor',
	#superclass : 'FASTFortranVisitor',
	#category : 'Famix-Esope-Transformator-Segment',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Segment'
}

{ #category : 'visiting' }
FASTFortranParameterExtractionVisitor >> visitFASTFortranArrayRange: aFASTFortranArrayRange [

	^ ((aFASTFortranArrayRange lowerBound
		   ifNotNil: [ :lb | lb accept: self ]
		   ifNil: [ #() ]
		)
	  , (aFASTFortranArrayRange upperBound accept: self)) asSet
]

{ #category : 'visiting' }
FASTFortranParameterExtractionVisitor >> visitFASTFortranBinaryExpression: aFASTFortranBinaryExpression [

	^ (aFASTFortranBinaryExpression leftOperand accept: self)
	, ( aFASTFortranBinaryExpression rightOperand accept: self)
]

{ #category : 'visiting' }
FASTFortranParameterExtractionVisitor >> visitFASTFortranFunctionCall: aFASTFortranFunctionCall [

	^#()
]

{ #category : 'visiting - expressions' }
FASTFortranParameterExtractionVisitor >> visitFASTFortranIntegerLiteral: aFASTFortranIntegerLiteral [

	^#()
]

{ #category : 'visiting' }
FASTFortranParameterExtractionVisitor >> visitFASTFortranScalarVariable: aFASTFortranScalarVariable [

	^{ aFASTFortranScalarVariable name }
]
