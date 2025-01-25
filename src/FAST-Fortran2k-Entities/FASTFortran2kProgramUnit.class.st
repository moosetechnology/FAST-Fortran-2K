"
A fortran program unit is a sequence of statements, terminated by an END statement. Every program unit is either a main program or a subprogram. If a program is to be executable, it must have a main program

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `parentProgramFile` | `FASTFortran2kProgramUnit` | `programUnit` | `FASTFortran2kProgramFile` | Parent program file|

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
	#name : 'FASTFortran2kProgramUnit',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTBehaviouralEntity + FASTTEntity + FASTTNamedEntity + FASTTWithComments',
	#classTraits : 'FASTTBehaviouralEntity classTrait + FASTTEntity classTrait + FASTTNamedEntity classTrait + FASTTWithComments classTrait',
	#instVars : [
		'#parentProgramFile => FMOne type: #FASTFortran2kProgramFile opposite: #programUnit'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kProgramUnit class >> annotation [

	<FMClass: #ProgramUnit super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kProgramUnit >> parentProgramFile [
	"Relation named: #parentProgramFile type: #FASTFortran2kProgramFile opposite: #programUnit"

	<generated>
	<FMComment: 'Parent program file'>
	<container>
	^ parentProgramFile
]

{ #category : 'accessing' }
FASTFortran2kProgramUnit >> parentProgramFile: anObject [

	<generated>
	parentProgramFile := anObject
]

{ #category : 'navigation' }
FASTFortran2kProgramUnit >> parentProgramFileGroup [
	<generated>
	<navigation: 'ParentProgramFile'>
	^ MooseSpecializedGroup with: self parentProgramFile
]
