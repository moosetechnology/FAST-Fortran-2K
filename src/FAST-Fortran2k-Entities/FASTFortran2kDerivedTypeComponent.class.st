"
I'm a derived type component

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `derivedTypeComponentDimensions` | `FASTFortran2kDerivedTypeComponent` | `derivedTypeComponent` | `FASTFortran2kDerivedTypeComponentDimension` | |

### Other
| Relation | Origin | Opposite | Type | Comment |
|---|
| `comment` | `FASTFortran2kDerivedTypeComponent` | `derivedTypeComponent` | `FASTFortran2kComment` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `rank` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kDerivedTypeComponent',
	#superclass : 'FASTFortran2kDerivedTypeAbstractField',
	#instVars : [
		'#rank => FMProperty',
		'#derivedTypeComponentDimensions => FMMany type: #FASTFortran2kDerivedTypeComponentDimension opposite: #derivedTypeComponent',
		'#comment => FMOne type: #FASTFortran2kComment opposite: #derivedTypeComponent'
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
FASTFortran2kDerivedTypeComponent >> addDerivedTypeComponentDimension: anObject [
	<generated>
	^ self derivedTypeComponentDimensions add: anObject
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
FASTFortran2kDerivedTypeComponent >> derivedTypeComponentDimensions [
	"Relation named: #derivedTypeComponentDimensions type: #FASTFortran2kDerivedTypeComponentDimension opposite: #derivedTypeComponent"

	<generated>
	<derived>
	^ derivedTypeComponentDimensions
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponent >> derivedTypeComponentDimensions: anObject [

	<generated>
	derivedTypeComponentDimensions value: anObject
]

{ #category : 'navigation' }
FASTFortran2kDerivedTypeComponent >> derivedTypeComponentDimensionsGroup [
	<generated>
	<navigation: 'DerivedTypeComponentDimensions'>
	^ MooseSpecializedGroup withAll: self derivedTypeComponentDimensions asSet
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponent >> rank [

	<FMProperty: #rank type: #Number>
	<generated>
	^ rank
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponent >> rank: anObject [
	<generated>
	rank := anObject
]
