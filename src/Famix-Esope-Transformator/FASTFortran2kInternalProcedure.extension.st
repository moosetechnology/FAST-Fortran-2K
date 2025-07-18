Extension { #name : 'FASTFortran2kInternalProcedure' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kInternalProcedure >> setOwner: aProgramUnit [

	aProgramUnit addInternalProcedure: self
]
