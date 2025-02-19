"
I represent an access to pointer.field in Esope (therefore an expression)

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `field` | `FASTFortran2kFieldAccess` | `fieldIn` | `FASTFortran2kVariable` | |
| `pointer` | `FASTFortran2kFieldAccess` | `pointerIn` | `FASTFortran2kVariable` | |



"
Class {
	#name : 'FASTFortran2kFieldAccess',
	#superclass : 'FASTFortran2kVariable',
	#instVars : [
		'#pointer => FMOne type: #FASTFortran2kVariable opposite: #pointerIn',
		'#field => FMOne type: #FASTFortran2kVariable opposite: #fieldIn'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kFieldAccess class >> annotation [

	<FMClass: #FieldAccess super: #FASTFortran2kVariable>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kFieldAccess >> field [
	"Relation named: #field type: #FASTFortran2kVariable opposite: #fieldIn"

	<generated>
	^ field
]

{ #category : 'accessing' }
FASTFortran2kFieldAccess >> field: anObject [

	<generated>
	field := anObject
]

{ #category : 'navigation' }
FASTFortran2kFieldAccess >> fieldGroup [
	<generated>
	<navigation: 'Field'>
	^ MooseSpecializedGroup with: self field
]

{ #category : 'accessing' }
FASTFortran2kFieldAccess >> pointer [
	"Relation named: #pointer type: #FASTFortran2kVariable opposite: #pointerIn"

	<generated>
	^ pointer
]

{ #category : 'accessing' }
FASTFortran2kFieldAccess >> pointer: anObject [

	<generated>
	pointer := anObject
]

{ #category : 'navigation' }
FASTFortran2kFieldAccess >> pointerGroup [
	<generated>
	<navigation: 'Pointer'>
	^ MooseSpecializedGroup with: self pointer
]
