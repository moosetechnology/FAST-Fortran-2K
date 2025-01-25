"
An array Fortran Variable, accessed in the code

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `indices` | `FASTFortran2kArrayVariable` | `parentArrayExpression` | `FASTFortran2kAbstractExpression` | Indices used in the array access|



"
Class {
	#name : 'FASTFortran2kArrayVariable',
	#superclass : 'FASTFortran2kVariable',
	#instVars : [
		'#indices => FMMany type: #FASTFortran2kAbstractExpression opposite: #parentArrayExpression'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kArrayVariable class >> annotation [

	<FMClass: #ArrayVariable super: #FASTFortran2kVariable>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kArrayVariable >> addIndice: anObject [
	<generated>
	^ self indices add: anObject
]

{ #category : 'accessing' }
FASTFortran2kArrayVariable >> indices [
	"Relation named: #indices type: #FASTFortran2kAbstractExpression opposite: #parentArrayExpression"

	<generated>
	<FMComment: 'Indices used in the array access'>
	<derived>
	^ indices
]

{ #category : 'accessing' }
FASTFortran2kArrayVariable >> indices: anObject [

	<generated>
	indices value: anObject
]

{ #category : 'navigation' }
FASTFortran2kArrayVariable >> indicesGroup [
	<generated>
	<navigation: 'Indices'>
	^ MooseSpecializedGroup withAll: self indices asSet
]
