"
I represent an access to object % field in derived type (therefore an expression)

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `field` | `FASTFortran2kDerivedTypeComponentAccess` | `fieldIn` | `FASTFortran2kVariable` | |
| `instance` | `FASTFortran2kDerivedTypeComponentAccess` | `instanceIn` | `FASTFortran2kVariable` | |



"
Class {
	#name : 'FASTFortran2kDerivedTypeComponentAccess',
	#superclass : 'FASTFortran2kVariable',
	#instVars : [
		'#field => FMOne type: #FASTFortran2kVariable opposite: #fieldIn',
		'#instance => FMOne type: #FASTFortran2kVariable opposite: #instanceIn'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kDerivedTypeComponentAccess class >> annotation [

	<FMClass: #DerivedTypeComponentAccess super: #FASTFortran2kVariable>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponentAccess >> field [
	"Relation named: #field type: #FASTFortran2kVariable opposite: #fieldIn"

	<generated>
	^ field
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponentAccess >> field: anObject [

	<generated>
	field := anObject
]

{ #category : 'navigation' }
FASTFortran2kDerivedTypeComponentAccess >> fieldGroup [
	<generated>
	<navigation: 'Field'>
	^ MooseSpecializedGroup with: self field
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponentAccess >> instance [
	"Relation named: #instance type: #FASTFortran2kVariable opposite: #instanceIn"

	<generated>
	^ instance
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponentAccess >> instance: anObject [

	<generated>
	instance := anObject
]

{ #category : 'navigation' }
FASTFortran2kDerivedTypeComponentAccess >> instanceGroup [
	<generated>
	<navigation: 'Instance'>
	^ MooseSpecializedGroup with: self instance
]
