"
I represent a type declaration for one or many scalar variables or arrays

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `declarators` | `FASTFortran2kTWithDeclarators` | `parentDeclaration` | `FASTFortran2kVariableDeclarator` | variables declared|
| `declaredType` | `FASTFortran2kTDeclaredType` | `parentDeclaration` | `FASTFortran2kType` | type|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `modifiers` | `Object` | #() | A collection of modifiers (strings)|

"
Class {
	#name : 'FASTFortran2kVariableDeclarationStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTFortran2kTDeclaredType + FASTFortran2kTWithDeclarators + FASTFortran2kTWithModifiers',
	#classTraits : 'FASTFortran2kTDeclaredType classTrait + FASTFortran2kTWithDeclarators classTrait + FASTFortran2kTWithModifiers classTrait',
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
