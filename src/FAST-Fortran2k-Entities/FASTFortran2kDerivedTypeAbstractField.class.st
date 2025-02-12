"
I represent a field (attribute, component,...) for a segment: either DerivedTypeComponent and DerivedTypeParameter

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `derivedTypeDefinition` | `FASTFortran2kDerivedTypeAbstractField` | `derivedTypeAbstractFields` | `FASTFortran2kDerivedTypeDefinition` | |



"
Class {
	#name : 'FASTFortran2kDerivedTypeAbstractField',
	#superclass : 'FASTFortran2kVariableDeclarationStatement',
	#instVars : [
		'#derivedTypeDefinition => FMOne type: #FASTFortran2kDerivedTypeDefinition opposite: #derivedTypeAbstractFields'
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
FASTFortran2kDerivedTypeAbstractField >> derivedTypeDefinition [
	"Relation named: #derivedTypeDefinition type: #FASTFortran2kDerivedTypeDefinition opposite: #derivedTypeAbstractFields"

	<generated>
	<container>
	^ derivedTypeDefinition
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeAbstractField >> derivedTypeDefinition: anObject [

	<generated>
	derivedTypeDefinition := anObject
]

{ #category : 'navigation' }
FASTFortran2kDerivedTypeAbstractField >> derivedTypeDefinitionGroup [
	<generated>
	<navigation: 'DerivedTypeDefinition'>
	^ MooseSpecializedGroup with: self derivedTypeDefinition
]
