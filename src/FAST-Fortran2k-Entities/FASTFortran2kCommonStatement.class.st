"
I represent Fortran Common statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `groups` | `FASTFortran2kCommonStatement` | `parentCommonStatement` | `FASTFortran2kCommonGroup` | List common groups in this common statement|



"
Class {
	#name : 'FASTFortran2kCommonStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#instVars : [
		'#groups => FMMany type: #FASTFortran2kCommonGroup opposite: #parentCommonStatement'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kCommonStatement class >> annotation [

	<FMClass: #CommonStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kCommonStatement >> addGroup: anObject [
	<generated>
	^ self groups add: anObject
]

{ #category : 'accessing' }
FASTFortran2kCommonStatement >> groups [
	"Relation named: #groups type: #FASTFortran2kCommonGroup opposite: #parentCommonStatement"

	<generated>
	<FMComment: 'List common groups in this common statement'>
	<derived>
	^ groups
]

{ #category : 'accessing' }
FASTFortran2kCommonStatement >> groups: anObject [

	<generated>
	groups value: anObject
]

{ #category : 'navigation' }
FASTFortran2kCommonStatement >> groupsGroup [
	<generated>
	<navigation: 'Groups'>
	^ MooseSpecializedGroup withAll: self groups asSet
]
