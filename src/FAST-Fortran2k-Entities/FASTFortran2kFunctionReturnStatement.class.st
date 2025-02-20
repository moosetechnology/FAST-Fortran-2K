"
I represent a return (not related to return keyword) for a function

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `statementContainer` | `FASTTStatement` | `statements` | `FASTTStatementBlock` | Block containing this statement.|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `expression` | `FASTTReturnStatement` | `returnOwner` | `FASTTExpression` | The expression returned|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kFunctionReturnStatement',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTNamedEntity + FASTTReturnStatement',
	#classTraits : 'FASTTNamedEntity classTrait + FASTTReturnStatement classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kFunctionReturnStatement class >> annotation [

	<FMClass: #FunctionReturnStatement super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
