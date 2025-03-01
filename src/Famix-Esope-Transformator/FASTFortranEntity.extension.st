Extension { #name : 'FASTFortranEntity' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortranEntity >> transformed2k [

	^self attributeAt: #transformed2k ifAbsent: [ nil ]

]

{ #category : '*Famix-Esope-Transformator' }
FASTFortranEntity >> transformed2k: aFASTFortran2kEntity [

	self attributeAt: #transformed2k put: aFASTFortran2kEntity

]
