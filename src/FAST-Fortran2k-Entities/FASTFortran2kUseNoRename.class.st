"
I represent a name of an entity used in programUnit

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `useOnlyStatement` | `FASTFortran2kUseNoRename` | `useNoRenames` | `FASTFortran2kUseOnlyStatement` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kUseNoRename',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTNamedEntity',
	#classTraits : 'FASTTNamedEntity classTrait',
	#instVars : [
		'#useOnlyStatement => FMOne type: #FASTFortran2kUseOnlyStatement opposite: #useNoRenames'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kUseNoRename class >> annotation [

	<FMClass: #UseNoRename super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kUseNoRename >> useOnlyStatement [
	"Relation named: #useOnlyStatement type: #FASTFortran2kUseOnlyStatement opposite: #useNoRenames"

	<generated>
	<container>
	^ useOnlyStatement
]

{ #category : 'accessing' }
FASTFortran2kUseNoRename >> useOnlyStatement: anObject [

	<generated>
	useOnlyStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kUseNoRename >> useOnlyStatementGroup [
	<generated>
	<navigation: 'UseOnlyStatement'>
	^ MooseSpecializedGroup with: self useOnlyStatement
]
