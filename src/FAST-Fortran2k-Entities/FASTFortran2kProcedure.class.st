"
I represent a fortran subroutine or a function

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `module` | `FASTFortran2kTProcedure` | `procedures` | `FASTFortran2kModule` | |

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `internalProcedures` | `FASTFortran2kProcedure` | `procedure` | `FASTFortran2kInternalProcedure` | |
| `parameters` | `FASTTWithParameters` | `parameterOwner` | `FASTTVariableEntity` | My parameters|



"
Class {
	#name : 'FASTFortran2kProcedure',
	#superclass : 'FASTFortran2kSubprogram',
	#traits : 'FASTFortran2kTProcedure + FASTTWithParameters',
	#classTraits : 'FASTFortran2kTProcedure classTrait + FASTTWithParameters classTrait',
	#instVars : [
		'#internalProcedures => FMMany type: #FASTFortran2kInternalProcedure opposite: #procedure'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kProcedure class >> annotation [

	<FMClass: #Procedure super: #FASTFortran2kSubprogram>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kProcedure >> addInternalProcedure: anObject [
	<generated>
	^ self internalProcedures add: anObject
]

{ #category : 'accessing' }
FASTFortran2kProcedure >> internalProcedures [
	"Relation named: #internalProcedures type: #FASTFortran2kInternalProcedure opposite: #procedure"

	<generated>
	<derived>
	^ internalProcedures
]

{ #category : 'accessing' }
FASTFortran2kProcedure >> internalProcedures: anObject [

	<generated>
	internalProcedures value: anObject
]

{ #category : 'navigation' }
FASTFortran2kProcedure >> internalProceduresGroup [
	<generated>
	<navigation: 'InternalProcedures'>
	^ MooseSpecializedGroup withAll: self internalProcedures asSet
]
