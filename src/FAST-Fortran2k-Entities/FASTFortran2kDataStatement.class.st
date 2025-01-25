"
I represent a Fortran Data statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `variableGroups` | `FASTFortran2kTWithVariableGroups` | `withVariableGroups` | `FASTFortran2kTVariableGroup` | |



"
Class {
	#name : 'FASTFortran2kDataStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTFortran2kTWithVariableGroups',
	#classTraits : 'FASTFortran2kTWithVariableGroups classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kDataStatement class >> annotation [

	<FMClass: #DataStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
