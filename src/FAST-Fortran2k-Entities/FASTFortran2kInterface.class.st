"
I represent an interface

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `interfaceProcedures` | `FASTFortran2kInterface` | `interface` | `FASTFortran2kInterfaceProcedure` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `isAbstractInterface` | `Boolean` | nil | Im abstract ?|
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kInterface',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTTNamedEntity',
	#classTraits : 'FASTTNamedEntity classTrait',
	#instVars : [
		'#isAbstractInterface => FMProperty',
		'#interfaceProcedures => FMMany type: #FASTFortran2kInterfaceProcedure opposite: #interface'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kInterface class >> annotation [

	<FMClass: #Interface super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kInterface >> addInterfaceProcedure: anObject [
	<generated>
	^ self interfaceProcedures add: anObject
]

{ #category : 'accessing' }
FASTFortran2kInterface >> interfaceProcedures [
	"Relation named: #interfaceProcedures type: #FASTFortran2kInterfaceProcedure opposite: #interface"

	<generated>
	<derived>
	^ interfaceProcedures
]

{ #category : 'accessing' }
FASTFortran2kInterface >> interfaceProcedures: anObject [

	<generated>
	interfaceProcedures value: anObject
]

{ #category : 'navigation' }
FASTFortran2kInterface >> interfaceProceduresGroup [
	<generated>
	<navigation: 'InterfaceProcedures'>
	^ MooseSpecializedGroup withAll: self interfaceProcedures asSet
]

{ #category : 'accessing' }
FASTFortran2kInterface >> isAbstractInterface [

	<FMProperty: #isAbstractInterface type: #Boolean>
	<generated>
	<FMComment: 'Im abstract ?'>
	^ isAbstractInterface
]

{ #category : 'accessing' }
FASTFortran2kInterface >> isAbstractInterface: anObject [
	<generated>
	isAbstractInterface := anObject
]
