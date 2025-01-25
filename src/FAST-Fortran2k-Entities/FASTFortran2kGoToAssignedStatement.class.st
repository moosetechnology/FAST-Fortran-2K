"
I represent Fortran Go To( Assigned) statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `labelReferences` | `FASTFortran2kTWithLabelReferences` | `referencer` | `FASTFortran2kLabelReference` | the label(s) referenced|
| `selectorExpression` | `FASTFortran2kGoToAssignedStatement` | `parentGotoAssignedStatement` | `FASTFortran2kAbstractExpression` | The expression which value selects the label to go to|



"
Class {
	#name : 'FASTFortran2kGoToAssignedStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTFortran2kTWithLabelReferences',
	#classTraits : 'FASTFortran2kTWithLabelReferences classTrait',
	#instVars : [
		'#selectorExpression => FMOne type: #FASTFortran2kAbstractExpression opposite: #parentGotoAssignedStatement'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kGoToAssignedStatement class >> annotation [

	<FMClass: #GoToAssignedStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kGoToAssignedStatement >> selectorExpression [
	"Relation named: #selectorExpression type: #FASTFortran2kAbstractExpression opposite: #parentGotoAssignedStatement"

	<generated>
	<FMComment: 'The expression which value selects the label to go to'>
	^ selectorExpression
]

{ #category : 'accessing' }
FASTFortran2kGoToAssignedStatement >> selectorExpression: anObject [

	<generated>
	selectorExpression := anObject
]

{ #category : 'navigation' }
FASTFortran2kGoToAssignedStatement >> selectorExpressionGroup [
	<generated>
	<navigation: 'SelectorExpression'>
	^ MooseSpecializedGroup with: self selectorExpression
]
