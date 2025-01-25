"
I represent Fortran Go To (unconditional) statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `labelReferences` | `FASTFortran2kTWithLabelReferences` | `referencer` | `FASTFortran2kLabelReference` | the label(s) referenced|



"
Class {
	#name : 'FASTFortran2kGoToStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTFortran2kTWithLabelReferences',
	#classTraits : 'FASTFortran2kTWithLabelReferences classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kGoToStatement class >> annotation [

	<FMClass: #GoToStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
