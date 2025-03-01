Extension { #name : 'FASTFortran2kProcedureParameter' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kProcedureParameter >> accept: aVisitor [
	^ aVisitor visitFASTFortranProcedureParameter: self
]
