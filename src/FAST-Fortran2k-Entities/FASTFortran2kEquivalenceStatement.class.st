"
I represent a Fortran Equivalence statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `variableGroups` | `FASTFortran2kTWithVariableGroups` | `withVariableGroups` | `FASTFortran2kTVariableGroup` | |



"
Class {
	#name : 'FASTFortran2kEquivalenceStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTFortran2kTWithVariableGroups',
	#classTraits : 'FASTFortran2kTWithVariableGroups classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kEquivalenceStatement class >> annotation [

	<FMClass: #EquivalenceStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
