"
see [more](https://staff.cs.manchester.ac.uk/~fumie/internal/RikenDocuments/Fortran_Language_Reference_en.pdf#%5B%7B%22num%22%3A813%2C%22gen%22%3A0%7D%2C%7B%22name%22%3A%22XYZ%22%7D%2Cnull%2C700.94073%2Cnull%5D)

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `modifierOwner` | `FASTFortran2kTModifier` | `modifiers` | `FASTFortran2kTWithModifiers` | The owner of the modifier|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `token` | `String` | nil | The modifier value|

"
Class {
	#name : 'FASTFortran2kModifier',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTFortran2kTModifier',
	#classTraits : 'FASTFortran2kTModifier classTrait',
	#instVars : [
		'#token => FMProperty'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kModifier class >> annotation [

	<FMClass: #Modifier super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kModifier >> token [

	<FMProperty: #token type: #String>
	<generated>
	<FMComment: 'The modifier value'>
	^ token
]

{ #category : 'accessing' }
FASTFortran2kModifier >> token: anObject [
	<generated>
	token := anObject
]
