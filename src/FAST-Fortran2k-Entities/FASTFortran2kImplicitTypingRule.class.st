"
I represent a rule (ie. Type+letter range) in an Implicit statement

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `parentImplicitStatement` | `FASTFortran2kImplicitTypingRule` | `typingRules` | `FASTFortran2kImplicitStatement` | |

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `ranges` | `FASTFortran2kImplicitTypingRule` | `parentImplicitRule` | `FASTFortran2kImplicitRange` | |
| `type` | `FASTFortran2kImplicitTypingRule` | `parentImplicitRule` | `FASTFortran2kType` | |



"
Class {
	#name : 'FASTFortran2kImplicitTypingRule',
	#superclass : 'FASTFortran2kEntity',
	#instVars : [
		'#parentImplicitStatement => FMOne type: #FASTFortran2kImplicitStatement opposite: #typingRules',
		'#type => FMOne type: #FASTFortran2kType opposite: #parentImplicitRule',
		'#ranges => FMMany type: #FASTFortran2kImplicitRange opposite: #parentImplicitRule'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kImplicitTypingRule class >> annotation [

	<FMClass: #ImplicitTypingRule super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kImplicitTypingRule >> addRange: anObject [
	<generated>
	^ self ranges add: anObject
]

{ #category : 'accessing' }
FASTFortran2kImplicitTypingRule >> parentImplicitStatement [
	"Relation named: #parentImplicitStatement type: #FASTFortran2kImplicitStatement opposite: #typingRules"

	<generated>
	<container>
	^ parentImplicitStatement
]

{ #category : 'accessing' }
FASTFortran2kImplicitTypingRule >> parentImplicitStatement: anObject [

	<generated>
	parentImplicitStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kImplicitTypingRule >> parentImplicitStatementGroup [
	<generated>
	<navigation: 'ParentImplicitStatement'>
	^ MooseSpecializedGroup with: self parentImplicitStatement
]

{ #category : 'accessing' }
FASTFortran2kImplicitTypingRule >> ranges [
	"Relation named: #ranges type: #FASTFortran2kImplicitRange opposite: #parentImplicitRule"

	<generated>
	<derived>
	^ ranges
]

{ #category : 'accessing' }
FASTFortran2kImplicitTypingRule >> ranges: anObject [

	<generated>
	ranges value: anObject
]

{ #category : 'navigation' }
FASTFortran2kImplicitTypingRule >> rangesGroup [
	<generated>
	<navigation: 'Ranges'>
	^ MooseSpecializedGroup withAll: self ranges asSet
]

{ #category : 'accessing' }
FASTFortran2kImplicitTypingRule >> type [
	"Relation named: #type type: #FASTFortran2kType opposite: #parentImplicitRule"

	<generated>
	^ type
]

{ #category : 'accessing' }
FASTFortran2kImplicitTypingRule >> type: anObject [

	<generated>
	type := anObject
]

{ #category : 'navigation' }
FASTFortran2kImplicitTypingRule >> typeGroup [
	<generated>
	<navigation: 'Type'>
	^ MooseSpecializedGroup with: self type
]
