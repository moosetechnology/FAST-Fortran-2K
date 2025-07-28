Class {
	#name : 'EsopeTransfoSpecialInvocationOutArgumentRule',
	#superclass : 'EsopeTransfoSpecialInvocationArgumentRule',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'as yet unclassified' }
EsopeTransfoSpecialInvocationOutArgumentRule class >> invocationsOfInterest [

	^#( inistr )
]

{ #category : 'instance creation' }
EsopeTransfoSpecialInvocationOutArgumentRule >> intent: aParameterIntentModifier fromInvocation: fastInvoc [

	aParameterIntentModifier isOut: true
]
