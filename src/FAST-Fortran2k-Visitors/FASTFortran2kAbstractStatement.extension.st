Extension { #name : 'FASTFortran2kAbstractStatement' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kAbstractStatement >> accept: aVisitor [
	<generated>

	^ aVisitor visitFASTFortran2kAbstractStatement: self.

]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kAbstractStatement >> backTrace [

	^self attributeAt: #backTrace ifAbsent: [ nil ]
]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kAbstractStatement >> backTrace: aFamixEntity [

	^self attributeAt: #backTrace put: aFamixEntity
]
