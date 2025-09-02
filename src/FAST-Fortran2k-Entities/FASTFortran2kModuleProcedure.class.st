"
I represent a module procedure

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `submodule` | `FASTFortran2kModuleProcedure` | `moduleProcedures` | `FASTFortran2kSubmodule` | |

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `parameters` | `FASTTWithParameters` | `parameterOwner` | `FASTTVariableEntity` | My parameters|
| `statementBlock` | `FASTTBehaviouralEntity` | `fastBehaviouralParent` | `FASTTStatementBlock` | Statements block of the behavioural entity|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kModuleProcedure',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTBehaviouralEntity + FASTTNamedEntity',
	#classTraits : 'FASTTBehaviouralEntity classTrait + FASTTNamedEntity classTrait',
	#instVars : [
		'#submodule => FMOne type: #FASTFortran2kSubmodule opposite: #moduleProcedures'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kModuleProcedure class >> annotation [

	<FMClass: #ModuleProcedure super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kModuleProcedure >> submodule [
	"Relation named: #submodule type: #FASTFortran2kSubmodule opposite: #moduleProcedures"

	<generated>
	<container>
	^ submodule
]

{ #category : 'accessing' }
FASTFortran2kModuleProcedure >> submodule: anObject [

	<generated>
	submodule := anObject
]

{ #category : 'navigation' }
FASTFortran2kModuleProcedure >> submoduleGroup [
	<generated>
	<navigation: 'Submodule'>
	^ MooseSpecializedGroup with: self submodule
]
