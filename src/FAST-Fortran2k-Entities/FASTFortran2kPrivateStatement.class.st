"
Im a private statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `nameEntities` | `FASTFortran2kPrivateStatement` | `privateStatement` | `FASTFortran2kNameEntity` | |



"
Class {
	#name : 'FASTFortran2kPrivateStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#instVars : [
		'#nameEntities => FMMany type: #FASTFortran2kNameEntity opposite: #privateStatement'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kPrivateStatement class >> annotation [

	<FMClass: #PrivateStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kPrivateStatement >> addNameEntity: anObject [
	<generated>
	^ self nameEntities add: anObject
]

{ #category : 'accessing' }
FASTFortran2kPrivateStatement >> nameEntities [
	"Relation named: #nameEntities type: #FASTFortran2kNameEntity opposite: #privateStatement"

	<generated>
	<derived>
	^ nameEntities
]

{ #category : 'accessing' }
FASTFortran2kPrivateStatement >> nameEntities: anObject [

	<generated>
	nameEntities value: anObject
]

{ #category : 'navigation' }
FASTFortran2kPrivateStatement >> nameEntitiesGroup [
	<generated>
	<navigation: 'NameEntities'>
	^ MooseSpecializedGroup withAll: self nameEntities asSet
]
