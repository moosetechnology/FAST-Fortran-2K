"
an abstract Fortran Variable, could be an array or a scalar

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `entryStatement` | `FASTFortran2kTEntryArgument` | `entryArguments` | `FASTFortran2kEntryStatement` | |
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `parameterOwner` | `FASTTVariableEntity` | `parameters` | `FASTTWithParameters` | parameterOwner|
| `parentAssignmentExpression` | `FASTTVariableEntity` | `variable` | `FASTTAssignment` | Optional assignment to the variable|
| `parentFormatedStatement` | `FASTFortran2kTFormat` | `format` | `FASTFortran2kTWithFormat` | A format description in a Format/Print/Read/Write statement|
| `parentIOStatement` | `FASTFortran2kTIOParameter` | `ioParameters` | `FASTFortran2kAbstractIOStatement` | |
| `parentImpliedExpression` | `FASTTVariableEntity` | `variables` | `FASTFortran2kImpliedDoExpression` | |
| `parentVariableGroup` | `FASTFortran2kVariable` | `variables` | `FASTFortran2kTVariableGroup` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kVariable',
	#superclass : 'FASTFortran2kAbstractExpression',
	#traits : 'FASTFortran2kTEntryArgument + FASTFortran2kTFormat + FASTTVariableEntity',
	#classTraits : 'FASTFortran2kTEntryArgument classTrait + FASTFortran2kTFormat classTrait + FASTTVariableEntity classTrait',
	#instVars : [
		'#parentVariableGroup => FMOne type: #FASTFortran2kTVariableGroup opposite: #variables'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kVariable class >> annotation [

	<FMClass: #Variable super: #FASTFortran2kAbstractExpression>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kVariable >> parentVariableGroup [
	"Relation named: #parentVariableGroup type: #FASTFortran2kTVariableGroup opposite: #variables"

	<generated>
	<container>
	^ parentVariableGroup
]

{ #category : 'accessing' }
FASTFortran2kVariable >> parentVariableGroup: anObject [

	<generated>
	parentVariableGroup := anObject
]

{ #category : 'navigation' }
FASTFortran2kVariable >> parentVariableGroupGroup [
	<generated>
	<navigation: 'ParentVariableGroup'>
	^ MooseSpecializedGroup with: self parentVariableGroup
]
