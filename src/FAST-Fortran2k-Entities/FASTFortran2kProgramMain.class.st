"
The PROGRAM statement identifies the program unit as a main program. program. For the loader, the main program is always named MAIN. The PROGRAM statement serves only the person who reads the program

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `internalProcedures` | `FASTFortran2kProgramMain` | `programMain` | `FASTFortran2kInternalProcedure` | |



"
Class {
	#name : 'FASTFortran2kProgramMain',
	#superclass : 'FASTFortran2kProgramUnit',
	#instVars : [
		'#internalProcedures => FMMany type: #FASTFortran2kInternalProcedure opposite: #programMain'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kProgramMain class >> annotation [

	<FMClass: #ProgramMain super: #FASTFortran2kProgramUnit>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kProgramMain >> addInternalProcedure: anObject [
	<generated>
	^ self internalProcedures add: anObject
]

{ #category : 'accessing' }
FASTFortran2kProgramMain >> internalProcedures [
	"Relation named: #internalProcedures type: #FASTFortran2kInternalProcedure opposite: #programMain"

	<generated>
	<derived>
	^ internalProcedures
]

{ #category : 'accessing' }
FASTFortran2kProgramMain >> internalProcedures: anObject [

	<generated>
	internalProcedures value: anObject
]

{ #category : 'navigation' }
FASTFortran2kProgramMain >> internalProceduresGroup [
	<generated>
	<navigation: 'InternalProcedures'>
	^ MooseSpecializedGroup withAll: self internalProcedures asSet
]
