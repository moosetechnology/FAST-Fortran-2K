"
I represent a type declaration for one or many scalar variables or arrays

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `declarators` | `FASTFortran2kTWithDeclarators` | `parentDeclaration` | `FASTFortran2kVariableDeclarator` | variables declared|
| `type` | `FASTFortran2kVariableDeclarationStatement` | `parentDeclaration` | `FASTFortran2kType` | type|



"
Class {
	#name : 'FASTFortran2kVariableDeclarationStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTFortran2kTWithDeclarators',
	#classTraits : 'FASTFortran2kTWithDeclarators classTrait',
	#instVars : [
		'#type => FMOne type: #FASTFortran2kType opposite: #parentDeclaration'
	],
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

{ #category : 'accessing' }
FASTFortran2kVariableDeclarationStatement >> type [
	"Relation named: #type type: #FASTFortran2kType opposite: #parentDeclaration"

	<generated>
	<FMComment: 'type'>
	^ type
]

{ #category : 'accessing' }
FASTFortran2kVariableDeclarationStatement >> type: anObject [

	<generated>
	type := anObject
]

{ #category : 'navigation' }
FASTFortran2kVariableDeclarationStatement >> typeGroup [
	<generated>
	<navigation: 'Type'>
	^ MooseSpecializedGroup with: self type
]
