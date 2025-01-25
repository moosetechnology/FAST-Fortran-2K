"
I represent a derived type definition

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `derivedTypeComponents` | `FASTFortran2kDerivedTypeDefinition` | `derivedTypeDefinition` | `FASTFortran2kDerivedTypeComponent` | |
| `typeBoundProcedures` | `FASTFortran2kDerivedTypeDefinition` | `derivedTypeDefinition` | `FASTFortran2kTypeBoundProcedure` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |
| `superType` | `String` | nil | I represent the name of the super type|

"
Class {
	#name : 'FASTFortran2kDerivedTypeDefinition',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTTNamedEntity',
	#classTraits : 'FASTTNamedEntity classTrait',
	#instVars : [
		'#superType => FMProperty',
		'#derivedTypeComponents => FMMany type: #FASTFortran2kDerivedTypeComponent opposite: #derivedTypeDefinition',
		'#typeBoundProcedures => FMMany type: #FASTFortran2kTypeBoundProcedure opposite: #derivedTypeDefinition'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kDerivedTypeDefinition class >> annotation [

	<FMClass: #DerivedTypeDefinition super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kDerivedTypeDefinition >> addDerivedTypeComponent: anObject [
	<generated>
	^ self derivedTypeComponents add: anObject
]

{ #category : 'adding' }
FASTFortran2kDerivedTypeDefinition >> addTypeBoundProcedure: anObject [
	<generated>
	^ self typeBoundProcedures add: anObject
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeDefinition >> derivedTypeComponents [
	"Relation named: #derivedTypeComponents type: #FASTFortran2kDerivedTypeComponent opposite: #derivedTypeDefinition"

	<generated>
	<derived>
	^ derivedTypeComponents
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeDefinition >> derivedTypeComponents: anObject [

	<generated>
	derivedTypeComponents value: anObject
]

{ #category : 'navigation' }
FASTFortran2kDerivedTypeDefinition >> derivedTypeComponentsGroup [
	<generated>
	<navigation: 'DerivedTypeComponents'>
	^ MooseSpecializedGroup withAll: self derivedTypeComponents asSet
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeDefinition >> superType [

	<FMProperty: #superType type: #String>
	<generated>
	<FMComment: 'I represent the name of the super type'>
	^ superType
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeDefinition >> superType: anObject [
	<generated>
	superType := anObject
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeDefinition >> typeBoundProcedures [
	"Relation named: #typeBoundProcedures type: #FASTFortran2kTypeBoundProcedure opposite: #derivedTypeDefinition"

	<generated>
	<derived>
	^ typeBoundProcedures
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeDefinition >> typeBoundProcedures: anObject [

	<generated>
	typeBoundProcedures value: anObject
]

{ #category : 'navigation' }
FASTFortran2kDerivedTypeDefinition >> typeBoundProceduresGroup [
	<generated>
	<navigation: 'TypeBoundProcedures'>
	^ MooseSpecializedGroup withAll: self typeBoundProcedures asSet
]
