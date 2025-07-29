"
Abstract class for all rules that try to guess the intent of a parameter that appear as argument of an invocation

It must define methods:
- `invocation: aFASTFortran77Invocation hasArgument: aFamixF77Parameter`: check whether the parameter appears as argument of the given invocation.
- `invocationOfInterest: aFASTFortran77Invocation`: check whether the invocation is of interest for the rule.
- `intent: aParameterIntentModifier fromInvocation: fastInvoc`: Assuming the previous ones or true, updates the intent of the parameter accordingly
"
Class {
	#name : 'Fortran2kInvocationArgumentRule',
	#superclass : 'Fortran2kIntentAbstractRule',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'testing' }
Fortran2kInvocationArgumentRule class >> isAbstract [

	^self = Fortran2kInvocationArgumentRule
]

{ #category : 'instance creation' }
Fortran2kInvocationArgumentRule >> fastInvocationsWithArgument: aFamixF77Parameter [

	| invocations |
	invocations := aFamixF77Parameter parentBehaviouralEntity
		ifNil: [ #() ]
		ifNotNil: [ :famixBehavioural | famixBehavioural outgoingInvocations ].

	^invocations
		collect: #fast
		thenSelect: [ :fastInvoc |
			fastInvoc arguments anySatisfy: [ :fastArgument |
				fastArgument famixParameter = aFamixF77Parameter ]
		]
]

{ #category : 'instance creation' }
Fortran2kInvocationArgumentRule >> intent: aParameterIntentModifier fromInvocation: fastInvoc [

	self subclassResponsibility 
]

{ #category : 'instance creation' }
Fortran2kInvocationArgumentRule >> on: aFamixF77Parameter [
	"note: returns #intent for compatibility with super-class"

	| intent |
	intent := super on: aFamixF77Parameter.

	(self fastInvocationsWithArgument: aFamixF77Parameter) 
		do: [ :fastInvoc | ^self intent: intent fromInvocation: fastInvoc ].

	^intent 
]
