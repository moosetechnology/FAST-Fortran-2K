"
I'm a derived type component

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `comments` | `FASTTWithComments` | `container` | `FASTTComment` | list of comments defined in the entity|
| `dimensions` | `FASTFortran2kDerivedTypeComponent` | `dimensionOwner` | `FASTFortran2kDerivedTypeComponentDimension` | My dimension|

### Other
| Relation | Origin | Opposite | Type | Comment |
|---|
| `comment` | `FASTFortran2kDerivedTypeComponent` | `derivedTypeComponent` | `FASTFortran2kComment` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `rank` | `Number` | 0 | |

"
Class {
	#name : 'FASTFortran2kDerivedTypeComponent',
	#superclass : 'FASTFortran2kDerivedTypeAbstractField',
	#traits : 'FASTTWithComments',
	#classTraits : 'FASTTWithComments classTrait',
	#instVars : [
		'#comment => FMOne type: #FASTFortran2kComment opposite: #derivedTypeComponent',
		'#dimensions => FMMany type: #FASTFortran2kDerivedTypeComponentDimension opposite: #dimensionOwner',
		'#rank => FMProperty defaultValue: 0'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kDerivedTypeComponent class >> annotation [

	<FMClass: #DerivedTypeComponent super: #FASTFortran2kDerivedTypeAbstractField>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kDerivedTypeComponent >> addDimension: anObject [
	<generated>
	^ self dimensions add: anObject
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponent >> comment [
	"Relation named: #comment type: #FASTFortran2kComment opposite: #derivedTypeComponent"

	<generated>
	^ comment
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponent >> comment: anObject [

	<generated>
	comment := anObject
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponent >> dimensions [
	"Relation named: #dimensions type: #FASTFortran2kDerivedTypeComponentDimension opposite: #dimensionOwner"

	<generated>
	<FMComment: 'My dimension'>
	<derived>
	^ dimensions
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponent >> dimensions: anObject [

	<generated>
	dimensions value: anObject
]

{ #category : 'navigation' }
FASTFortran2kDerivedTypeComponent >> dimensionsGroup [
	<generated>
	<navigation: 'Dimensions'>
	^ MooseSpecializedGroup withAll: self dimensions asSet
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponent >> rank [

	<FMProperty: #rank type: #Number defaultValue: 0>
	<generated>
	^ rank ifNil: [ rank := 0 ]
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponent >> rank: anObject [
	<generated>
	rank := anObject
]
