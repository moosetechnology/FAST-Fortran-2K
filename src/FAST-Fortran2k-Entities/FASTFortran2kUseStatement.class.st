"
I represent a use statement

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `useRenames` | `FASTFortran2kUseStatement` | `useStatement` | `FASTFortran2kUseRename` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `modifiers` | `Object` | #() | A collection of modifiers (strings)|
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kUseStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTFortran2kTWithModifiers + FASTTNamedEntity',
	#classTraits : 'FASTFortran2kTWithModifiers classTrait + FASTTNamedEntity classTrait',
	#instVars : [
		'#useRenames => FMMany type: #FASTFortran2kUseRename opposite: #useStatement'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kUseStatement class >> annotation [

	<FMClass: #UseStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kUseStatement >> addUseRename: anObject [
	<generated>
	^ self useRenames add: anObject
]

{ #category : 'accessing' }
FASTFortran2kUseStatement >> useRenames [
	"Relation named: #useRenames type: #FASTFortran2kUseRename opposite: #useStatement"

	<generated>
	<derived>
	^ useRenames
]

{ #category : 'accessing' }
FASTFortran2kUseStatement >> useRenames: anObject [

	<generated>
	useRenames value: anObject
]

{ #category : 'navigation' }
FASTFortran2kUseStatement >> useRenamesGroup [
	<generated>
	<navigation: 'UseRenames'>
	^ MooseSpecializedGroup withAll: self useRenames asSet
]
