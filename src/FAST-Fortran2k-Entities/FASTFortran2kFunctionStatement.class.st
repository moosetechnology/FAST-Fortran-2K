"
I represent a function statement - a function-like declaration, made in a single statement

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `expression` | `FASTFortran2kFunctionStatement` | `assignementExpressionOwner` | `FASTFortran2kAbstractExpression` | Expression thats being assigned upon declaration to the var|
| `parameters` | `FASTTWithParameters` | `parameterOwner` | `FASTTVariableEntity` | My parameters|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kFunctionStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTTNamedEntity + FASTTWithParameters',
	#classTraits : 'FASTTNamedEntity classTrait + FASTTWithParameters classTrait',
	#instVars : [
		'#expression => FMOne type: #FASTFortran2kAbstractExpression opposite: #assignementExpressionOwner'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kFunctionStatement class >> annotation [

	<FMClass: #FunctionStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kFunctionStatement >> expression [
	"Relation named: #expression type: #FASTFortran2kAbstractExpression opposite: #assignementExpressionOwner"

	<generated>
	<FMComment: 'Expression thats being assigned upon declaration to the var'>
	^ expression
]

{ #category : 'accessing' }
FASTFortran2kFunctionStatement >> expression: anObject [

	<generated>
	expression := anObject
]

{ #category : 'navigation' }
FASTFortran2kFunctionStatement >> expressionGroup [
	<generated>
	<navigation: 'Expression'>
	^ MooseSpecializedGroup with: self expression
]
