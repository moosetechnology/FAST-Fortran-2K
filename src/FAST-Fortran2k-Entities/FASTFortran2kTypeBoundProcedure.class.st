"
Im a type-bound-procedure

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `derivedTypeDefinition` | `FASTFortran2kTypeBoundProcedure` | `typeBoundProcedures` | `FASTFortran2kDerivedTypeDefinition` | |
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `alias` | `String` | nil | I represent the alias name of the procedure|
| `endPos` | `Number` | nil | |
| `interface` | `String` | nil | I represent the name of the interface|
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kTypeBoundProcedure',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTNamedEntity',
	#classTraits : 'FASTTNamedEntity classTrait',
	#instVars : [
		'#alias => FMProperty',
		'#derivedTypeDefinition => FMOne type: #FASTFortran2kDerivedTypeDefinition opposite: #typeBoundProcedures',
		'#interface => FMProperty'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kTypeBoundProcedure class >> annotation [

	<FMClass: #TypeBoundProcedure super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kTypeBoundProcedure >> alias [

	<FMProperty: #alias type: #String>
	<generated>
	<FMComment: 'I represent the alias name of the procedure'>
	^ alias
]

{ #category : 'accessing' }
FASTFortran2kTypeBoundProcedure >> alias: anObject [
	<generated>
	alias := anObject
]

{ #category : 'accessing' }
FASTFortran2kTypeBoundProcedure >> derivedTypeDefinition [
	"Relation named: #derivedTypeDefinition type: #FASTFortran2kDerivedTypeDefinition opposite: #typeBoundProcedures"

	<generated>
	<container>
	^ derivedTypeDefinition
]

{ #category : 'accessing' }
FASTFortran2kTypeBoundProcedure >> derivedTypeDefinition: anObject [

	<generated>
	derivedTypeDefinition := anObject
]

{ #category : 'navigation' }
FASTFortran2kTypeBoundProcedure >> derivedTypeDefinitionGroup [
	<generated>
	<navigation: 'DerivedTypeDefinition'>
	^ MooseSpecializedGroup with: self derivedTypeDefinition
]

{ #category : 'accessing' }
FASTFortran2kTypeBoundProcedure >> interface [

	<FMProperty: #interface type: #String>
	<generated>
	<FMComment: 'I represent the name of the interface'>
	^ interface
]

{ #category : 'accessing' }
FASTFortran2kTypeBoundProcedure >> interface: anObject [
	<generated>
	interface := anObject
]
