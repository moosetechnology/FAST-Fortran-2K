"
An entity that can contain fortran program units and comments

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `comments` | `FASTTWithComments` | `container` | `FASTTComment` | list of comments defined in the entity|
| `programUnits` | `FASTFortran2kProgramFile` | `programFile` | `FASTFortran2kProgramUnit` | Program Units in a program file|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `filename` | `String` | nil | |

"
Class {
	#name : 'FASTFortran2kProgramFile',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTWithComments',
	#classTraits : 'FASTTWithComments classTrait',
	#instVars : [
		'#filename => FMProperty',
		'#programUnits => FMMany type: #FASTFortran2kProgramUnit opposite: #programFile'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kProgramFile class >> annotation [

	<FMClass: #ProgramFile super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kProgramFile >> addProgramUnit: anObject [
	<generated>
	^ self programUnits add: anObject
]

{ #category : 'accessing' }
FASTFortran2kProgramFile >> filename [

	<FMProperty: #filename type: #String>
	<generated>
	^ filename
]

{ #category : 'accessing' }
FASTFortran2kProgramFile >> filename: anObject [
	<generated>
	filename := anObject
]

{ #category : 'accessing' }
FASTFortran2kProgramFile >> programUnits [
	"Relation named: #programUnits type: #FASTFortran2kProgramUnit opposite: #programFile"

	<generated>
	<FMComment: 'Program Units in a program file'>
	<derived>
	^ programUnits
]

{ #category : 'accessing' }
FASTFortran2kProgramFile >> programUnits: anObject [

	<generated>
	programUnits value: anObject
]

{ #category : 'navigation' }
FASTFortran2kProgramFile >> programUnitsGroup [
	<generated>
	<navigation: 'ProgramUnits'>
	^ MooseSpecializedGroup withAll: self programUnits asSet
]
