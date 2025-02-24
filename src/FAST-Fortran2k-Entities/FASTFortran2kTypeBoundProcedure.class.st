"
Im a type-bound-procedure

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `methodOwner` | `FASTFortran2kTypeBoundProcedure` | `methods` | `FASTFortran2kDerivedTypeDefinition` | The owner of the type bound procedure|


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
		'#interface => FMProperty',
		'#methodOwner => FMOne type: #FASTFortran2kDerivedTypeDefinition opposite: #methods'
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

{ #category : 'accessing' }
FASTFortran2kTypeBoundProcedure >> methodOwner [
	"Relation named: #methodOwner type: #FASTFortran2kDerivedTypeDefinition opposite: #methods"

	<generated>
	<FMComment: 'The owner of the type bound procedure'>
	<container>
	^ methodOwner
]

{ #category : 'accessing' }
FASTFortran2kTypeBoundProcedure >> methodOwner: anObject [

	<generated>
	methodOwner := anObject
]

{ #category : 'navigation' }
FASTFortran2kTypeBoundProcedure >> methodOwnerGroup [
	<generated>
	<navigation: 'MethodOwner'>
	^ MooseSpecializedGroup with: self methodOwner
]
