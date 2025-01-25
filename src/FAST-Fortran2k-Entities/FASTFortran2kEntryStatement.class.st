"
I represent Fortran Entry statement

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `entryArguments` | `FASTFortran2kEntryStatement` | `entryStatement` | `FASTFortran2kTEntryArgument` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kEntryStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTTNamedEntity',
	#classTraits : 'FASTTNamedEntity classTrait',
	#instVars : [
		'#entryArguments => FMMany type: #FASTFortran2kTEntryArgument opposite: #entryStatement'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kEntryStatement class >> annotation [

	<FMClass: #EntryStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kEntryStatement >> addEntryArgument: anObject [
	<generated>
	^ self entryArguments add: anObject
]

{ #category : 'accessing' }
FASTFortran2kEntryStatement >> entryArguments [
	"Relation named: #entryArguments type: #FASTFortran2kTEntryArgument opposite: #entryStatement"

	<generated>
	<derived>
	^ entryArguments
]

{ #category : 'accessing' }
FASTFortran2kEntryStatement >> entryArguments: anObject [

	<generated>
	entryArguments value: anObject
]

{ #category : 'navigation' }
FASTFortran2kEntryStatement >> entryArgumentsGroup [
	<generated>
	<navigation: 'EntryArguments'>
	^ MooseSpecializedGroup withAll: self entryArguments asSet
]
