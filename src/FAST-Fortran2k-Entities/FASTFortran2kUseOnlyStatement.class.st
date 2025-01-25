"
I represent a only use statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `useNoRenamedStatements` | `FASTFortran2kUseOnlyStatement` | `useOnlyStatement` | `FASTFortran2kUseNoRenamedStatement` | |



"
Class {
	#name : 'FASTFortran2kUseOnlyStatement',
	#superclass : 'FASTFortran2kUseStatement',
	#instVars : [
		'#useNoRenamedStatements => FMMany type: #FASTFortran2kUseNoRenamedStatement opposite: #useOnlyStatement'
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
FASTFortran2kUseOnlyStatement >> addUseNoRenamedStatement: anObject [
	<generated>
	^ self useNoRenamedStatements add: anObject
]

{ #category : 'accessing' }
FASTFortran2kUseOnlyStatement >> useNoRenamedStatements [
	"Relation named: #useNoRenamedStatements type: #FASTFortran2kUseNoRenamedStatement opposite: #useOnlyStatement"

	<generated>
	<derived>
	^ useNoRenamedStatements
]

{ #category : 'accessing' }
FASTFortran2kUseOnlyStatement >> useNoRenamedStatements: anObject [

	<generated>
	useNoRenamedStatements value: anObject
]

{ #category : 'navigation' }
FASTFortran2kUseOnlyStatement >> useNoRenamedStatementsGroup [
	<generated>
	<navigation: 'UseNoRenamedStatements'>
	^ MooseSpecializedGroup withAll: self useNoRenamedStatements asSet
]
