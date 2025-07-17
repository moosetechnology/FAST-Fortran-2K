Extension { #name : 'FamixF77TypeIntrinsic' }

{ #category : '*Famix-Esope-Transformator' }
FamixF77TypeIntrinsic >> generateF2kInModel: anF2kModel [

	(self name = #real)      ifTrue: [ ^anF2kModel newRealType ].
	(self name = #integer)   ifTrue: [ ^anF2kModel newIntegerType ].
	(self name = #character) ifTrue: [ ^anF2kModel newCharacterType ].
	(self name = #logical)   ifTrue: [ ^anF2kModel newLogicalType ].

	Error signal: ('Unknown FamixFortran77 type: ' , self name)
]
