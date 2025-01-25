"
I represent a fortran subroutine or a function

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `module` | `FASTFortran2kProcedure` | `procedures` | `FASTFortran2kModule` | |

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `internalProcedures` | `FASTFortran2kProcedure` | `procedure` | `FASTFortran2kInternalProcedure` | |
| `parameters` | `FASTTWithParameters` | `parameterOwner` | `FASTTVariableEntity` | My parameters|



"
Class {
	#name : 'FASTFortran2kProcedure',
	#superclass : 'FASTFortran2kSubprogram',
	#traits : 'FASTTWithParameters',
	#classTraits : 'FASTTWithParameters classTrait',
	#instVars : [
		'#internalProcedures => FMMany type: #FASTFortran2kInternalProcedure opposite: #procedure',
		'#module => FMOne type: #FASTFortran2kModule opposite: #procedures'
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

{ #category : 'accessing' }
FASTFortran2kProcedure >> module [
	"Relation named: #module type: #FASTFortran2kModule opposite: #procedures"

	<generated>
	<container>
	^ module
]

{ #category : 'accessing' }
FASTFortran2kProcedure >> module: anObject [

	<generated>
	module := anObject
]

{ #category : 'navigation' }
FASTFortran2kProcedure >> moduleGroup [
	<generated>
	<navigation: 'Module'>
	^ MooseSpecializedGroup with: self module
]
