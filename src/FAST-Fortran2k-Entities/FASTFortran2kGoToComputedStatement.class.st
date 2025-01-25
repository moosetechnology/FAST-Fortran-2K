"
I represent Fortran Go To (Computed) statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `labelReferences` | `FASTFortran2kTWithLabelReferences` | `referencer` | `FASTFortran2kLabelReference` | the label(s) referenced|
| `selectorExpression` | `FASTFortran2kGoToComputedStatement` | `parentGotoComputedStatement` | `FASTFortran2kAbstractExpression` | The expression which value selects the label to go to|



"
Class {
	#name : 'FASTFortran2kGoToComputedStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTFortran2kTWithLabelReferences',
	#classTraits : 'FASTFortran2kTWithLabelReferences classTrait',
	#instVars : [
		'#selectorExpression => FMOne type: #FASTFortran2kAbstractExpression opposite: #parentGotoComputedStatement'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kGoToComputedStatement class >> annotation [

	<FMClass: #GoToComputedStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kGoToComputedStatement >> selectorExpression [
	"Relation named: #selectorExpression type: #FASTFortran2kAbstractExpression opposite: #parentGotoComputedStatement"

	<generated>
	<FMComment: 'The expression which value selects the label to go to'>
	^ selectorExpression
]

{ #category : 'accessing' }
FASTFortran2kGoToComputedStatement >> selectorExpression: anObject [

	<generated>
	selectorExpression := anObject
]

{ #category : 'navigation' }
FASTFortran2kGoToComputedStatement >> selectorExpressionGroup [
	<generated>
	<navigation: 'SelectorExpression'>
	^ MooseSpecializedGroup with: self selectorExpression
]
