"
a Fortran Return Statement

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `statementContainer` | `FASTTStatement` | `statements` | `FASTTStatementBlock` | Block containing this statement.|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `expression` | `FASTTReturnStatement` | `returnOwner` | `FASTTExpression` | The expression returned|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `alternateReturnLabel` | `String` | nil | Optional. Expression of type INTEGER or REAL|
| `endPos` | `Number` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kReturnStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTTReturnStatement',
	#classTraits : 'FASTTReturnStatement classTrait',
	#instVars : [
		'#alternateReturnLabel => FMProperty'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kReturnStatement class >> annotation [

	<FMClass: #ReturnStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kReturnStatement >> alternateReturnLabel [

	<FMProperty: #alternateReturnLabel type: #String>
	<generated>
	<FMComment: 'Optional. Expression of type INTEGER or REAL'>
	^ alternateReturnLabel
]

{ #category : 'accessing' }
FASTFortran2kReturnStatement >> alternateReturnLabel: anObject [
	<generated>
	alternateReturnLabel := anObject
]
