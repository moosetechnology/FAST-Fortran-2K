"
I represent a submodule

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `abstractStatements` | `FASTFortran2kSubmodule` | `submodule` | `FASTFortran2kAbstractStatement` | |
| `moduleProcedures` | `FASTFortran2kSubmodule` | `submodule` | `FASTFortran2kModuleProcedure` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `superModule` | `String` | nil | name of the module that Im implement|

"
Class {
	#name : 'FASTFortran2kSubmodule',
	#superclass : 'FASTFortran2kProgramUnit',
	#instVars : [
		'#superModule => FMProperty',
		'#abstractStatements => FMMany type: #FASTFortran2kAbstractStatement opposite: #submodule',
		'#moduleProcedures => FMMany type: #FASTFortran2kModuleProcedure opposite: #submodule'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kSubmodule class >> annotation [

	<FMClass: #Submodule super: #FASTFortran2kProgramUnit>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kSubmodule >> abstractStatements [
	"Relation named: #abstractStatements type: #FASTFortran2kAbstractStatement opposite: #submodule"

	<generated>
	<derived>
	^ abstractStatements
]

{ #category : 'accessing' }
FASTFortran2kSubmodule >> abstractStatements: anObject [

	<generated>
	abstractStatements value: anObject
]

{ #category : 'navigation' }
FASTFortran2kSubmodule >> abstractStatementsGroup [
	<generated>
	<navigation: 'AbstractStatements'>
	^ MooseSpecializedGroup withAll: self abstractStatements asSet
]

{ #category : 'adding' }
FASTFortran2kSubmodule >> addAbstractStatement: anObject [
	<generated>
	^ self abstractStatements add: anObject
]

{ #category : 'adding' }
FASTFortran2kSubmodule >> addModuleProcedure: anObject [
	<generated>
	^ self moduleProcedures add: anObject
]

{ #category : 'accessing' }
FASTFortran2kSubmodule >> moduleProcedures [
	"Relation named: #moduleProcedures type: #FASTFortran2kModuleProcedure opposite: #submodule"

	<generated>
	<derived>
	^ moduleProcedures
]

{ #category : 'accessing' }
FASTFortran2kSubmodule >> moduleProcedures: anObject [

	<generated>
	moduleProcedures value: anObject
]

{ #category : 'navigation' }
FASTFortran2kSubmodule >> moduleProceduresGroup [
	<generated>
	<navigation: 'ModuleProcedures'>
	^ MooseSpecializedGroup withAll: self moduleProcedures asSet
]

{ #category : 'accessing' }
FASTFortran2kSubmodule >> superModule [

	<FMProperty: #superModule type: #String>
	<generated>
	<FMComment: 'name of the module that Im implement'>
	^ superModule
]

{ #category : 'accessing' }
FASTFortran2kSubmodule >> superModule: anObject [
	<generated>
	superModule := anObject
]
