"
A fortran comment

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `container` | `FASTTComment` | `comments` | `FASTTWithComments` | Source code entity containing the comment|

### Other
| Relation | Origin | Opposite | Type | Comment |
|---|
| `derivedTypeComponent` | `FASTFortran2kComment` | `comment` | `FASTFortran2kDerivedTypeComponent` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `content` | `String` | nil | Content of the comment as a String|
| `endPos` | `Number` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kComment',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTTComment + FASTTEntity',
	#classTraits : 'FASTTComment classTrait + FASTTEntity classTrait',
	#instVars : [
		'#derivedTypeComponent => FMOne type: #FASTFortran2kDerivedTypeComponent opposite: #comment'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kComment class >> annotation [

	<FMClass: #Comment super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kComment >> derivedTypeComponent [
	"Relation named: #derivedTypeComponent type: #FASTFortran2kDerivedTypeComponent opposite: #comment"

	<generated>
	<derived>
	^ derivedTypeComponent
]

{ #category : 'accessing' }
FASTFortran2kComment >> derivedTypeComponent: anObject [

	<generated>
	derivedTypeComponent := anObject
]
