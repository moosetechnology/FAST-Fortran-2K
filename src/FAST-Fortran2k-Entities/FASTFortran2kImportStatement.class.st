"
## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `nameEntities` | `FASTFortran2kImportStatement` | `importStatement` | `FASTFortran2kNameEntity` | |



"
Class {
	#name : 'FASTFortran2kImportStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#instVars : [
		'#nameEntities => FMMany type: #FASTFortran2kNameEntity opposite: #importStatement'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kImportStatement class >> annotation [

	<FMClass: #ImportStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kImportStatement >> addNameEntity: anObject [
	<generated>
	^ self nameEntities add: anObject
]

{ #category : 'accessing' }
FASTFortran2kImportStatement >> nameEntities [
	"Relation named: #nameEntities type: #FASTFortran2kNameEntity opposite: #importStatement"

	<generated>
	<derived>
	^ nameEntities
]

{ #category : 'accessing' }
FASTFortran2kImportStatement >> nameEntities: anObject [

	<generated>
	nameEntities value: anObject
]

{ #category : 'navigation' }
FASTFortran2kImportStatement >> nameEntitiesGroup [
	<generated>
	<navigation: 'NameEntities'>
	^ MooseSpecializedGroup withAll: self nameEntities asSet
]
