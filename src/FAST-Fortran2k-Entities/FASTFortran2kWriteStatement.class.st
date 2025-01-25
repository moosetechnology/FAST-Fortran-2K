"
I represent Fortran Write statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `arguments` | `FASTTWithArguments` | `argumentOwner` | `FASTTExpression` | My arguments|



"
Class {
	#name : 'FASTFortran2kWriteStatement',
	#superclass : 'FASTFortran2kAbstractIOStatement',
	#traits : 'FASTTWithArguments',
	#classTraits : 'FASTTWithArguments classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kWriteStatement class >> annotation [

	<FMClass: #WriteStatement super: #FASTFortran2kAbstractIOStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
