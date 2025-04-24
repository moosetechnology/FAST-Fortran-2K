Extension { #name : 'FASTFortran2kDoubleComplexType' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kDoubleComplexType >> initialValue [

	^mooseModel newDoubleComplexLiteral primitiveValue: 'cmplx(0D, 0D)'
]
