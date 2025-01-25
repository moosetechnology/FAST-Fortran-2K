"
I represent Fortran Arithmetic Integer Literal (Constant)

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `parentFormatedStatement` | `FASTFortran2kTFormat` | `format` | `FASTFortran2kTWithFormat` | A format description in a Format/Print/Read/Write statement|
| `parentIOStatement` | `FASTFortran2kTIOParameter` | `ioParameters` | `FASTFortran2kAbstractIOStatement` | |



"
Class {
	#name : 'FASTFortran2kIntegerLiteral',
	#superclass : 'FASTFortran2kNumericalConstant',
	#traits : 'FASTFortran2kTFormat',
	#classTraits : 'FASTFortran2kTFormat classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kIntegerLiteral class >> annotation [

	<FMClass: #IntegerLiteral super: #FASTFortran2kNumericalConstant>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
