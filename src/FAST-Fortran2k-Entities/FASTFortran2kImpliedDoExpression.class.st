"
I represent a Fortran ""implied do"" expression

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `withVariableGroups` | `FASTFortran2kTVariableGroup` | `variableGroups` | `FASTFortran2kTWithVariableGroups` | |

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `loopControl` | `FASTFortran2kTWithLoopControl` | `parentLoop` | `FASTFortran2kLoopControlExpression` | loop control|
| `variables` | `FASTFortran2kTVariableGroup` | `parentVariableGroup` | `FASTFortran2kVariable` | |
| `variables` | `FASTFortran2kImpliedDoExpression` | `parentImpliedExpression` | `FASTTVariableEntity` | |



"
Class {
	#name : 'FASTFortran2kImpliedDoExpression',
	#superclass : 'FASTFortran2kAbstractExpression',
	#traits : 'FASTFortran2kTVariableGroup + FASTFortran2kTWithLoopControl',
	#classTraits : 'FASTFortran2kTVariableGroup classTrait + FASTFortran2kTWithLoopControl classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kImpliedDoExpression class >> annotation [

	<FMClass: #ImpliedDoExpression super: #FASTFortran2kAbstractExpression>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kImpliedDoExpression >> addVariable: anObject [
	<generated>
	^ self variables add: anObject
]

{ #category : 'accessing' }
FASTFortran2kImpliedDoExpression >> variables [
	"Relation named: #variables type: #FASTTVariableEntity opposite: #parentImpliedExpression"

	<generated>
	<derived>
	<FMProperty: #variables type: #FASTTVariableEntity opposite: #parentImpliedExpression>
	^ self attributeAt: #variables ifAbsentPut: [ FMMultivalueLink on: self opposite: #parentImpliedExpression: ]
]

{ #category : 'accessing' }
FASTFortran2kImpliedDoExpression >> variables: anObject [

	<generated>
	self variables value: anObject
]

{ #category : 'navigation' }
FASTFortran2kImpliedDoExpression >> variablesGroup [
	<generated>
	<navigation: 'Variables'>
	^ MooseSpecializedGroup withAll: self variables asSet
]
