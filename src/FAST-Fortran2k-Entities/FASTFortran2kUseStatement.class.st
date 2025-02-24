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
| `modifiers` | `FASTFortran2kTWithModifiers` | `modifierOwner` | `FASTFortran2kTModifier` | My modifiers|
| `useRenamedStatements` | `FASTFortran2kUseStatement` | `useStatement` | `FASTFortran2kUseRenamedStatement` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kUseStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTFortran2kTWithModifiers + FASTTNamedEntity',
	#classTraits : 'FASTFortran2kTWithModifiers classTrait + FASTTNamedEntity classTrait',
	#instVars : [
		'#useRenamedStatements => FMMany type: #FASTFortran2kUseRenamedStatement opposite: #useStatement'
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
FASTFortran2kUseStatement >> addUseRenamedStatement: anObject [
	<generated>
	^ self useRenamedStatements add: anObject
]

{ #category : 'accessing' }
FASTFortran2kUseStatement >> useRenamedStatements [
	"Relation named: #useRenamedStatements type: #FASTFortran2kUseRenamedStatement opposite: #useStatement"

	<generated>
	<derived>
	^ useRenamedStatements
]

{ #category : 'accessing' }
FASTFortran2kUseStatement >> useRenamedStatements: anObject [

	<generated>
	useRenamedStatements value: anObject
]

{ #category : 'navigation' }
FASTFortran2kUseStatement >> useRenamedStatementsGroup [
	<generated>
	<navigation: 'UseRenamedStatements'>
	^ MooseSpecializedGroup withAll: self useRenamedStatements asSet
]
