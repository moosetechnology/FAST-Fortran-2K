"
Part of a variable declaration: name of the variable + optional initial value

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `parentDeclaration` | `FASTFortran2kVariableDeclarator` | `declarators` | `FASTFortran2kTWithDeclarators` | |

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `dimensions` | `FASTFortran2kVariableDeclarator` | `parentVariableDeclarator` | `FASTFortran2kArrayRange` | Possible dimensions in case this is an array declaration|
| `expression` | `FASTFortran2kVariableDeclarator` | `variableDeclaratorOwner` | `FASTFortran2kAbstractExpression` | Expression assigned to the variable declared|
| `modifiers` | `FASTFortran2kTWithModifiers` | `modifierOwner` | `FASTFortran2kTModifier` | My modifiers|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kVariableDeclarator',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTFortran2kTWithModifiers + FASTTNamedEntity',
	#classTraits : 'FASTFortran2kTWithModifiers classTrait + FASTTNamedEntity classTrait',
	#instVars : [
		'#dimensions => FMMany type: #FASTFortran2kArrayRange opposite: #parentVariableDeclarator',
		'#expression => FMOne type: #FASTFortran2kAbstractExpression opposite: #variableDeclaratorOwner',
		'#parentDeclaration => FMOne type: #FASTFortran2kTWithDeclarators opposite: #declarators'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kVariableDeclarator class >> annotation [

	<FMClass: #VariableDeclarator super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'adding' }
FASTFortran2kVariableDeclarator >> addDimension: anObject [
	<generated>
	^ self dimensions add: anObject
]

{ #category : 'accessing' }
FASTFortran2kVariableDeclarator >> dimensions [
	"Relation named: #dimensions type: #FASTFortran2kArrayRange opposite: #parentVariableDeclarator"

	<generated>
	<FMComment: 'Possible dimensions in case this is an array declaration'>
	<derived>
	^ dimensions
]

{ #category : 'accessing' }
FASTFortran2kVariableDeclarator >> dimensions: anObject [

	<generated>
	dimensions value: anObject
]

{ #category : 'navigation' }
FASTFortran2kVariableDeclarator >> dimensionsGroup [
	<generated>
	<navigation: 'Dimensions'>
	^ MooseSpecializedGroup withAll: self dimensions asSet
]

{ #category : 'accessing' }
FASTFortran2kVariableDeclarator >> expression [
	"Relation named: #expression type: #FASTFortran2kAbstractExpression opposite: #variableDeclaratorOwner"

	<generated>
	<FMComment: 'Expression assigned to the variable declared'>
	^ expression
]

{ #category : 'accessing' }
FASTFortran2kVariableDeclarator >> expression: anObject [

	<generated>
	expression := anObject
]

{ #category : 'navigation' }
FASTFortran2kVariableDeclarator >> expressionGroup [
	<generated>
	<navigation: 'Expression'>
	^ MooseSpecializedGroup with: self expression
]

{ #category : 'accessing' }
FASTFortran2kVariableDeclarator >> parentDeclaration [
	"Relation named: #parentDeclaration type: #FASTFortran2kTWithDeclarators opposite: #declarators"

	<generated>
	<container>
	^ parentDeclaration
]

{ #category : 'accessing' }
FASTFortran2kVariableDeclarator >> parentDeclaration: anObject [

	<generated>
	parentDeclaration := anObject
]

{ #category : 'navigation' }
FASTFortran2kVariableDeclarator >> parentDeclarationGroup [
	<generated>
	<navigation: 'ParentDeclaration'>
	^ MooseSpecializedGroup with: self parentDeclaration
]
