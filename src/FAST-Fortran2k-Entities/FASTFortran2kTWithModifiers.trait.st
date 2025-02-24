"
TWithModifiers

## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `modifiers` | `Object` | #() | A collection of modifiers (strings)|

"
Trait {
	#name : 'FASTFortran2kTWithModifiers',
	#instVars : [
		'#modifiers => FMProperty defaultValue: #()'
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

{ #category : 'accessing' }
FASTFortran2kTWithModifiers >> modifiers [

	<FMProperty: #modifiers type: #Object defaultValue: #()>
	<generated>
	<FMComment: 'A collection of modifiers (strings)'>
	^ modifiers ifNil: [ modifiers := #() ]
]

{ #category : 'accessing' }
FASTFortran2kTWithModifiers >> modifiers: anObject [
	<generated>
	modifiers := anObject
]
