"
I'm a derived type component

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `derivedTypeDefinition` | `FASTFortran2kDerivedTypeComponent` | `derivedTypeComponents` | `FASTFortran2kDerivedTypeDefinition` | |



"
Class {
	#name : 'FASTFortran2kDerivedTypeComponent',
	#superclass : 'FASTFortran2kVariableDeclarationStatement',
	#instVars : [
		'#derivedTypeDefinition => FMOne type: #FASTFortran2kDerivedTypeDefinition opposite: #derivedTypeComponents'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kDerivedTypeComponent class >> annotation [

	<FMClass: #DerivedTypeComponent super: #FASTFortran2kVariableDeclarationStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponent >> derivedTypeDefinition [
	"Relation named: #derivedTypeDefinition type: #FASTFortran2kDerivedTypeDefinition opposite: #derivedTypeComponents"

	<generated>
	<container>
	^ derivedTypeDefinition
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponent >> derivedTypeDefinition: anObject [

	<generated>
	derivedTypeDefinition := anObject
]

{ #category : 'navigation' }
FASTFortran2kDerivedTypeComponent >> derivedTypeDefinitionGroup [
	<generated>
	<navigation: 'DerivedTypeDefinition'>
	^ MooseSpecializedGroup with: self derivedTypeDefinition
]
