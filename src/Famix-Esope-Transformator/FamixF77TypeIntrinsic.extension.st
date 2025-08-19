Extension { #name : 'FamixF77TypeIntrinsic' }

{ #category : '*Famix-Esope-Transformator' }
FamixF77TypeIntrinsic >> generateF2kInModel: anF2kModel [

	^self generateInModel: anF2kModel
]

{ #category : '*Famix-Esope-Transformator' }
FamixF77TypeIntrinsic >> generateFastF77InModel: aFastF77Model [

	^self generateInModel: aFastF77Model
]

{ #category : '*Famix-Esope-Transformator' }
FamixF77TypeIntrinsic >> generateInModel: anFortranModel [

	(self name sameAs: #real)      ifTrue: [ ^anFortranModel newRealType ].
	(self name sameAs: #integer)   ifTrue: [ ^anFortranModel newIntegerType ].
	(self name sameAs: #character) ifTrue: [ ^anFortranModel newCharacterType ].
	(self name sameAs: #logical)   ifTrue: [ ^anFortranModel newLogicalType ].
	(self name sameAs: #complex)   ifTrue: [ ^anFortranModel newComplexType ].
	(self name sameAs: #doublePrecision)   ifTrue: [ ^anFortranModel newDoublePrecisionType ].

	Error signal: ('Unknown FamixFortran77 type: ' , self name)
]
