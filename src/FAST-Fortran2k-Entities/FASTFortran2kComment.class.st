"
A fortran comment

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `container` | `FASTTComment` | `comments` | `FASTTWithComments` | Source code entity containing the comment|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `content` | `String` | nil | Content of the comment as a String|
| `content` | `String` | nil | Determines a content of a comment|
| `endPos` | `Number` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kComment',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTComment + FASTTEntity',
	#classTraits : 'FASTTComment classTrait + FASTTEntity classTrait',
	#instVars : [
		'#content => FMProperty'
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
