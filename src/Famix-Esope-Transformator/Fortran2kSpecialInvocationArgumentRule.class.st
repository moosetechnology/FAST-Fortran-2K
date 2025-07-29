Class {
	#name : 'Fortran2kSpecialInvocationArgumentRule',
	#superclass : 'Fortran2kAbstractInvocationArgumentRule',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'as yet unclassified' }
Fortran2kSpecialInvocationArgumentRule class >> invocationsOfInterest [

	self subclassResponsibility 
]

{ #category : 'instance creation' }
Fortran2kSpecialInvocationArgumentRule >> fastInvocationsWithArgument: aFamixF77Parameter [

	^(super fastInvocationsWithArgument: aFamixF77Parameter)
		select: [ :fastInvoc |
			self class invocationsOfInterest anySatisfy: [ :specialName |
				specialName sameAs: fastInvoc name ]
		]
]
