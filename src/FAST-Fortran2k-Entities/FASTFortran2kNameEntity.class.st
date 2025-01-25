"
Im an item of access-id-list

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `importStatement` | `FASTFortran2kNameEntity` | `nameEntities` | `FASTFortran2kImportStatement` | |
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `privateStatement` | `FASTFortran2kNameEntity` | `nameEntities` | `FASTFortran2kPrivateStatement` | |
| `publicStatement` | `FASTFortran2kNameEntity` | `nameEntities` | `FASTFortran2kPublicStatement` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kNameEntity',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTNamedEntity',
	#classTraits : 'FASTTNamedEntity classTrait',
	#instVars : [
		'#importStatement => FMOne type: #FASTFortran2kImportStatement opposite: #nameEntities',
		'#publicStatement => FMOne type: #FASTFortran2kPublicStatement opposite: #nameEntities',
		'#privateStatement => FMOne type: #FASTFortran2kPrivateStatement opposite: #nameEntities'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kNameEntity class >> annotation [

	<FMClass: #NameEntity super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kNameEntity >> importStatement [
	"Relation named: #importStatement type: #FASTFortran2kImportStatement opposite: #nameEntities"

	<generated>
	<container>
	^ importStatement
]

{ #category : 'accessing' }
FASTFortran2kNameEntity >> importStatement: anObject [

	<generated>
	importStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kNameEntity >> importStatementGroup [
	<generated>
	<navigation: 'ImportStatement'>
	^ MooseSpecializedGroup with: self importStatement
]

{ #category : 'accessing' }
FASTFortran2kNameEntity >> privateStatement [
	"Relation named: #privateStatement type: #FASTFortran2kPrivateStatement opposite: #nameEntities"

	<generated>
	<container>
	^ privateStatement
]

{ #category : 'accessing' }
FASTFortran2kNameEntity >> privateStatement: anObject [

	<generated>
	privateStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kNameEntity >> privateStatementGroup [
	<generated>
	<navigation: 'PrivateStatement'>
	^ MooseSpecializedGroup with: self privateStatement
]

{ #category : 'accessing' }
FASTFortran2kNameEntity >> publicStatement [
	"Relation named: #publicStatement type: #FASTFortran2kPublicStatement opposite: #nameEntities"

	<generated>
	<container>
	^ publicStatement
]

{ #category : 'accessing' }
FASTFortran2kNameEntity >> publicStatement: anObject [

	<generated>
	publicStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kNameEntity >> publicStatementGroup [
	<generated>
	<navigation: 'PublicStatement'>
	^ MooseSpecializedGroup with: self publicStatement
]
