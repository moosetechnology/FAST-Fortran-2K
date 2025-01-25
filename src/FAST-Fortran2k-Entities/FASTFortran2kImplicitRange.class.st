"
I represent a range of characters in an Implicit statement

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `parentImplicitRule` | `FASTFortran2kImplicitRange` | `ranges` | `FASTFortran2kImplicitTypingRule` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `from` | `String` | nil | Start of character range for implicit rule|
| `to` | `String` | nil | End of character range for implicit rule|

"
Class {
	#name : 'FASTFortran2kImplicitRange',
	#superclass : 'FASTFortran2kEntity',
	#instVars : [
		'#from => FMProperty',
		'#to => FMProperty',
		'#parentImplicitRule => FMOne type: #FASTFortran2kImplicitTypingRule opposite: #ranges'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kImplicitRange class >> annotation [

	<FMClass: #ImplicitRange super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kImplicitRange >> from [

	<FMProperty: #from type: #String>
	<generated>
	<FMComment: 'Start of character range for implicit rule'>
	^ from
]

{ #category : 'accessing' }
FASTFortran2kImplicitRange >> from: anObject [
	<generated>
	from := anObject
]

{ #category : 'accessing' }
FASTFortran2kImplicitRange >> parentImplicitRule [
	"Relation named: #parentImplicitRule type: #FASTFortran2kImplicitTypingRule opposite: #ranges"

	<generated>
	<container>
	^ parentImplicitRule
]

{ #category : 'accessing' }
FASTFortran2kImplicitRange >> parentImplicitRule: anObject [

	<generated>
	parentImplicitRule := anObject
]

{ #category : 'navigation' }
FASTFortran2kImplicitRange >> parentImplicitRuleGroup [
	<generated>
	<navigation: 'ParentImplicitRule'>
	^ MooseSpecializedGroup with: self parentImplicitRule
]

{ #category : 'accessing' }
FASTFortran2kImplicitRange >> to [

	<FMProperty: #to type: #String>
	<generated>
	<FMComment: 'End of character range for implicit rule'>
	^ to
]

{ #category : 'accessing' }
FASTFortran2kImplicitRange >> to: anObject [
	<generated>
	to := anObject
]
