"
An entity that can contain fortran program units and comments

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `comments` | `FASTTWithComments` | `container` | `FASTTComment` | list of comments defined in the entity|
| `programUnit` | `FASTFortran2kProgramFile` | `parentProgramFile` | `FASTFortran2kProgramUnit` | Program Units in a program file|



"
Class {
	#name : 'FASTFortran2kProgramFile',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTWithComments',
	#classTraits : 'FASTTWithComments classTrait',
	#instVars : [
		'#programUnit => FMMany type: #FASTFortran2kProgramUnit opposite: #parentProgramFile'
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
	^ self programUnit add: anObject
]

{ #category : 'accessing' }
FASTFortran2kProgramFile >> programUnit [
	"Relation named: #programUnit type: #FASTFortran2kProgramUnit opposite: #parentProgramFile"

	<generated>
	<FMComment: 'Program Units in a program file'>
	<derived>
	^ programUnit
]

{ #category : 'accessing' }
FASTFortran2kProgramFile >> programUnit: anObject [

	<generated>
	programUnit value: anObject
]

{ #category : 'navigation' }
FASTFortran2kProgramFile >> programUnitGroup [
	<generated>
	<navigation: 'ProgramUnit'>
	^ MooseSpecializedGroup withAll: self programUnit asSet
]
