"
I represent Fortran Parameter statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `declarators` | `FASTFortran2kTWithDeclarators` | `parentDeclaration` | `FASTFortran2kVariableDeclarator` | variables declared|



"
Class {
	#name : 'FASTFortran2kParameterStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTFortran2kTWithDeclarators',
	#classTraits : 'FASTFortran2kTWithDeclarators classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kParameterStatement class >> annotation [

	<FMClass: #ParameterStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
