Class {
	#name : 'Fortran2kSpecialInvocationInoutArgumentRule',
	#superclass : 'Fortran2kSpecialInvocationArgumentRule',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'as yet unclassified' }
Fortran2kSpecialInvocationInoutArgumentRule class >> invocationsOfInterest [

	^#( ajpnt )
]

{ #category : 'instance creation' }
Fortran2kSpecialInvocationInoutArgumentRule >> intentFor: aFamixF77Parameter fromInvocation: fastInvoc [

	(self getIntent: aFamixF77Parameter)
		isIn: true ;
		isOut: true.
]
