"
Guess the intent of a parameter from its accesses
- If the first access is in writing -> intent(out)
- If there is a read access -> intent(in)
- If there is a write access -> intent(out) or intent(inOut)
"
Class {
	#name : 'Fortran2kAccessRule',
	#superclass : 'Fortran2kIntentAbstractRule',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'running' }
Fortran2kAccessRule >> check: aFamixF77Parameter [

	| intent previousValue |

	intent := self getIntent: aFamixF77Parameter.

	(self firstAccess: aFamixF77Parameter)
		ifNotNil: [ :firstAccess |
			firstAccess isWrite
				ifTrue: [
					intent isIn: false ; isOut: true.
					^self
				]
		].

	previousValue := aFamixF77Parameter incomingAccesses anySatisfy: [ :acc | acc isWrite not].
	intent isIn: (intent isIn or: [ previousValue ]).
	previousValue := aFamixF77Parameter incomingAccesses anySatisfy: #isWrite.
	intent isOut: (intent isOut or: [ previousValue ]).

]

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
