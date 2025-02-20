"
I represent a internal procedure

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `declaredType` | `FASTFortran2kTDeclaredType` | `parentDeclaration` | `FASTFortran2kType` | type|



"
Class {
	#name : 'FASTFortran2kInternalFunction',
	#superclass : 'FASTFortran2kInternalProcedure',
	#traits : 'FASTFortran2kTDeclaredType',
	#classTraits : 'FASTFortran2kTDeclaredType classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kInternalFunction class >> annotation [

	<FMClass: #InternalFunction super: #FASTFortran2kInternalProcedure>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
