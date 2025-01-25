"
I represent a group of variables in an Equivalence statement

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
	#name : 'FASTFortran2kEquivalenceGroup',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTFortran2kTVariableGroup',
	#classTraits : 'FASTFortran2kTVariableGroup classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kEquivalenceGroup class >> annotation [

	<FMClass: #EquivalenceGroup super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
