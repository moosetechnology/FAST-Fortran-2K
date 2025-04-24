"
I represent a only use statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `useNoRenames` | `FASTFortran2kUseOnlyStatement` | `useOnlyStatement` | `FASTFortran2kUseNoRename` | |



"
Class {
	#name : 'FASTFortran2kUseOnlyStatement',
	#superclass : 'FASTFortran2kUseStatement',
	#instVars : [
		'#useNoRenames => FMMany type: #FASTFortran2kUseNoRename opposite: #useOnlyStatement'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kUseOnlyStatement class >> annotation [

	<FMClass: #UseOnlyStatement super: #FASTFortran2kUseStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kUseOnlyStatement >> addUseNoRename: anObject [
	<generated>
	^ self useNoRenames add: anObject
]

{ #category : 'accessing' }
FASTFortran2kUseOnlyStatement >> useNoRenames [
	"Relation named: #useNoRenames type: #FASTFortran2kUseNoRename opposite: #useOnlyStatement"

	<generated>
	<derived>
	^ useNoRenames
]

{ #category : 'accessing' }
FASTFortran2kUseOnlyStatement >> useNoRenames: anObject [

	<generated>
	useNoRenames value: anObject
]

{ #category : 'navigation' }
FASTFortran2kUseOnlyStatement >> useNoRenamesGroup [
	<generated>
	<navigation: 'UseNoRenames'>
	^ MooseSpecializedGroup withAll: self useNoRenames asSet
]
