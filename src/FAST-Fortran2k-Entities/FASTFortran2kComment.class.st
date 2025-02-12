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
| `derivedTypeDefinition` | `FASTFortran2kComment` | `comment` | `FASTFortran2kDerivedTypeDefinition` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `content` | `String` | nil | Determines a content of a comment|
| `content` | `String` | nil | Content of the comment as a String|
| `endPos` | `Number` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kComment',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTComment + FASTTEntity',
	#classTraits : 'FASTTComment classTrait + FASTTEntity classTrait',
	#instVars : [
		'#content => FMProperty',
		'#derivedTypeDefinition => FMOne type: #FASTFortran2kDerivedTypeDefinition opposite: #comment',
		'#derivedTypeComponent => FMOne type: #FASTFortran2kDerivedTypeComponent opposite: #comment'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kComment class >> annotation [

	<FMClass: #Comment super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kComment >> content [

	<FMProperty: #content type: #String>
	<generated>
	<FMComment: 'Determines a content of a comment'>
	^ content
]

{ #category : 'accessing' }
FASTFortran2kComment >> content: anObject [
	<generated>
	content := anObject
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

{ #category : 'accessing' }
FASTFortran2kComment >> derivedTypeDefinition [
	"Relation named: #derivedTypeDefinition type: #FASTFortran2kDerivedTypeDefinition opposite: #comment"

	<generated>
	<derived>
	^ derivedTypeDefinition
]

{ #category : 'accessing' }
FASTFortran2kComment >> derivedTypeDefinition: anObject [

	<generated>
	derivedTypeDefinition := anObject
]
