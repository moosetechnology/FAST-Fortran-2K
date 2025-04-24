"
I represent a name with an alias of entity used in programUnit

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `useStatement` | `FASTFortran2kUseRename` | `useRenames` | `FASTFortran2kUseStatement` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `alias` | `String` | nil | I represent the alias of the used entity|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kUseRename',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTNamedEntity',
	#classTraits : 'FASTTNamedEntity classTrait',
	#instVars : [
		'#alias => FMProperty',
		'#useStatement => FMOne type: #FASTFortran2kUseStatement opposite: #useRenames'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kUseRename class >> annotation [

	<FMClass: #UseRename super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kUseRename >> alias [

	<FMProperty: #alias type: #String>
	<generated>
	<FMComment: 'I represent the alias of the used entity'>
	^ alias
]

{ #category : 'accessing' }
FASTFortran2kUseRename >> alias: anObject [
	<generated>
	alias := anObject
]

{ #category : 'accessing' }
FASTFortran2kUseRename >> useStatement [
	"Relation named: #useStatement type: #FASTFortran2kUseStatement opposite: #useRenames"

	<generated>
	<container>
	^ useStatement
]

{ #category : 'accessing' }
FASTFortran2kUseRename >> useStatement: anObject [

	<generated>
	useStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kUseRename >> useStatementGroup [
	<generated>
	<navigation: 'UseStatement'>
	^ MooseSpecializedGroup with: self useStatement
]
