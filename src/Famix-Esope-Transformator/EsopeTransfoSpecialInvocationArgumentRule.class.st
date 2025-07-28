Class {
	#name : 'EsopeTransfoSpecialInvocationArgumentRule',
	#superclass : 'EsopeTransfoInvocationArgumentRule',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'as yet unclassified' }
EsopeTransfoSpecialInvocationArgumentRule class >> invocationsOfInterest [

	^#()
]

{ #category : 'testing' }
EsopeTransfoSpecialInvocationArgumentRule class >> isAbstract [

	^self = EsopeTransfoSpecialInvocationArgumentRule
]

{ #category : 'instance creation' }
EsopeTransfoSpecialInvocationArgumentRule >> invocationOfInterest: fastInvoc [

	^self class invocationsOfInterest anySatisfy: [ :assoc |
		assoc sameAs: fastInvoc name ]
]
