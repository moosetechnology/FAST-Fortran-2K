"
## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `derivedTypeDefinition` | `FASTFortran2kDerivedTypeParameter` | `derivedTypeParameters` | `FASTFortran2kDerivedTypeDefinition` | |



"
Class {
	#name : 'FASTFortran2kDerivedTypeParameter',
	#superclass : 'FASTFortran2kVariableDeclarationStatement',
	#instVars : [
		'#derivedTypeDefinition => FMOne type: #FASTFortran2kDerivedTypeDefinition opposite: #derivedTypeParameters'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kDerivedTypeParameter class >> annotation [

	<FMClass: #DerivedTypeParameter super: #FASTFortran2kVariableDeclarationStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeParameter >> derivedTypeDefinition [
	"Relation named: #derivedTypeDefinition type: #FASTFortran2kDerivedTypeDefinition opposite: #derivedTypeParameters"

	<generated>
	<container>
	^ derivedTypeDefinition
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeParameter >> derivedTypeDefinition: anObject [

	<generated>
	derivedTypeDefinition := anObject
]

{ #category : 'navigation' }
FASTFortran2kDerivedTypeParameter >> derivedTypeDefinitionGroup [
	<generated>
	<navigation: 'DerivedTypeDefinition'>
	^ MooseSpecializedGroup with: self derivedTypeDefinition
]
