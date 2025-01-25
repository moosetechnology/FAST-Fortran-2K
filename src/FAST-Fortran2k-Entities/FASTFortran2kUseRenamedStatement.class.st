"
I represent a use renamed statement

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `useStatement` | `FASTFortran2kUseRenamedStatement` | `useRenamedStatements` | `FASTFortran2kUseStatement` | |


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
	#name : 'FASTFortran2kUseRenamedStatement',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTNamedEntity',
	#classTraits : 'FASTTNamedEntity classTrait',
	#instVars : [
		'#alias => FMProperty',
		'#useStatement => FMOne type: #FASTFortran2kUseStatement opposite: #useRenamedStatements'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kUseRenamedStatement class >> annotation [

	<FMClass: #UseRenamedStatement super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kUseRenamedStatement >> alias [

	<FMProperty: #alias type: #String>
	<generated>
	<FMComment: 'I represent the alias of the used entity'>
	^ alias
]

{ #category : 'accessing' }
FASTFortran2kUseRenamedStatement >> alias: anObject [
	<generated>
	alias := anObject
]

{ #category : 'accessing' }
FASTFortran2kUseRenamedStatement >> useStatement [
	"Relation named: #useStatement type: #FASTFortran2kUseStatement opposite: #useRenamedStatements"

	<generated>
	<container>
	^ useStatement
]

{ #category : 'accessing' }
FASTFortran2kUseRenamedStatement >> useStatement: anObject [

	<generated>
	useStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kUseRenamedStatement >> useStatementGroup [
	<generated>
	<navigation: 'UseStatement'>
	^ MooseSpecializedGroup with: self useStatement
]
