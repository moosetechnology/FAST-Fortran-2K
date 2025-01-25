"
I represent Fortran If (Arithmetic) statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `equalLabel` | `FASTFortran2kIfArithmeticStatement` | `parentIfArithmeticEqualBranch` | `FASTFortran2kLabelReference` | |
| `greaterLabel` | `FASTFortran2kIfArithmeticStatement` | `parentIfArithmeticMoreBranch` | `FASTFortran2kLabelReference` | |
| `lessLabel` | `FASTFortran2kIfArithmeticStatement` | `parentIfArithmeticLessBranch` | `FASTFortran2kLabelReference` | |



"
Class {
	#name : 'FASTFortran2kIfArithmeticStatement',
	#superclass : 'FASTFortran2kConditionalStatement',
	#instVars : [
		'#lessLabel => FMOne type: #FASTFortran2kLabelReference opposite: #parentIfArithmeticLessBranch',
		'#equalLabel => FMOne type: #FASTFortran2kLabelReference opposite: #parentIfArithmeticEqualBranch',
		'#greaterLabel => FMOne type: #FASTFortran2kLabelReference opposite: #parentIfArithmeticMoreBranch'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kIfArithmeticStatement class >> annotation [

	<FMClass: #IfArithmeticStatement super: #FASTFortran2kConditionalStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kIfArithmeticStatement >> equalLabel [
	"Relation named: #equalLabel type: #FASTFortran2kLabelReference opposite: #parentIfArithmeticEqualBranch"

	<generated>
	^ equalLabel
]

{ #category : 'accessing' }
FASTFortran2kIfArithmeticStatement >> equalLabel: anObject [

	<generated>
	equalLabel := anObject
]

{ #category : 'navigation' }
FASTFortran2kIfArithmeticStatement >> equalLabelGroup [
	<generated>
	<navigation: 'EqualLabel'>
	^ MooseSpecializedGroup with: self equalLabel
]

{ #category : 'accessing' }
FASTFortran2kIfArithmeticStatement >> greaterLabel [
	"Relation named: #greaterLabel type: #FASTFortran2kLabelReference opposite: #parentIfArithmeticMoreBranch"

	<generated>
	^ greaterLabel
]

{ #category : 'accessing' }
FASTFortran2kIfArithmeticStatement >> greaterLabel: anObject [

	<generated>
	greaterLabel := anObject
]

{ #category : 'navigation' }
FASTFortran2kIfArithmeticStatement >> greaterLabelGroup [
	<generated>
	<navigation: 'GreaterLabel'>
	^ MooseSpecializedGroup with: self greaterLabel
]

{ #category : 'accessing' }
FASTFortran2kIfArithmeticStatement >> lessLabel [
	"Relation named: #lessLabel type: #FASTFortran2kLabelReference opposite: #parentIfArithmeticLessBranch"

	<generated>
	^ lessLabel
]

{ #category : 'accessing' }
FASTFortran2kIfArithmeticStatement >> lessLabel: anObject [

	<generated>
	lessLabel := anObject
]

{ #category : 'navigation' }
FASTFortran2kIfArithmeticStatement >> lessLabelGroup [
	<generated>
	<navigation: 'LessLabel'>
	^ MooseSpecializedGroup with: self lessLabel
]
