"
I represent a statement (various kind of goto) that can have label references

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `labelReferences` | `FASTFortran2kTWithLabelReferences` | `referencer` | `FASTFortran2kLabelReference` | the label(s) referenced|



"
Trait {
	#name : 'FASTFortran2kTWithLabelReferences',
	#instVars : [
		'#labelReferences => FMMany type: #FASTFortran2kLabelReference opposite: #referencer'
	],
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTWithLabelReferences classSide >> annotation [

	<FMClass: #TWithLabelReferences super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kTWithLabelReferences >> addLabelReference: anObject [
	<generated>
	^ self labelReferences add: anObject
]

{ #category : 'accessing' }
FASTFortran2kTWithLabelReferences >> labelReferences [
	"Relation named: #labelReferences type: #FASTFortran2kLabelReference opposite: #referencer"

	<generated>
	<FMComment: 'the label(s) referenced'>
	<derived>
	^ labelReferences
]

{ #category : 'accessing' }
FASTFortran2kTWithLabelReferences >> labelReferences: anObject [

	<generated>
	labelReferences value: anObject
]

{ #category : 'navigation' }
FASTFortran2kTWithLabelReferences >> labelReferencesGroup [
	<generated>
	<navigation: 'LabelReferences'>
	^ MooseSpecializedGroup withAll: self labelReferences asSet
]
