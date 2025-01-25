"
Im a public statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `nameEntities` | `FASTFortran2kPublicStatement` | `publicStatement` | `FASTFortran2kNameEntity` | |



"
Class {
	#name : 'FASTFortran2kPublicStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#instVars : [
		'#nameEntities => FMMany type: #FASTFortran2kNameEntity opposite: #publicStatement'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kPublicStatement class >> annotation [

	<FMClass: #PublicStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kPublicStatement >> addNameEntity: anObject [
	<generated>
	^ self nameEntities add: anObject
]

{ #category : 'accessing' }
FASTFortran2kPublicStatement >> nameEntities [
	"Relation named: #nameEntities type: #FASTFortran2kNameEntity opposite: #publicStatement"

	<generated>
	<derived>
	^ nameEntities
]

{ #category : 'accessing' }
FASTFortran2kPublicStatement >> nameEntities: anObject [

	<generated>
	nameEntities value: anObject
]

{ #category : 'navigation' }
FASTFortran2kPublicStatement >> nameEntitiesGroup [
	<generated>
	<navigation: 'NameEntities'>
	^ MooseSpecializedGroup withAll: self nameEntities asSet
]
