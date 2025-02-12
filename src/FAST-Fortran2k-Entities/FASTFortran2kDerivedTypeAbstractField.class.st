"
I represent a field (attribute, component,...) for a segment: either DerivedTypeComponent and DerivedTypeParameter

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `parentDerivedType` | `FASTFortran2kDerivedTypeAbstractField` | `fields` | `FASTFortran2kDerivedTypeDefinition` | |



"
Class {
	#name : 'FASTFortran2kDerivedTypeAbstractField',
	#superclass : 'FASTFortran2kVariableDeclarationStatement',
	#instVars : [
		'#parentDerivedType => FMOne type: #FASTFortran2kDerivedTypeDefinition opposite: #fields'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kDerivedTypeAbstractField class >> annotation [

	<FMClass: #DerivedTypeAbstractField super: #FASTFortran2kVariableDeclarationStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeAbstractField >> parentDerivedType [
	"Relation named: #parentDerivedType type: #FASTFortran2kDerivedTypeDefinition opposite: #fields"

	<generated>
	<container>
	^ parentDerivedType
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeAbstractField >> parentDerivedType: anObject [

	<generated>
	parentDerivedType := anObject
]

{ #category : 'navigation' }
FASTFortran2kDerivedTypeAbstractField >> parentDerivedTypeGroup [
	<generated>
	<navigation: 'ParentDerivedType'>
	^ MooseSpecializedGroup with: self parentDerivedType
]
