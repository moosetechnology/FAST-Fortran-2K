"
I represent a derived type definition for example:
	
	```fortran
	!this a general commment
	public bar
	type :: bar
		integer, private ::idim= 0
		integer, private ::jdim= 0
		
		!idata is an integer array of rank 1
		integer, pointer, public ::idata(:) => null()
		
		!jdata is an integer array of rank 2 with non-trivial expression of its dimensions
		integer, pointer, public ::jdata(:, :) => null()
	end type bar
	```
	
	it is a translation of this esope segment definition
	
	```fortran
	c this a general commment
	segment bar
		C idata is an integer array ofrank 1
		integeridata(idim)
	
		C jdata is an integer array ofrank 2with non-trivial expression of its dimensions
		integerjdata(jdim + 1, jdim + 2)
	end segment
	```
	

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `comments` | `FASTTWithComments` | `container` | `FASTTComment` | list of comments defined in the entity|
| `fields` | `FASTFortran2kDerivedTypeDefinition` | `fieldOwner` | `FASTFortran2kDerivedTypeAbstractField` | My field|
| `methods` | `FASTFortran2kDerivedTypeDefinition` | `methodOwner` | `FASTFortran2kTypeBoundProcedure` | My type bound procedure|
| `modifiers` | `FASTFortran2kTWithModifiers` | `modifierOwner` | `FASTFortran2kTModifier` | My modifiers|


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
	#traits : 'FASTFortran2kTWithModifiers + FASTTNamedEntity + FASTTWithComments',
	#classTraits : 'FASTFortran2kTWithModifiers classTrait + FASTTNamedEntity classTrait + FASTTWithComments classTrait',
	#instVars : [
		'#fields => FMMany type: #FASTFortran2kDerivedTypeAbstractField opposite: #fieldOwner',
		'#methods => FMMany type: #FASTFortran2kTypeBoundProcedure opposite: #methodOwner',
		'#superType => FMProperty'
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
FASTFortran2kDerivedTypeDefinition >> addField: anObject [
	<generated>
	^ self fields add: anObject
]

{ #category : 'adding' }
FASTFortran2kDerivedTypeDefinition >> addMethod: anObject [
	<generated>
	^ self methods add: anObject
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeDefinition >> fields [
	"Relation named: #fields type: #FASTFortran2kDerivedTypeAbstractField opposite: #fieldOwner"

	<generated>
	<FMComment: 'My field'>
	<derived>
	^ fields
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeDefinition >> fields: anObject [

	<generated>
	fields value: anObject
]

{ #category : 'navigation' }
FASTFortran2kDerivedTypeDefinition >> fieldsGroup [
	<generated>
	<navigation: 'Fields'>
	^ MooseSpecializedGroup withAll: self fields asSet
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeDefinition >> methods [
	"Relation named: #methods type: #FASTFortran2kTypeBoundProcedure opposite: #methodOwner"

	<generated>
	<FMComment: 'My type bound procedure'>
	<derived>
	^ methods
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeDefinition >> methods: anObject [

	<generated>
	methods value: anObject
]

{ #category : 'navigation' }
FASTFortran2kDerivedTypeDefinition >> methodsGroup [
	<generated>
	<navigation: 'Methods'>
	^ MooseSpecializedGroup withAll: self methods asSet
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
