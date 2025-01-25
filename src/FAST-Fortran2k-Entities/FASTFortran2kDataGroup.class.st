"
I represent a Fortran Data group in a Data statement

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `withVariableGroups` | `FASTFortran2kTVariableGroup` | `variableGroups` | `FASTFortran2kTWithVariableGroups` | |

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `dataConstants` | `FASTFortran2kDataGroup` | `parentDataStatement` | `FASTFortran2kAbstractExpression` | |
| `variables` | `FASTFortran2kTVariableGroup` | `parentVariableGroup` | `FASTFortran2kVariable` | |



"
Class {
	#name : 'FASTFortran2kDataGroup',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTFortran2kTVariableGroup',
	#classTraits : 'FASTFortran2kTVariableGroup classTrait',
	#instVars : [
		'#dataConstants => FMMany type: #FASTFortran2kAbstractExpression opposite: #parentDataStatement'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kDataGroup class >> annotation [

	<FMClass: #DataGroup super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kDataGroup >> addDataConstant: anObject [
	<generated>
	^ self dataConstants add: anObject
]

{ #category : 'accessing' }
FASTFortran2kDataGroup >> dataConstants [
	"Relation named: #dataConstants type: #FASTFortran2kAbstractExpression opposite: #parentDataStatement"

	<generated>
	<derived>
	^ dataConstants
]

{ #category : 'accessing' }
FASTFortran2kDataGroup >> dataConstants: anObject [

	<generated>
	dataConstants value: anObject
]

{ #category : 'navigation' }
FASTFortran2kDataGroup >> dataConstantsGroup [
	<generated>
	<navigation: 'DataConstants'>
	^ MooseSpecializedGroup withAll: self dataConstants asSet
]
