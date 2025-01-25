"
I represent Common group inside a Common statement

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `parentCommonStatement` | `FASTFortran2kCommonGroup` | `groups` | `FASTFortran2kCommonStatement` | Parent common statement I belong to|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `declarators` | `FASTFortran2kTWithDeclarators` | `parentDeclaration` | `FASTFortran2kVariableDeclarator` | variables declared|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kCommonGroup',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTFortran2kTWithDeclarators + FASTTNamedEntity',
	#classTraits : 'FASTFortran2kTWithDeclarators classTrait + FASTTNamedEntity classTrait',
	#instVars : [
		'#parentCommonStatement => FMOne type: #FASTFortran2kCommonStatement opposite: #groups'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kCommonGroup class >> annotation [

	<FMClass: #CommonGroup super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kCommonGroup >> parentCommonStatement [
	"Relation named: #parentCommonStatement type: #FASTFortran2kCommonStatement opposite: #groups"

	<generated>
	<FMComment: 'Parent common statement I belong to'>
	<container>
	^ parentCommonStatement
]

{ #category : 'accessing' }
FASTFortran2kCommonGroup >> parentCommonStatement: anObject [

	<generated>
	parentCommonStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kCommonGroup >> parentCommonStatementGroup [
	<generated>
	<navigation: 'ParentCommonStatement'>
	^ MooseSpecializedGroup with: self parentCommonStatement
]
