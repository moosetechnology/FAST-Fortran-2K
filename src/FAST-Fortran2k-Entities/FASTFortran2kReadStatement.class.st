"
I represent Fortran Read statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `arguments` | `FASTTWithArguments` | `argumentOwner` | `FASTTExpression` | My arguments|



"
Class {
	#name : 'FASTFortran2kReadStatement',
	#superclass : 'FASTFortran2kAbstractIOStatement',
	#traits : 'FASTTWithArguments',
	#classTraits : 'FASTTWithArguments classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kReadStatement class >> annotation [

	<FMClass: #ReadStatement super: #FASTFortran2kAbstractIOStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
