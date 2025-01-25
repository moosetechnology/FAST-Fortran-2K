"
a Fortran Loop Control Expression

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `parentLoop` | `FASTFortran2kLoopControlExpression` | `loopControl` | `FASTFortran2kTWithLoopControl` | Parent loop|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `increment` | `FASTFortran2kLoopControlExpression` | `parentLoopControlIncrement` | `FASTFortran2kAbstractExpression` | Loop control increment value|
| `init` | `FASTFortran2kLoopControlExpression` | `parentLoopControlInitialization` | `FASTFortran2kAssignmentExpression` | initial assignment|
| `limit` | `FASTFortran2kLoopControlExpression` | `parentLoopControlLimit` | `FASTFortran2kAbstractExpression` | Loop control limit value|



"
Class {
	#name : 'FASTFortran2kLoopControlExpression',
	#superclass : 'FASTFortran2kEntity',
	#instVars : [
		'#parentLoop => FMOne type: #FASTFortran2kTWithLoopControl opposite: #loopControl',
		'#init => FMOne type: #FASTFortran2kAssignmentExpression opposite: #parentLoopControlInitialization',
		'#increment => FMOne type: #FASTFortran2kAbstractExpression opposite: #parentLoopControlIncrement',
		'#limit => FMOne type: #FASTFortran2kAbstractExpression opposite: #parentLoopControlLimit'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kLoopControlExpression class >> annotation [

	<FMClass: #LoopControlExpression super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kLoopControlExpression >> increment [
	"Relation named: #increment type: #FASTFortran2kAbstractExpression opposite: #parentLoopControlIncrement"

	<generated>
	<FMComment: 'Loop control increment value'>
	^ increment
]

{ #category : 'accessing' }
FASTFortran2kLoopControlExpression >> increment: anObject [

	<generated>
	increment := anObject
]

{ #category : 'navigation' }
FASTFortran2kLoopControlExpression >> incrementGroup [
	<generated>
	<navigation: 'Increment'>
	^ MooseSpecializedGroup with: self increment
]

{ #category : 'accessing' }
FASTFortran2kLoopControlExpression >> init [
	"Relation named: #init type: #FASTFortran2kAssignmentExpression opposite: #parentLoopControlInitialization"

	<generated>
	<FMComment: 'initial assignment'>
	^ init
]

{ #category : 'accessing' }
FASTFortran2kLoopControlExpression >> init: anObject [

	<generated>
	init := anObject
]

{ #category : 'navigation' }
FASTFortran2kLoopControlExpression >> initGroup [
	<generated>
	<navigation: 'Init'>
	^ MooseSpecializedGroup with: self init
]

{ #category : 'accessing' }
FASTFortran2kLoopControlExpression >> limit [
	"Relation named: #limit type: #FASTFortran2kAbstractExpression opposite: #parentLoopControlLimit"

	<generated>
	<FMComment: 'Loop control limit value'>
	^ limit
]

{ #category : 'accessing' }
FASTFortran2kLoopControlExpression >> limit: anObject [

	<generated>
	limit := anObject
]

{ #category : 'navigation' }
FASTFortran2kLoopControlExpression >> limitGroup [
	<generated>
	<navigation: 'Limit'>
	^ MooseSpecializedGroup with: self limit
]

{ #category : 'accessing' }
FASTFortran2kLoopControlExpression >> parentLoop [
	"Relation named: #parentLoop type: #FASTFortran2kTWithLoopControl opposite: #loopControl"

	<generated>
	<FMComment: 'Parent loop'>
	<container>
	<derived>
	^ parentLoop
]

{ #category : 'accessing' }
FASTFortran2kLoopControlExpression >> parentLoop: anObject [

	<generated>
	parentLoop := anObject
]

{ #category : 'navigation' }
FASTFortran2kLoopControlExpression >> parentLoopGroup [
	<generated>
	<navigation: 'ParentLoop'>
	^ MooseSpecializedGroup with: self parentLoop
]
