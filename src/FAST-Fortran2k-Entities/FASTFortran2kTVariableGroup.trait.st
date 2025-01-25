"
I represent an entity with several variables like in a DataStatement or an EquivalenceStatement

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `withVariableGroups` | `FASTFortran2kTVariableGroup` | `variableGroups` | `FASTFortran2kTWithVariableGroups` | |

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `variables` | `FASTFortran2kTVariableGroup` | `parentVariableGroup` | `FASTFortran2kVariable` | |



"
Trait {
	#name : 'FASTFortran2kTVariableGroup',
	#instVars : [
		'#variables => FMMany type: #FASTFortran2kVariable opposite: #parentVariableGroup',
		'#withVariableGroups => FMOne type: #FASTFortran2kTWithVariableGroups opposite: #variableGroups'
	],
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTVariableGroup classSide >> annotation [

	<FMClass: #TVariableGroup super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kTVariableGroup >> addVariable: anObject [
	<generated>
	^ self variables add: anObject
]

{ #category : 'accessing' }
FASTFortran2kTVariableGroup >> variables [
	"Relation named: #variables type: #FASTFortran2kVariable opposite: #parentVariableGroup"

	<generated>
	<derived>
	^ variables
]

{ #category : 'accessing' }
FASTFortran2kTVariableGroup >> variables: anObject [

	<generated>
	variables value: anObject
]

{ #category : 'navigation' }
FASTFortran2kTVariableGroup >> variablesGroup [
	<generated>
	<navigation: 'Variables'>
	^ MooseSpecializedGroup withAll: self variables asSet
]

{ #category : 'accessing' }
FASTFortran2kTVariableGroup >> withVariableGroups [
	"Relation named: #withVariableGroups type: #FASTFortran2kTWithVariableGroups opposite: #variableGroups"

	<generated>
	<container>
	^ withVariableGroups
]

{ #category : 'accessing' }
FASTFortran2kTVariableGroup >> withVariableGroups: anObject [

	<generated>
	withVariableGroups := anObject
]

{ #category : 'navigation' }
FASTFortran2kTVariableGroup >> withVariableGroupsGroup [
	<generated>
	<navigation: 'WithVariableGroups'>
	^ MooseSpecializedGroup with: self withVariableGroups
]
