"
I represent a loop control: initialization/limit/increment

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `loopControl` | `FASTFortran2kTWithLoopControl` | `parentLoop` | `FASTFortran2kLoopControlExpression` | loop control|



"
Trait {
	#name : 'FASTFortran2kTWithLoopControl',
	#instVars : [
		'#loopControl => FMOne type: #FASTFortran2kLoopControlExpression opposite: #parentLoop'
	],
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTWithLoopControl classSide >> annotation [

	<FMClass: #TWithLoopControl super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kTWithLoopControl >> loopControl [
	"Relation named: #loopControl type: #FASTFortran2kLoopControlExpression opposite: #parentLoop"

	<generated>
	<FMComment: 'loop control'>
	^ loopControl
]

{ #category : 'accessing' }
FASTFortran2kTWithLoopControl >> loopControl: anObject [

	<generated>
	loopControl := anObject
]

{ #category : 'navigation' }
FASTFortran2kTWithLoopControl >> loopControlGroup [
	<generated>
	<navigation: 'LoopControl'>
	^ MooseSpecializedGroup with: self loopControl
]
