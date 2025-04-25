"
I represent Fortran Do While statement

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `parentLoopStatement` | `FASTTStatement` | `body` | `FASTTLoopStatement` | Optional loop of which this statement is the body|
| `statementContainer` | `FASTTStatement` | `statements` | `FASTTStatementBlock` | Block containing this statement.|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `body` | `FASTTLoopStatement` | `parentLoopStatement` | `FASTTStatement` | The body of the loop|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kDoWhileStatement',
	#superclass : 'FASTFortran2kConditionalStatement',
	#traits : 'FASTTLoopStatement',
	#classTraits : 'FASTTLoopStatement classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kDoWhileStatement class >> annotation [

	<FMClass: #DoWhileStatement super: #FASTFortran2kConditionalStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
