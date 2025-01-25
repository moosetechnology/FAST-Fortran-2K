"
I represent a internal procedure

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `procedure` | `FASTFortran2kInternalProcedure` | `internalProcedures` | `FASTFortran2kProcedure` | |
| `programMain` | `FASTFortran2kInternalProcedure` | `internalProcedures` | `FASTFortran2kProgramMain` | |

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `comments` | `FASTTWithComments` | `container` | `FASTTComment` | list of comments defined in the entity|
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
	#name : 'FASTFortran2kInternalProcedure',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTBehaviouralEntity + FASTTEntity + FASTTNamedEntity + FASTTWithComments',
	#classTraits : 'FASTTBehaviouralEntity classTrait + FASTTEntity classTrait + FASTTNamedEntity classTrait + FASTTWithComments classTrait',
	#instVars : [
		'#procedure => FMOne type: #FASTFortran2kProcedure opposite: #internalProcedures',
		'#programMain => FMOne type: #FASTFortran2kProgramMain opposite: #internalProcedures'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kInternalProcedure class >> annotation [

	<FMClass: #InternalProcedure super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	<abstract>
	^ self
]

{ #category : 'testing' }
FASTFortran2kInternalProcedure class >> isAbstract [

	<generated>
	^ self == FASTFortran2kInternalProcedure
]

{ #category : 'accessing' }
FASTFortran2kInternalProcedure >> procedure [
	"Relation named: #procedure type: #FASTFortran2kProcedure opposite: #internalProcedures"

	<generated>
	<container>
	^ procedure
]

{ #category : 'accessing' }
FASTFortran2kInternalProcedure >> procedure: anObject [

	<generated>
	procedure := anObject
]

{ #category : 'navigation' }
FASTFortran2kInternalProcedure >> procedureGroup [
	<generated>
	<navigation: 'Procedure'>
	^ MooseSpecializedGroup with: self procedure
]

{ #category : 'accessing' }
FASTFortran2kInternalProcedure >> programMain [
	"Relation named: #programMain type: #FASTFortran2kProgramMain opposite: #internalProcedures"

	<generated>
	<container>
	^ programMain
]

{ #category : 'accessing' }
FASTFortran2kInternalProcedure >> programMain: anObject [

	<generated>
	programMain := anObject
]

{ #category : 'navigation' }
FASTFortran2kInternalProcedure >> programMainGroup [
	<generated>
	<navigation: 'ProgramMain'>
	^ MooseSpecializedGroup with: self programMain
]
