Class {
	#name : 'Fortran2kSpecialInvocationArgumentRule',
	#superclass : 'Fortran2kInvocationArgumentRule',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'as yet unclassified' }
Fortran2kSpecialInvocationArgumentRule class >> invocationsOfInterest [

	^#()
]

{ #category : 'testing' }
Fortran2kSpecialInvocationArgumentRule class >> isAbstract [

	^self = Fortran2kSpecialInvocationArgumentRule
]

{ #category : 'instance creation' }
Fortran2kSpecialInvocationArgumentRule >> invocationOfInterest: fastInvoc [

	^self class invocationsOfInterest anySatisfy: [ :assoc |
		assoc sameAs: fastInvoc name ]
]
