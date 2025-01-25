"
I represent Fortran Print statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `arguments` | `FASTTWithArguments` | `argumentOwner` | `FASTTExpression` | My arguments|
| `format` | `FASTFortran2kTWithFormat` | `parentFormatedStatement` | `FASTFortran2kTFormat` | The description of the format|



"
Class {
	#name : 'FASTFortran2kPrintStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTFortran2kTWithFormat + FASTTWithArguments',
	#classTraits : 'FASTFortran2kTWithFormat classTrait + FASTTWithArguments classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kPrintStatement class >> annotation [

	<FMClass: #PrintStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
