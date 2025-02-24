"
TModifier

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `modifierOwner` | `FASTFortran2kTModifier` | `modifiers` | `FASTFortran2kTWithModifiers` | The owner of the modifier|



"
Trait {
	#name : 'FASTFortran2kTModifier',
	#instVars : [
		'#modifierOwner => FMOne type: #FASTFortran2kTWithModifiers opposite: #modifiers'
	],
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTModifier classSide >> annotation [

	<FMClass: #TModifier super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kTModifier >> modifierOwner [
	"Relation named: #modifierOwner type: #FASTFortran2kTWithModifiers opposite: #modifiers"

	<generated>
	<FMComment: 'The owner of the modifier'>
	<container>
	^ modifierOwner
]

{ #category : 'accessing' }
FASTFortran2kTModifier >> modifierOwner: anObject [

	<generated>
	modifierOwner := anObject
]

{ #category : 'navigation' }
FASTFortran2kTModifier >> modifierOwnerGroup [
	<generated>
	<navigation: 'ModifierOwner'>
	^ MooseSpecializedGroup with: self modifierOwner
]
