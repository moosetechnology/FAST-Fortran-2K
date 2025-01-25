"
I represent a statement with variable groups like a DataStatement or an EquivalenceStatement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `variableGroups` | `FASTFortran2kTWithVariableGroups` | `withVariableGroups` | `FASTFortran2kTVariableGroup` | |



"
Trait {
	#name : 'FASTFortran2kTWithVariableGroups',
	#instVars : [
		'#variableGroups => FMMany type: #FASTFortran2kTVariableGroup opposite: #withVariableGroups'
	],
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTWithVariableGroups classSide >> annotation [

	<FMClass: #TWithVariableGroups super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kTWithVariableGroups >> addVariableGroup: anObject [
	<generated>
	^ self variableGroups add: anObject
]

{ #category : 'accessing' }
FASTFortran2kTWithVariableGroups >> variableGroups [
	"Relation named: #variableGroups type: #FASTFortran2kTVariableGroup opposite: #withVariableGroups"

	<generated>
	<derived>
	^ variableGroups
]

{ #category : 'accessing' }
FASTFortran2kTWithVariableGroups >> variableGroups: anObject [

	<generated>
	variableGroups value: anObject
]

{ #category : 'navigation' }
FASTFortran2kTWithVariableGroups >> variableGroupsGroup [
	<generated>
	<navigation: 'VariableGroups'>
	^ MooseSpecializedGroup withAll: self variableGroups asSet
]
