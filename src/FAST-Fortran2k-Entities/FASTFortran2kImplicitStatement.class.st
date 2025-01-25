"
I represent Fortran Implicit statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `typingRules` | `FASTFortran2kImplicitStatement` | `parentImplicitStatement` | `FASTFortran2kImplicitTypingRule` | |



"
Class {
	#name : 'FASTFortran2kImplicitStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#instVars : [
		'#typingRules => FMMany type: #FASTFortran2kImplicitTypingRule opposite: #parentImplicitStatement'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kImplicitStatement class >> annotation [

	<FMClass: #ImplicitStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kImplicitStatement >> addTypingRule: anObject [
	<generated>
	^ self typingRules add: anObject
]

{ #category : 'accessing' }
FASTFortran2kImplicitStatement >> typingRules [
	"Relation named: #typingRules type: #FASTFortran2kImplicitTypingRule opposite: #parentImplicitStatement"

	<generated>
	<derived>
	^ typingRules
]

{ #category : 'accessing' }
FASTFortran2kImplicitStatement >> typingRules: anObject [

	<generated>
	typingRules value: anObject
]

{ #category : 'navigation' }
FASTFortran2kImplicitStatement >> typingRulesGroup [
	<generated>
	<navigation: 'TypingRules'>
	^ MooseSpecializedGroup withAll: self typingRules asSet
]
