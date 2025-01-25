"
I represent Fortran Call statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `arguments` | `FASTTWithArguments` | `argumentOwner` | `FASTTExpression` | My arguments|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `name` | `String` | nil | Name of called entity (a subroutine)|

"
Class {
	#name : 'FASTFortran2kCallStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTTWithArguments',
	#classTraits : 'FASTTWithArguments classTrait',
	#instVars : [
		'#name => FMProperty'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kCallStatement class >> annotation [

	<FMClass: #CallStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kCallStatement >> name [

	<FMProperty: #name type: #String>
	<generated>
	<FMComment: 'Name of called entity (a subroutine)'>
	^ name
]

{ #category : 'accessing' }
FASTFortran2kCallStatement >> name: anObject [
	<generated>
	name := anObject
]
