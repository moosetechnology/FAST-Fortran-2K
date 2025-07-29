"
Abstract class for all rules that try to guess the intent of a parameter

It has one method `#on:` that runs the rule on a FamixF77Parameter and sets its intent
(`famixF77Parameter propertyNamed: #intent`)
"
Class {
	#name : 'Fortran2kIntentAbstractRule',
	#superclass : 'Object',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'testing' }
Fortran2kIntentAbstractRule class >> checkAllRulesOn: aFamixF77Parameter [

	self withAllSubclassesDo: [ :rule |
		rule isAbstract ifFalse: [ rule on: aFamixF77Parameter ]
	]
]

{ #category : 'testing' }
Fortran2kIntentAbstractRule class >> isAbstract [

	^self = Fortran2kIntentAbstractRule
]

{ #category : 'testing' }
Fortran2kIntentAbstractRule class >> on: aFamixF77Parameter [

	^self new
		on: aFamixF77Parameter 
]

{ #category : 'instance creation' }
Fortran2kIntentAbstractRule >> on: aFamixF77Parameter [

	^aFamixF77Parameter propertyNamed: #intent ifAbsentPut: [ FASTFortran2kParameterIntent new ]
]
