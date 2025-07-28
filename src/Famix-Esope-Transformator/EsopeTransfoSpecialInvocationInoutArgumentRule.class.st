Class {
	#name : 'EsopeTransfoSpecialInvocationInoutArgumentRule',
	#superclass : 'EsopeTransfoSpecialInvocationArgumentRule',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'as yet unclassified' }
EsopeTransfoSpecialInvocationInoutArgumentRule class >> invocationsOfInterest [

	^#( ajpnt )
]

{ #category : 'instance creation' }
EsopeTransfoSpecialInvocationInoutArgumentRule >> intent: aParameterIntentModifier fromInvocation: fastInvoc [

	aParameterIntentModifier isIn: true.
	aParameterIntentModifier isOut: true.
]
