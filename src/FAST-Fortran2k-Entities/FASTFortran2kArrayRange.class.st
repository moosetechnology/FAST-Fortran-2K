"
I represent an array lower/upper bounds

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `parentVariableDeclarator` | `FASTFortran2kArrayRange` | `dimensions` | `FASTFortran2kVariableDeclarator` | The variable declarator I am part of|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `lowerBound` | `FASTFortran2kArrayRange` | `parentArrayDimensionDeclarator` | `FASTFortran2kAbstractExpression` | A lower bound of an array dimension|
| `upperBound` | `FASTFortran2kArrayRange` | `parentArrayDimensionDeclarator` | `FASTFortran2kAbstractExpression` | An upper bound of an array dimension|



"
Class {
	#name : 'FASTFortran2kArrayRange',
	#superclass : 'FASTFortran2kAbstractExpression',
	#instVars : [
		'#upperBound => FMOne type: #FASTFortran2kAbstractExpression opposite: #parentArrayDimensionDeclarator',
		'#lowerBound => FMOne type: #FASTFortran2kAbstractExpression opposite: #parentArrayDimensionDeclarator',
		'#parentVariableDeclarator => FMOne type: #FASTFortran2kVariableDeclarator opposite: #dimensions'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kArrayRange class >> annotation [

	<FMClass: #ArrayRange super: #FASTFortran2kAbstractExpression>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kArrayRange >> lowerBound [
	"Relation named: #lowerBound type: #FASTFortran2kAbstractExpression opposite: #parentArrayDimensionDeclarator"

	<generated>
	<FMComment: 'A lower bound of an array dimension'>
	^ lowerBound
]

{ #category : 'accessing' }
FASTFortran2kArrayRange >> lowerBound: anObject [

	<generated>
	lowerBound := anObject
]

{ #category : 'navigation' }
FASTFortran2kArrayRange >> lowerBoundGroup [
	<generated>
	<navigation: 'LowerBound'>
	^ MooseSpecializedGroup with: self lowerBound
]

{ #category : 'accessing' }
FASTFortran2kArrayRange >> parentVariableDeclarator [
	"Relation named: #parentVariableDeclarator type: #FASTFortran2kVariableDeclarator opposite: #dimensions"

	<generated>
	<FMComment: 'The variable declarator I am part of'>
	<container>
	^ parentVariableDeclarator
]

{ #category : 'accessing' }
FASTFortran2kArrayRange >> parentVariableDeclarator: anObject [

	<generated>
	parentVariableDeclarator := anObject
]

{ #category : 'navigation' }
FASTFortran2kArrayRange >> parentVariableDeclaratorGroup [
	<generated>
	<navigation: 'ParentVariableDeclarator'>
	^ MooseSpecializedGroup with: self parentVariableDeclarator
]

{ #category : 'accessing' }
FASTFortran2kArrayRange >> upperBound [
	"Relation named: #upperBound type: #FASTFortran2kAbstractExpression opposite: #parentArrayDimensionDeclarator"

	<generated>
	<FMComment: 'An upper bound of an array dimension'>
	^ upperBound
]

{ #category : 'accessing' }
FASTFortran2kArrayRange >> upperBound: anObject [

	<generated>
	upperBound := anObject
]

{ #category : 'navigation' }
FASTFortran2kArrayRange >> upperBoundGroup [
	<generated>
	<navigation: 'UpperBound'>
	^ MooseSpecializedGroup with: self upperBound
]
