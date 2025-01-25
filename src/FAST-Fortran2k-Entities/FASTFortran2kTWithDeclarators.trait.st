"
I represent a declaration with several variable declarators

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `declarators` | `FASTFortran2kTWithDeclarators` | `parentDeclaration` | `FASTFortran2kVariableDeclarator` | variables declared|



"
Trait {
	#name : 'FASTFortran2kTWithDeclarators',
	#instVars : [
		'#declarators => FMMany type: #FASTFortran2kVariableDeclarator opposite: #parentDeclaration'
	],
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTWithDeclarators classSide >> annotation [

	<FMClass: #TWithDeclarators super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kTWithDeclarators >> addDeclarator: anObject [
	<generated>
	^ self declarators add: anObject
]

{ #category : 'accessing' }
FASTFortran2kTWithDeclarators >> declarators [
	"Relation named: #declarators type: #FASTFortran2kVariableDeclarator opposite: #parentDeclaration"

	<generated>
	<FMComment: 'variables declared'>
	<derived>
	^ declarators
]

{ #category : 'accessing' }
FASTFortran2kTWithDeclarators >> declarators: anObject [

	<generated>
	declarators value: anObject
]

{ #category : 'navigation' }
FASTFortran2kTWithDeclarators >> declaratorsGroup [
	<generated>
	<navigation: 'Declarators'>
	^ MooseSpecializedGroup withAll: self declarators asSet
]
