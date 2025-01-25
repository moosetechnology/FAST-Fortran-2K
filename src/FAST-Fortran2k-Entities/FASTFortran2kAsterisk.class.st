"
I represent an Asterisk Character Literal (Constant) that is often used as a format identifier

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `entryStatement` | `FASTFortran2kTEntryArgument` | `entryArguments` | `FASTFortran2kEntryStatement` | |
| `parentFormatedStatement` | `FASTFortran2kTFormat` | `format` | `FASTFortran2kTWithFormat` | A format description in a Format/Print/Read/Write statement|
| `parentIOStatement` | `FASTFortran2kTIOParameter` | `ioParameters` | `FASTFortran2kAbstractIOStatement` | |



"
Class {
	#name : 'FASTFortran2kAsterisk',
	#superclass : 'FASTFortran2kIntegerLiteral',
	#traits : 'FASTFortran2kTEntryArgument + FASTFortran2kTFormat',
	#classTraits : 'FASTFortran2kTEntryArgument classTrait + FASTFortran2kTFormat classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kAsterisk class >> annotation [

	<FMClass: #Asterisk super: #FASTFortran2kIntegerLiteral>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
