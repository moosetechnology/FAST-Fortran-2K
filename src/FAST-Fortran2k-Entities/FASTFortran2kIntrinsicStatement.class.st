"
I represent Fortran Intrinsic statement

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `withVariableGroups` | `FASTFortran2kTVariableGroup` | `variableGroups` | `FASTFortran2kTWithVariableGroups` | |

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `variables` | `FASTFortran2kTVariableGroup` | `parentVariableGroup` | `FASTFortran2kVariable` | |



"
Class {
	#name : 'FASTFortran2kIntrinsicStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTFortran2kTVariableGroup',
	#classTraits : 'FASTFortran2kTVariableGroup classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kIntrinsicStatement class >> annotation [

	<FMClass: #IntrinsicStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
