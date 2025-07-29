Class {
	#name : 'Fortran2kAccessRule',
	#superclass : 'Fortran2kIntentAbstractRule',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'accessing' }
Fortran2kAccessRule >> firstAccess: aFamixF77Variable [
	"finds first access to aFamixF77Variable based on sourceAnchors
	 If a sourceAnchor is missing, returns nil"

	aFamixF77Variable incomingAccesses 
		ifEmpty: [ ^nil ].

	(aFamixF77Variable incomingAccesses anySatisfy: [ :access | access sourceAnchor isNil ])
		ifTrue: [ ^nil ].

	^aFamixF77Variable incomingAccesses
		inject: (aFamixF77Variable incomingAccesses first)
		into: [ :min :each | (min sourceAnchor startPos < each sourceAnchor startPos)
			ifTrue: [ min ] ifFalse: [ each ]
		].

]

{ #category : 'instance creation' }
Fortran2kAccessRule >> on: aFamixF77Parameter [

	| intent |
	intent := super on: aFamixF77Parameter.

	(self firstAccess: aFamixF77Parameter)
		ifNotNil: [ :firstAccess |
			firstAccess isWrite
				ifTrue: [ ^intent isIn: false ; isOut: true ; yourself ]
		].

	intent isIn: (aFamixF77Parameter incomingAccesses anySatisfy: [ :acc | acc isWrite not]).
	intent isOut: (aFamixF77Parameter incomingAccesses anySatisfy: #isWrite).

	^intent
]
