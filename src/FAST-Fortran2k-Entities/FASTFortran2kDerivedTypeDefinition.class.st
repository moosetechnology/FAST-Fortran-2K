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
| `derivedTypeAbstractFields` | `FASTFortran2kDerivedTypeDefinition` | `derivedTypeDefinition` | `FASTFortran2kDerivedTypeAbstractField` | |
| `typeBoundProcedures` | `FASTFortran2kDerivedTypeDefinition` | `derivedTypeDefinition` | `FASTFortran2kTypeBoundProcedure` | |

### Other
| Relation | Origin | Opposite | Type | Comment |
|---|
| `comment` | `FASTFortran2kDerivedTypeDefinition` | `derivedTypeDefinition` | `FASTFortran2kComment` | |


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
		'#comment => FMOne type: #FASTFortran2kComment opposite: #derivedTypeDefinition',
		'#derivedTypeAbstractFields => FMMany type: #FASTFortran2kDerivedTypeAbstractField opposite: #derivedTypeDefinition',
		'#superType => FMProperty',
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
FASTFortran2kDerivedTypeDefinition >> addDerivedTypeAbstractField: anObject [
	<generated>
	^ self derivedTypeAbstractFields add: anObject
]

{ #category : 'adding' }
FASTFortran2kDerivedTypeDefinition >> addTypeBoundProcedure: anObject [
	<generated>
	^ self typeBoundProcedures add: anObject
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeDefinition >> comment [
	"Relation named: #comment type: #FASTFortran2kComment opposite: #derivedTypeDefinition"

	<generated>
	^ comment
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeDefinition >> comment: anObject [

	<generated>
	comment := anObject
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeDefinition >> derivedTypeAbstractFields [
	"Relation named: #derivedTypeAbstractFields type: #FASTFortran2kDerivedTypeAbstractField opposite: #derivedTypeDefinition"

	<generated>
	<derived>
	^ derivedTypeAbstractFields
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeDefinition >> derivedTypeAbstractFields: anObject [

	<generated>
	derivedTypeAbstractFields value: anObject
]

{ #category : 'navigation' }
FASTFortran2kDerivedTypeDefinition >> derivedTypeAbstractFieldsGroup [
	<generated>
	<navigation: 'DerivedTypeAbstractFields'>
	^ MooseSpecializedGroup withAll: self derivedTypeAbstractFields asSet
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
