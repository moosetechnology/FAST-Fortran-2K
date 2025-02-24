"
TWithModifiers

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `modifiers` | `FASTFortran2kTWithModifiers` | `modifierOwner` | `FASTFortran2kTModifier` | My modifiers|



"
Trait {
	#name : 'FASTFortran2kTWithModifiers',
	#instVars : [
		'#modifiers => FMMany type: #FASTFortran2kTModifier opposite: #modifierOwner'
	],
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTWithModifiers classSide >> annotation [

	<FMClass: #TWithModifiers super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kTWithModifiers >> addModifier: anObject [
	<generated>
	^ self modifiers add: anObject
]

{ #category : 'accessing' }
FASTFortran2kTWithModifiers >> modifiers [
	"Relation named: #modifiers type: #FASTFortran2kTModifier opposite: #modifierOwner"

	<generated>
	<FMComment: 'My modifiers'>
	<derived>
	^ modifiers
]

{ #category : 'accessing' }
FASTFortran2kTWithModifiers >> modifiers: anObject [

	<generated>
	modifiers value: anObject
]

{ #category : 'navigation' }
FASTFortran2kTWithModifiers >> modifiersGroup [
	<generated>
	<navigation: 'Modifiers'>
	^ MooseSpecializedGroup withAll: self modifiers asSet
]
