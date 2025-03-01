"
I represent a Parameter in a FortranProcedure. I can have an intent (in, ou, inOut)

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `parameterOwner` | `FASTTVariableEntity` | `parameters` | `FASTTWithParameters` | parameterOwner|
| `parentAssignmentExpression` | `FASTTVariableEntity` | `variable` | `FASTTAssignment` | Optional assignment to the variable|
| `parentImpliedExpression` | `FASTTVariableEntity` | `variables` | `FASTFortran2kImpliedDoExpression` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `intent` | `String` | nil | intent of the parameter, either #in, #out or #InOut|
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kProcedureParameter',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTVariableEntity',
	#classTraits : 'FASTTVariableEntity classTrait',
	#instVars : [
		'#intent => FMProperty'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kProcedureParameter class >> annotation [

	<FMClass: #ProcedureParameter super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kProcedureParameter >> intent [

	<FMProperty: #intent type: #String>
	<generated>
	<FMComment: 'intent of the parameter, either #in, #out or #InOut'>
	^ intent
]

{ #category : 'accessing' }
FASTFortran2kProcedureParameter >> intent: anObject [
	<generated>
	intent := anObject
]
