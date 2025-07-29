Class {
	#name : 'Fortran2kSpecialInvocationOutArgumentRule',
	#superclass : 'Fortran2kSpecialInvocationArgumentRule',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'as yet unclassified' }
Fortran2kSpecialInvocationOutArgumentRule class >> invocationsOfInterest [

	^#( inistr )
]

{ #category : 'instance creation' }
Fortran2kSpecialInvocationOutArgumentRule >> intent: aParameterIntentModifier fromInvocation: fastInvoc [

	aParameterIntentModifier isOut: true
]
