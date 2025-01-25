"
I represent an interface procedure declaration

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `interface` | `FASTFortran2kInterfaceProcedure` | `interfaceProcedures` | `FASTFortran2kInterface` | |
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kInterfaceProcedure',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTNamedEntity',
	#classTraits : 'FASTTNamedEntity classTrait',
	#instVars : [
		'#interface => FMOne type: #FASTFortran2kInterface opposite: #interfaceProcedures'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kInterfaceProcedure class >> annotation [

	<FMClass: #InterfaceProcedure super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kInterfaceProcedure >> interface [
	"Relation named: #interface type: #FASTFortran2kInterface opposite: #interfaceProcedures"

	<generated>
	<container>
	^ interface
]

{ #category : 'accessing' }
FASTFortran2kInterfaceProcedure >> interface: anObject [

	<generated>
	interface := anObject
]

{ #category : 'navigation' }
FASTFortran2kInterfaceProcedure >> interfaceGroup [
	<generated>
	<navigation: 'Interface'>
	^ MooseSpecializedGroup with: self interface
]
