"
I represent a non use renamed statement

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `useOnlyStatement` | `FASTFortran2kUseNoRenamedStatement` | `useNoRenamedStatements` | `FASTFortran2kUseOnlyStatement` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kUseNoRenamedStatement',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTNamedEntity',
	#classTraits : 'FASTTNamedEntity classTrait',
	#instVars : [
		'#useOnlyStatement => FMOne type: #FASTFortran2kUseOnlyStatement opposite: #useNoRenamedStatements'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kUseNoRenamedStatement class >> annotation [

	<FMClass: #UseNoRenamedStatement super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kUseNoRenamedStatement >> useOnlyStatement [
	"Relation named: #useOnlyStatement type: #FASTFortran2kUseOnlyStatement opposite: #useNoRenamedStatements"

	<generated>
	<container>
	^ useOnlyStatement
]

{ #category : 'accessing' }
FASTFortran2kUseNoRenamedStatement >> useOnlyStatement: anObject [

	<generated>
	useOnlyStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kUseNoRenamedStatement >> useOnlyStatementGroup [
	<generated>
	<navigation: 'UseOnlyStatement'>
	^ MooseSpecializedGroup with: self useOnlyStatement
]
