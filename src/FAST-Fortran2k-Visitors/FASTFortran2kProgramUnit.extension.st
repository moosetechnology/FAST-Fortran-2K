Extension { #name : 'FASTFortran2kProgramUnit' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kProgramUnit >> accept: aVisitor [
	<generated>

	^ aVisitor visitFASTFortran2kProgramUnit: self.

]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kProgramUnit >> backTrace [

	^self attributeAt: #backTrace ifAbsent: [ nil ]
]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kProgramUnit >> backTrace: anObject [

	^self attributeAt: #backTrace put: anObject
]
