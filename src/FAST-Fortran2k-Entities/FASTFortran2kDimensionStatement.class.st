"
I represent FortranDimension statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `declarators` | `FASTFortran2kTWithDeclarators` | `parentDeclaration` | `FASTFortran2kVariableDeclarator` | variables declared|



"
Class {
	#name : 'FASTFortran2kDimensionStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTFortran2kTWithDeclarators',
	#classTraits : 'FASTFortran2kTWithDeclarators classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kDimensionStatement class >> annotation [

	<FMClass: #DimensionStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
