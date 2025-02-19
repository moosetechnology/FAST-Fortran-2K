"
I have declarations

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `declarations` | `FASTFortran2kTWithDeclarations` | `fortranDeclarationOwner` | `FASTFortran2kTDeclaration` | The elements I declare|



"
Trait {
	#name : 'FASTFortran2kTWithDeclarations',
	#instVars : [
		'#declarations => FMMany type: #FASTFortran2kTDeclaration opposite: #fortranDeclarationOwner'
	],
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTWithDeclarations classSide >> annotation [

	<FMClass: #TWithDeclarations super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kTWithDeclarations >> addDeclaration: anObject [
	<generated>
	^ self declarations add: anObject
]

{ #category : 'accessing' }
FASTFortran2kTWithDeclarations >> declarations [
	"Relation named: #declarations type: #FASTFortran2kTDeclaration opposite: #fortranDeclarationOwner"

	<generated>
	<FMComment: 'The elements I declare'>
	<derived>
	^ declarations
]

{ #category : 'accessing' }
FASTFortran2kTWithDeclarations >> declarations: anObject [

	<generated>
	declarations value: anObject
]

{ #category : 'navigation' }
FASTFortran2kTWithDeclarations >> declarationsGroup [
	<generated>
	<navigation: 'Declarations'>
	^ MooseSpecializedGroup withAll: self declarations asSet
]
