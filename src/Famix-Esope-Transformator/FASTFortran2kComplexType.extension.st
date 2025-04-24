Extension { #name : 'FASTFortran2kComplexType' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kComplexType >> initialValue [

	^mooseModel newComplexLiteral primitiveValue: 'cmplx(0.0, 0.0)'
]
