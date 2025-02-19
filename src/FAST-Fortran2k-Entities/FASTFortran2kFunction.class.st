"
I represent a Fortran Function

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `declaredType` | `FASTFortran2kTDeclaredType` | `parentDeclaration` | `FASTFortran2kType` | type|



"
Class {
	#name : 'FASTFortran2kFunction',
	#superclass : 'FASTFortran2kProcedure',
	#traits : 'FASTFortran2kTDeclaredType',
	#classTraits : 'FASTFortran2kTDeclaredType classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kFunction class >> annotation [

	<FMClass: #Function super: #FASTFortran2kProcedure>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
