"
I represent Fortran Format statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `format` | `FASTFortran2kTWithFormat` | `parentFormatedStatement` | `FASTFortran2kTFormat` | The description of the format|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `formatDescription` | `String` | nil | |

"
Class {
	#name : 'FASTFortran2kFormatStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTFortran2kTWithFormat',
	#classTraits : 'FASTFortran2kTWithFormat classTrait',
	#instVars : [
		'#formatDescription => FMProperty'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kFormatStatement class >> annotation [

	<FMClass: #FormatStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kFormatStatement >> formatDescription [

	<FMProperty: #formatDescription type: #String>
	<generated>
	^ formatDescription
]

{ #category : 'accessing' }
FASTFortran2kFormatStatement >> formatDescription: anObject [
	<generated>
	formatDescription := anObject
]
