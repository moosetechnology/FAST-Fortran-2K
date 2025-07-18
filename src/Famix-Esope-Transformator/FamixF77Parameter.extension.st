Extension { #name : 'FamixF77Parameter' }

{ #category : '*Famix-Esope-Transformator' }
FamixF77Parameter >> isArgumentOfInvocation: aName [

	self parentBehaviouralEntity ifNil: [ ^false ].

	^(self parentBehaviouralEntity outgoingInvocations collect: #fast) 
		anySatisfy: [ :fastInvoc |
			(fastInvoc name asLowercase = aName asLowercase)
				and: [ fastInvoc arguments notEmpty 
				and: [ fastInvoc arguments first name sameAs: self name asLowercase ] 
			]
		]
]
