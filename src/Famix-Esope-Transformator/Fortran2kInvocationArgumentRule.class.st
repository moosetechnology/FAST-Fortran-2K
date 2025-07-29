Class {
	#name : 'Fortran2kInvocationArgumentRule',
	#superclass : 'Fortran2kAbstractInvocationArgumentRule',
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
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
Fortran2kInvocationArgumentRule >> fastInvocationsWithArgument: aFamixF77Parameter [

	^#()
]

{ #category : 'running' }
Fortran2kInvocationArgumentRule >> intentFor: aParameterIntentModifier fromInvocation: fastInvoc [
	"gets the famix procedure invoked and discover what is the intent of the argument corresponding to aParameterIntentModifier"

	(self famixProcedureFor: fastInvoc)
		ifNil: [ aParameterIntentModifier ]
		ifNotNil: [ :famixProcedure |
		]
]
