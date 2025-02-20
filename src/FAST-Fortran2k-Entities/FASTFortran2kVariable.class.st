"
an abstract Fortran Variable, could be an array or a scalar

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `entryStatement` | `FASTFortran2kTEntryArgument` | `entryArguments` | `FASTFortran2kEntryStatement` | |
| `fieldIn` | `FASTFortran2kVariable` | `field` | `FASTFortran2kDerivedTypeComponentAccess` | Parent DerivedTypeComponentAccess in which receiver is a field|
| `fieldIn` | `FASTFortran2kVariable` | `field` | `FASTFortran2kFieldAccess` | Parent FieldAccess in which receiver is a field|
| `instanceIn` | `FASTFortran2kVariable` | `instance` | `FASTFortran2kDerivedTypeComponentAccess` | Parent DerivedTypeComponentAccess in which receiver is a instance of derived type|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `parameterOwner` | `FASTTVariableEntity` | `parameters` | `FASTTWithParameters` | parameterOwner|
| `parentAssignmentExpression` | `FASTTVariableEntity` | `variable` | `FASTTAssignment` | Optional assignment to the variable|
| `parentFormatedStatement` | `FASTFortran2kTFormat` | `format` | `FASTFortran2kTWithFormat` | A format description in a Format/Print/Read/Write statement|
| `parentIOStatement` | `FASTFortran2kTIOParameter` | `ioParameters` | `FASTFortran2kAbstractIOStatement` | |
| `parentImpliedExpression` | `FASTTVariableEntity` | `variables` | `FASTFortran2kImpliedDoExpression` | |
| `parentVariableGroup` | `FASTFortran2kVariable` | `variables` | `FASTFortran2kTVariableGroup` | |
| `pointerIn` | `FASTFortran2kVariable` | `pointer` | `FASTFortran2kFieldAccess` | Parent FieldAccess in which receiver is a pointer|


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
		'#pointerIn => FMOne type: #FASTFortran2kFieldAccess opposite: #pointer',
		'#fieldIn => FMOne type: #FASTFortran2kFieldAccess opposite: #field',
		'#parentVariableGroup => FMOne type: #FASTFortran2kTVariableGroup opposite: #variables',
		'#instanceIn => FMOne type: #FASTFortran2kDerivedTypeComponentAccess opposite: #instance'
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
FASTFortran2kVariable >> fieldIn [
	"Relation named: #fieldIn type: #FASTFortran2kFieldAccess opposite: #field"

	<generated>
	<FMComment: 'Parent FieldAccess in which receiver is a field'>
	<container>
	<derived>
	^ fieldIn
]

{ #category : 'accessing' }
FASTFortran2kVariable >> fieldIn: anObject [

	<generated>
	fieldIn := anObject
]

{ #category : 'navigation' }
FASTFortran2kVariable >> fieldInGroup [
	<generated>
	<navigation: 'FieldIn'>
	^ MooseSpecializedGroup with: self fieldIn
]

{ #category : 'accessing' }
FASTFortran2kVariable >> instanceIn [
	"Relation named: #instanceIn type: #FASTFortran2kDerivedTypeComponentAccess opposite: #instance"

	<generated>
	<FMComment: 'Parent DerivedTypeComponentAccess in which receiver is a instance of derived type'>
	<container>
	<derived>
	^ instanceIn
]

{ #category : 'accessing' }
FASTFortran2kVariable >> instanceIn: anObject [

	<generated>
	instanceIn := anObject
]

{ #category : 'navigation' }
FASTFortran2kVariable >> instanceInGroup [
	<generated>
	<navigation: 'InstanceIn'>
	^ MooseSpecializedGroup with: self instanceIn
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

{ #category : 'accessing' }
FASTFortran2kVariable >> pointerIn [
	"Relation named: #pointerIn type: #FASTFortran2kFieldAccess opposite: #pointer"

	<generated>
	<FMComment: 'Parent FieldAccess in which receiver is a pointer'>
	<container>
	<derived>
	^ pointerIn
]

{ #category : 'accessing' }
FASTFortran2kVariable >> pointerIn: anObject [

	<generated>
	pointerIn := anObject
]

{ #category : 'navigation' }
FASTFortran2kVariable >> pointerInGroup [
	<generated>
	<navigation: 'PointerIn'>
	^ MooseSpecializedGroup with: self pointerIn
]
