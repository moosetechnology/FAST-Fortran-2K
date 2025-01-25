"
I represent a parameter to an IO-statement (read or write)

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `parentIOStatement` | `FASTFortran2kTIOParameter` | `ioParameters` | `FASTFortran2kAbstractIOStatement` | |



"
Trait {
	#name : 'FASTFortran2kTIOParameter',
	#instVars : [
		'#parentIOStatement => FMOne type: #FASTFortran2kAbstractIOStatement opposite: #ioParameters'
	],
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTIOParameter classSide >> annotation [

	<FMClass: #TIOParameter super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kTIOParameter >> parentIOStatement [
	"Relation named: #parentIOStatement type: #FASTFortran2kAbstractIOStatement opposite: #ioParameters"

	<generated>
	<container>
	^ parentIOStatement
]

{ #category : 'accessing' }
FASTFortran2kTIOParameter >> parentIOStatement: anObject [

	<generated>
	parentIOStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kTIOParameter >> parentIOStatementGroup [
	<generated>
	<navigation: 'ParentIOStatement'>
	^ MooseSpecializedGroup with: self parentIOStatement
]
