"
I represent a field (attribute, component,...) for a segment: either DerivedTypeComponent and DerivedTypeParameter

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `argumentOwner` | `FASTTExpression` | `arguments` | `FASTTWithArguments` | my owner|
| `assignedIn` | `FASTTExpression` | `expression` | `FASTTAssignment` | Optional assignment where this expression is used|
| `expressionStatementOwner` | `FASTTExpression` | `expression` | `FASTTExpressionStatement` | The expression statement that own me (if it's the case|
| `fieldOwner` | `FASTFortran2kDerivedTypeAbstractField` | `fields` | `FASTFortran2kDerivedTypeDefinition` | The owner of the field|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `ioSpecifier` | `FASTTExpression` | `expression` | `FASTFortran2kIOParameter` | name of the parameter (keyword argument)|
| `parentExpression` | `FASTTExpression` | `expression` | `FASTTUnaryExpression` | Parent (unary) expression|
| `parentExpressionLeft` | `FASTTExpression` | `leftOperand` | `FASTTBinaryExpression` | Parent (binary) expression of which I am left side|
| `parentExpressionRight` | `FASTTExpression` | `rightOperand` | `FASTTBinaryExpression` | Parent (binary) expression of which I am right side|
| `returnOwner` | `FASTTExpression` | `expression` | `FASTTReturnStatement` | The return statement that own the expression (if it's the case)|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `declaredType` | `FASTFortran2kTDeclaredType` | `parentDeclaration` | `FASTFortran2kType` | type|
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
	#name : 'FASTFortran2kDerivedTypeAbstractField',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTFortran2kTDeclaredType + FASTFortran2kTWithModifiers + FASTTExpression + FASTTNamedEntity',
	#classTraits : 'FASTFortran2kTDeclaredType classTrait + FASTFortran2kTWithModifiers classTrait + FASTTExpression classTrait + FASTTNamedEntity classTrait',
	#instVars : [
		'#fieldOwner => FMOne type: #FASTFortran2kDerivedTypeDefinition opposite: #fields'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kDerivedTypeAbstractField class >> annotation [

	<FMClass: #DerivedTypeAbstractField super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeAbstractField >> fieldOwner [
	"Relation named: #fieldOwner type: #FASTFortran2kDerivedTypeDefinition opposite: #fields"

	<generated>
	<FMComment: 'The owner of the field'>
	<container>
	^ fieldOwner
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeAbstractField >> fieldOwner: anObject [

	<generated>
	fieldOwner := anObject
]

{ #category : 'navigation' }
FASTFortran2kDerivedTypeAbstractField >> fieldOwnerGroup [
	<generated>
	<navigation: 'FieldOwner'>
	^ MooseSpecializedGroup with: self fieldOwner
]
