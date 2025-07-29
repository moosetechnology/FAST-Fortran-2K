Class {
	#name : 'Fortran2kInvocationArgumentRule',
	#superclass : 'Fortran2kAbstractInvocationArgumentRule',
	#category : 'Famix-Esope-Transformator-ParameterIntent',
	#package : 'Famix-Esope-Transformator',
	#tag : 'ParameterIntent'
}

{ #category : 'running' }
Fortran2kInvocationArgumentRule >> famixProcedureFor: fastInvoc [
	"there should be only one FamixF77Procedure in the invocation"

	^fastInvoc famix candidates
		ifEmpty: [ nil ]
		ifNotEmpty: [ :candidates |
			candidates anyOne isStub
				ifTrue: [ nil ]
				ifFalse: [ candidates anyOne ]
		]
]

{ #category : 'running' }
Fortran2kInvocationArgumentRule >> getSecondaryIntent: secondaryFamixParameter in: secondaryFamixProcedure [
	"gets intent of secondaryFamixParameter.
	 If it is already set we get it, otherwise, need to get FAST of secondaryFamixProcedure"

	(secondaryFamixParameter propertyNamed: #intent)
		ifNotNil: [ :secondaryIntent | ^secondaryIntent ].

	secondaryFamixProcedure bindFASTModel.

	Fortran2kIntentAbstractRule checkAllRulesFor: secondaryFamixParameter
]

{ #category : 'running' }
Fortran2kInvocationArgumentRule >> intentFor: aFamixF77Parameter fromInvocation: fastInvoc [
	"gets the famix procedure invoked and discover what is the intent of the argument corresponding to aParameterIntentModifier"

	(self famixProcedureFor: fastInvoc)
		ifNotNil: [ :famixProcedure |
			self
				setIntent: aFamixF77Parameter
				fromParameter: (self argumentIndex: aFamixF77Parameter in: fastInvoc)
				inProcedure: famixProcedure
		]
]

{ #category : 'running' }
Fortran2kInvocationArgumentRule >> setIntent: primaryFamixParameter fromParameter: anInteger inProcedure: secondaryFamixProcedure [
	"The secondaryFamixProcedure might sometimes have no parameters (when it is intrinsic for example)
	 so we need to check for that"

	| secondaryFamixParameter primaryIntent secondaryIntent |

	(secondaryFamixProcedure parameters size < anInteger) ifTrue: [ ^self ].

	secondaryFamixParameter := secondaryFamixProcedure parameters at: anInteger.

	secondaryIntent := self getSecondaryIntent: secondaryFamixParameter in: secondaryFamixProcedure.

	primaryIntent := self getIntent: primaryFamixParameter.
	primaryIntent isIn: (primaryIntent isIn or: [secondaryIntent isIn]).
	primaryIntent isOut: (primaryIntent isOut or: [secondaryIntent isOut]).
]
