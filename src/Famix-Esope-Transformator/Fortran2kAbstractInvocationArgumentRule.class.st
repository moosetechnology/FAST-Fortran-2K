"
Abstract class for all rules that try to guess the intent of a parameter that appear as argument of an invocation

It must define methods:
- `invocation: aFASTFortran77Invocation hasArgument: aFamixF77Parameter`: check whether the parameter appears as argument of the given invocation.
- `invocationOfInterest: aFASTFortran77Invocation`: check whether the invocation is of interest for the rule.
- `intent: aParameterIntentModifier fromInvocation: fastInvoc`: Assuming the previous ones or true, updates the intent of the parameter accordingly
"
Class {
	#name : 'Fortran2kAbstractInvocationArgumentRule',
	#superclass : 'Fortran2kIntentAbstractRule',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'testing' }
Fortran2kAbstractInvocationArgumentRule class >> isAbstract [

	^self = Fortran2kAbstractInvocationArgumentRule
]

{ #category : 'running' }
Fortran2kAbstractInvocationArgumentRule >> check: aFamixF77Parameter [

	^(self fastInvocationsWithArgument: aFamixF77Parameter) 
		do: [ :fastInvoc | ^self intentFor: aFamixF77Parameter fromInvocation: fastInvoc ].

]

{ #category : 'running' }
Fortran2kAbstractInvocationArgumentRule >> fastInvocationsWithArgument: aFamixF77Parameter [

	| invocations |
	invocations := aFamixF77Parameter parentBehaviouralEntity
		ifNil: [ #() ]
		ifNotNil: [ :famixBehavioural | famixBehavioural outgoingInvocations ].

	^invocations
		collect: #fast
		thenSelect: [ :fastInvoc |
			fastInvoc arguments anySatisfy: [ :fastArgument |
				fastArgument isVariableEntity and: [fastArgument famixParameter = aFamixF77Parameter ]
			]
		]
]

{ #category : 'running' }
Fortran2kAbstractInvocationArgumentRule >> intentFor: aParameterIntentModifier fromInvocation: fastInvoc [

	self subclassResponsibility 
]
