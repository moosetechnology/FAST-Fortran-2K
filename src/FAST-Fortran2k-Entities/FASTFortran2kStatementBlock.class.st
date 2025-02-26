"
Contains the block of Fortran statements

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `fastBehaviouralParent` | `FASTTStatementBlock` | `statementBlock` | `FASTTBehaviouralEntity` | Behavioural entity containing the statement block.|
| `parentDoStatement` | `FASTFortran2kStatementBlock` | `statementBlock` | `FASTFortran2kDoStatement` | Parent do statement|
| `parentIfBlock` | `FASTFortran2kStatementBlock` | `elseStatementBlock` | `FASTFortran2kIfBlockStatement` | Parent if block|
| `parentIfBlock` | `FASTFortran2kStatementBlock` | `thenStatementBlock` | `FASTFortran2kIfBlockStatement` | Parent if block|
| `statementContainer` | `FASTTStatement` | `statements` | `FASTTStatementBlock` | Block containing this statement.|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `comments` | `FASTTWithComments` | `container` | `FASTTComment` | list of comments defined in the entity|
| `statements` | `FASTTStatementBlock` | `statementContainer` | `FASTTStatement` | Statements enclosed in this block|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kStatementBlock',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTStatementBlock + FASTTWithComments',
	#classTraits : 'FASTTStatementBlock classTrait + FASTTWithComments classTrait',
	#instVars : [
		'#parentDoStatement => FMOne type: #FASTFortran2kDoStatement opposite: #statementBlock',
		'#parentIfBlock => FMOne type: #FASTFortran2kIfBlockStatement opposite: #thenStatementBlock'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kStatementBlock class >> annotation [

	<FMClass: #StatementBlock super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kStatementBlock >> parentDoStatement [
	"Relation named: #parentDoStatement type: #FASTFortran2kDoStatement opposite: #statementBlock"

	<generated>
	<FMComment: 'Parent do statement'>
	<container>
	<derived>
	^ parentDoStatement
]

{ #category : 'accessing' }
FASTFortran2kStatementBlock >> parentDoStatement: anObject [

	<generated>
	parentDoStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kStatementBlock >> parentDoStatementGroup [
	<generated>
	<navigation: 'ParentDoStatement'>
	^ MooseSpecializedGroup with: self parentDoStatement
]

{ #category : 'accessing' }
FASTFortran2kStatementBlock >> parentIfBlock [
	"Relation named: #parentIfBlock type: #FASTFortran2kIfBlockStatement opposite: #thenStatementBlock"

	<generated>
	<FMComment: 'Parent if block'>
	<container>
	<derived>
	^ parentIfBlock
]

{ #category : 'accessing' }
FASTFortran2kStatementBlock >> parentIfBlock: anObject [

	<generated>
	parentIfBlock := anObject
]

{ #category : 'navigation' }
FASTFortran2kStatementBlock >> parentIfBlockGroup [
	<generated>
	<navigation: 'ParentIfBlock'>
	^ MooseSpecializedGroup with: self parentIfBlock
]
