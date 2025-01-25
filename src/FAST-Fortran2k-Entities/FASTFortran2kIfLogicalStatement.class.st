"
The logical IF statement executes one single statement, or does not execute it, depending on the value of a logical expression.

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `statement` | `FASTFortran2kIfLogicalStatement` | `parentIfStatement` | `FASTFortran2kAbstractStatement` | Statement of the logical if|



"
Class {
	#name : 'FASTFortran2kIfLogicalStatement',
	#superclass : 'FASTFortran2kConditionalStatement',
	#instVars : [
		'#statement => FMOne type: #FASTFortran2kAbstractStatement opposite: #parentIfStatement'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kIfLogicalStatement class >> annotation [

	<FMClass: #IfLogicalStatement super: #FASTFortran2kConditionalStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kIfLogicalStatement >> statement [
	"Relation named: #statement type: #FASTFortran2kAbstractStatement opposite: #parentIfStatement"

	<generated>
	<FMComment: 'Statement of the logical if'>
	^ statement
]

{ #category : 'accessing' }
FASTFortran2kIfLogicalStatement >> statement: anObject [

	<generated>
	statement := anObject
]

{ #category : 'navigation' }
FASTFortran2kIfLogicalStatement >> statementGroup [
	<generated>
	<navigation: 'Statement'>
	^ MooseSpecializedGroup with: self statement
]
