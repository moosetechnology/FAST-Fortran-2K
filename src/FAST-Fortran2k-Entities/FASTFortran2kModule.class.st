"
I represent a module

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `procedures` | `FASTFortran2kModule` | `module` | `FASTFortran2kTProcedure` | |



"
Class {
	#name : 'FASTFortran2kModule',
	#superclass : 'FASTFortran2kProgramUnit',
	#instVars : [
		'#procedures => FMMany type: #FASTFortran2kTProcedure opposite: #module'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kModule class >> annotation [

	<FMClass: #Module super: #FASTFortran2kProgramUnit>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kModule >> addProcedure: anObject [
	<generated>
	^ self procedures add: anObject
]

{ #category : 'accessing' }
FASTFortran2kModule >> procedures [
	"Relation named: #procedures type: #FASTFortran2kTProcedure opposite: #module"

	<generated>
	<derived>
	^ procedures
]

{ #category : 'accessing' }
FASTFortran2kModule >> procedures: anObject [

	<generated>
	procedures value: anObject
]

{ #category : 'navigation' }
FASTFortran2kModule >> proceduresGroup [
	<generated>
	<navigation: 'Procedures'>
	^ MooseSpecializedGroup withAll: self procedures asSet
]

{ #category : 'initialization' }
FASTFortran2kModule >> setOwner: aCollection [ 
	"nothing to do
	 Note: this is called from FASTFortranBehavioralTransformationVisitor >> #visitFASTFortranStatementBlock: "
]
