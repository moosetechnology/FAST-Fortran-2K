Extension { #name : 'FASTFortran2kModel' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kModel >> newCharacterType [

	^(self allWithType: FASTFortran2kCharacterType)
		ifEmpty: [ self add: FASTFortran2kCharacterType new ]
		ifNotEmpty: [ :allIntegerType | allIntegerType anyOne ]
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kModel >> newComplexType [

	^(self allWithType: FASTFortran2kComplexType)
		ifEmpty: [ self add: FASTFortran2kComplexType new ]
		ifNotEmpty: [ :allIntegerType | allIntegerType anyOne ]
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kModel >> newIntegerType [

	^(self allWithType: FASTFortran2kIntegerType)
		ifEmpty: [ self add: FASTFortran2kIntegerType new ]
		ifNotEmpty: [ :allIntegerType | allIntegerType anyOne ]
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kModel >> newLogicalType [

	^(self allWithType: FASTFortran2kLogicalType)
		ifEmpty: [ self add: FASTFortran2kLogicalType new ]
		ifNotEmpty: [ :allIntegerType | allIntegerType anyOne ]
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kModel >> newRealType [

	^(self allWithType: FASTFortran2kRealType)
		ifEmpty: [ self add: FASTFortran2kRealType new ]
		ifNotEmpty: [ :allIntegerType | allIntegerType anyOne ]
]
