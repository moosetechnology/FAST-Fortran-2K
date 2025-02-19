"
I represent a type declaration for one or many scalar variables or arrays

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `declarators` | `FASTFortran2kTWithDeclarators` | `parentDeclaration` | `FASTFortran2kVariableDeclarator` | variables declared|
| `declaredType` | `FASTFortran2kTDeclaredType` | `parentDeclaration` | `FASTFortran2kType` | type|



"
Class {
	#name : 'FASTFortran2kVariableDeclarationStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTFortran2kTDeclaredType + FASTFortran2kTWithDeclarators',
	#classTraits : 'FASTFortran2kTDeclaredType classTrait + FASTFortran2kTWithDeclarators classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kVariableDeclarationStatement class >> annotation [

	<FMClass: #VariableDeclarationStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
