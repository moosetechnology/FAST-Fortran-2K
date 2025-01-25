"
I am the abstract superclass of all IO-statements (READ, WRITE, CLOSE, ENCODE...)

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `ioParameters` | `FASTFortran2kAbstractIOStatement` | `parentIOStatement` | `FASTFortran2kTIOParameter` | IO-Parameters of an IO-statement (READ, WRITE...)|



"
Class {
	#name : 'FASTFortran2kAbstractIOStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#instVars : [
		'#ioParameters => FMMany type: #FASTFortran2kTIOParameter opposite: #parentIOStatement'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kAbstractIOStatement class >> annotation [

	<FMClass: #AbstractIOStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kAbstractIOStatement >> addIoParameter: anObject [
	<generated>
	^ self ioParameters add: anObject
]

{ #category : 'accessing' }
FASTFortran2kAbstractIOStatement >> ioParameters [
	"Relation named: #ioParameters type: #FASTFortran2kTIOParameter opposite: #parentIOStatement"

	<generated>
	<FMComment: 'IO-Parameters of an IO-statement (READ, WRITE...)'>
	<derived>
	^ ioParameters
]

{ #category : 'accessing' }
FASTFortran2kAbstractIOStatement >> ioParameters: anObject [

	<generated>
	ioParameters value: anObject
]

{ #category : 'navigation' }
FASTFortran2kAbstractIOStatement >> ioParametersGroup [
	<generated>
	<navigation: 'IoParameters'>
	^ MooseSpecializedGroup withAll: self ioParameters asSet
]
