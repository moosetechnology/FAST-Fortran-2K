"
Parent program file

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `programFile` | `FASTFortran2kProgramUnit` | `programUnits` | `FASTFortran2kProgramFile` | |

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `comments` | `FASTTWithComments` | `container` | `FASTTComment` | list of comments defined in the entity|
| `declarations` | `FASTFortran2kTWithDeclarations` | `fortranDeclarationOwner` | `FASTFortran2kTDeclaration` | The elements I declare|
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
	#traits : 'FASTFortran2kTWithDeclarations + FASTTBehaviouralEntity + FASTTEntity + FASTTNamedEntity + FASTTWithComments',
	#classTraits : 'FASTFortran2kTWithDeclarations classTrait + FASTTBehaviouralEntity classTrait + FASTTEntity classTrait + FASTTNamedEntity classTrait + FASTTWithComments classTrait',
	#instVars : [
		'#programFile => FMOne type: #FASTFortran2kProgramFile opposite: #programUnits'
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
FASTFortran2kProgramUnit >> programFile [
	"Relation named: #programFile type: #FASTFortran2kProgramFile opposite: #programUnits"

	<generated>
	<container>
	^ programFile
]

{ #category : 'accessing' }
FASTFortran2kProgramUnit >> programFile: anObject [

	<generated>
	programFile := anObject
]

{ #category : 'navigation' }
FASTFortran2kProgramUnit >> programFileGroup [
	<generated>
	<navigation: 'ProgramFile'>
	^ MooseSpecializedGroup with: self programFile
]
