Extension { #name : 'FASTFortran2kInternalProcedure' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kInternalProcedure >> accept: aVisitor [
	<generated>

	^ aVisitor visitFASTFortran2kInternalProcedure: self.

]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kInternalProcedure >> backTrace [

	^self attributeAt: #backTrace ifAbsent: [ nil ]
]
