Class {
	#name : 'Fortran2kSpecialInvocationOutArgumentRule',
	#superclass : 'Fortran2kSpecialInvocationArgumentRule',
	#category : 'Famix-Esope-Transformator-ParameterIntent',
	#package : 'Famix-Esope-Transformator',
	#tag : 'ParameterIntent'
}

{ #category : 'as yet unclassified' }
Fortran2kSpecialInvocationOutArgumentRule class >> invocationsOfInterest [

	^#( inistr )
]

{ #category : 'instance creation' }
Fortran2kSpecialInvocationOutArgumentRule >> intentFor: aFamixF77Parameter fromInvocation: fastInvoc [

	(self getIntent: aFamixF77Parameter)
		isOut: true.
]
