"
I am the super class of all Fortran statements

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `parentIfStatement` | `FASTFortran2kAbstractStatement` | `statement` | `FASTFortran2kIfLogicalStatement` | Parent if statement|
| `parentLoopStatement` | `FASTTStatement` | `body` | `FASTTLoopStatement` | Optional loop of which this statement is the body|
| `statementContainer` | `FASTTStatement` | `statements` | `FASTTStatementBlock` | Block containing this statement.|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `label` | `String` | nil | Determines the statement label which consists of 1 to 5 digits, with at least one nonzero|
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kAbstractStatement',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTStatement',
	#classTraits : 'FASTTStatement classTrait',
	#instVars : [
		'#label => FMProperty',
		'#parentIfStatement => FMOne type: #FASTFortran2kIfLogicalStatement opposite: #statement'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kAbstractStatement class >> annotation [

	<FMClass: #AbstractStatement super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kAbstractStatement >> label [

	<FMProperty: #label type: #String>
	<generated>
	<FMComment: 'Determines the statement label which consists of 1 to 5 digits, with at least one nonzero'>
	^ label
]

{ #category : 'accessing' }
FASTFortran2kAbstractStatement >> label: anObject [
	<generated>
	label := anObject
]

{ #category : 'accessing' }
FASTFortran2kAbstractStatement >> parentIfStatement [
	"Relation named: #parentIfStatement type: #FASTFortran2kIfLogicalStatement opposite: #statement"

	<generated>
	<FMComment: 'Parent if statement'>
	<container>
	<derived>
	^ parentIfStatement
]

{ #category : 'accessing' }
FASTFortran2kAbstractStatement >> parentIfStatement: anObject [

	<generated>
	parentIfStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kAbstractStatement >> parentIfStatementGroup [
	<generated>
	<navigation: 'ParentIfStatement'>
	^ MooseSpecializedGroup with: self parentIfStatement
]
