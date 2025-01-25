"
I represent a fortran statement with a condition: if-block, if-logical

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `condition` | `FASTFortran2kConditionalStatement` | `parentConditionalStatement` | `FASTFortran2kAbstractExpression` | Condition|



"
Class {
	#name : 'FASTFortran2kConditionalStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#instVars : [
		'#condition => FMOne type: #FASTFortran2kAbstractExpression opposite: #parentConditionalStatement'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kConditionalStatement class >> annotation [

	<FMClass: #ConditionalStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kConditionalStatement >> condition [
	"Relation named: #condition type: #FASTFortran2kAbstractExpression opposite: #parentConditionalStatement"

	<generated>
	<FMComment: 'Condition'>
	^ condition
]

{ #category : 'accessing' }
FASTFortran2kConditionalStatement >> condition: anObject [

	<generated>
	condition := anObject
]

{ #category : 'navigation' }
FASTFortran2kConditionalStatement >> conditionGroup [
	<generated>
	<navigation: 'Condition'>
	^ MooseSpecializedGroup with: self condition
]
