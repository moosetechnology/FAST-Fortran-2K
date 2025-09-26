"
I represent an interface procedure declaration

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `interface` | `FASTFortran2kInterfaceProcedure` | `interfaceProcedures` | `FASTFortran2kInterface` | |
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `declarations` | `FASTFortran2kTWithDeclarations` | `fortranDeclarationOwner` | `FASTFortran2kTDeclaration` | The elements I declare|
| `parameters` | `FASTTWithParameters` | `parameterOwner` | `FASTTVariableEntity` | My parameters|


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
	#traits : 'FASTFortran2kTWithDeclarations + FASTTNamedEntity + FASTTWithParameters',
	#classTraits : 'FASTFortran2kTWithDeclarations classTrait + FASTTNamedEntity classTrait + FASTTWithParameters classTrait',
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
	<abstract>
	^ self
]

{ #category : 'testing' }
FASTFortran2kInterfaceProcedure class >> isAbstract [

	<generated>
	^ self == FASTFortran2kInterfaceProcedure
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
