"
I represent a reference to a Fortran label, like in a GoTo statement.
I contain the value of the label referred to

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `parentIfArithmeticEqualBranch` | `FASTFortran2kLabelReference` | `equalLabel` | `FASTFortran2kIfArithmeticStatement` | |
| `parentIfArithmeticLessBranch` | `FASTFortran2kLabelReference` | `lessLabel` | `FASTFortran2kIfArithmeticStatement` | |
| `parentIfArithmeticMoreBranch` | `FASTFortran2kLabelReference` | `greaterLabel` | `FASTFortran2kIfArithmeticStatement` | |
| `referencer` | `FASTFortran2kLabelReference` | `labelReferences` | `FASTFortran2kTWithLabelReferences` | A statement (like goto) referencing this label|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `label` | `String` | nil | The value of the label. The value is an integer literal, stored in a String|

"
Class {
	#name : 'FASTFortran2kLabelReference',
	#superclass : 'FASTFortran2kEntity',
	#instVars : [
		'#label => FMProperty',
		'#parentIfArithmeticLessBranch => FMOne type: #FASTFortran2kIfArithmeticStatement opposite: #lessLabel',
		'#parentIfArithmeticEqualBranch => FMOne type: #FASTFortran2kIfArithmeticStatement opposite: #equalLabel',
		'#parentIfArithmeticMoreBranch => FMOne type: #FASTFortran2kIfArithmeticStatement opposite: #greaterLabel',
		'#referencer => FMOne type: #FASTFortran2kTWithLabelReferences opposite: #labelReferences'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kLabelReference class >> annotation [

	<FMClass: #LabelReference super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kLabelReference >> label [

	<FMProperty: #label type: #String>
	<generated>
	<FMComment: 'The value of the label. The value is an integer literal, stored in a String'>
	^ label
]

{ #category : 'accessing' }
FASTFortran2kLabelReference >> label: anObject [
	<generated>
	label := anObject
]

{ #category : 'accessing' }
FASTFortran2kLabelReference >> parentIfArithmeticEqualBranch [
	"Relation named: #parentIfArithmeticEqualBranch type: #FASTFortran2kIfArithmeticStatement opposite: #equalLabel"

	<generated>
	<container>
	<derived>
	^ parentIfArithmeticEqualBranch
]

{ #category : 'accessing' }
FASTFortran2kLabelReference >> parentIfArithmeticEqualBranch: anObject [

	<generated>
	parentIfArithmeticEqualBranch := anObject
]

{ #category : 'navigation' }
FASTFortran2kLabelReference >> parentIfArithmeticEqualBranchGroup [
	<generated>
	<navigation: 'ParentIfArithmeticEqualBranch'>
	^ MooseSpecializedGroup with: self parentIfArithmeticEqualBranch
]

{ #category : 'accessing' }
FASTFortran2kLabelReference >> parentIfArithmeticLessBranch [
	"Relation named: #parentIfArithmeticLessBranch type: #FASTFortran2kIfArithmeticStatement opposite: #lessLabel"

	<generated>
	<container>
	<derived>
	^ parentIfArithmeticLessBranch
]

{ #category : 'accessing' }
FASTFortran2kLabelReference >> parentIfArithmeticLessBranch: anObject [

	<generated>
	parentIfArithmeticLessBranch := anObject
]

{ #category : 'navigation' }
FASTFortran2kLabelReference >> parentIfArithmeticLessBranchGroup [
	<generated>
	<navigation: 'ParentIfArithmeticLessBranch'>
	^ MooseSpecializedGroup with: self parentIfArithmeticLessBranch
]

{ #category : 'accessing' }
FASTFortran2kLabelReference >> parentIfArithmeticMoreBranch [
	"Relation named: #parentIfArithmeticMoreBranch type: #FASTFortran2kIfArithmeticStatement opposite: #greaterLabel"

	<generated>
	<container>
	<derived>
	^ parentIfArithmeticMoreBranch
]

{ #category : 'accessing' }
FASTFortran2kLabelReference >> parentIfArithmeticMoreBranch: anObject [

	<generated>
	parentIfArithmeticMoreBranch := anObject
]

{ #category : 'navigation' }
FASTFortran2kLabelReference >> parentIfArithmeticMoreBranchGroup [
	<generated>
	<navigation: 'ParentIfArithmeticMoreBranch'>
	^ MooseSpecializedGroup with: self parentIfArithmeticMoreBranch
]

{ #category : 'accessing' }
FASTFortran2kLabelReference >> referencer [
	"Relation named: #referencer type: #FASTFortran2kTWithLabelReferences opposite: #labelReferences"

	<generated>
	<FMComment: 'A statement (like goto) referencing this label'>
	<container>
	^ referencer
]

{ #category : 'accessing' }
FASTFortran2kLabelReference >> referencer: anObject [

	<generated>
	referencer := anObject
]

{ #category : 'navigation' }
FASTFortran2kLabelReference >> referencerGroup [
	<generated>
	<navigation: 'Referencer'>
	^ MooseSpecializedGroup with: self referencer
]
