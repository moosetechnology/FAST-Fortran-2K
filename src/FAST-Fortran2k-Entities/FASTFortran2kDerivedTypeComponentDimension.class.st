"
## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `argumentOwner` | `FASTTExpression` | `arguments` | `FASTTWithArguments` | my owner|
| `assignedIn` | `FASTTExpression` | `expression` | `FASTTAssignment` | Optional assignment where this expression is used|
| `dimensionOwner` | `FASTFortran2kDerivedTypeComponentDimension` | `dimensions` | `FASTFortran2kDerivedTypeComponent` | The owner of the dimension|
| `expressionStatementOwner` | `FASTTExpression` | `expression` | `FASTTExpressionStatement` | The expression statement that own me (if it's the case|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `ioSpecifier` | `FASTTExpression` | `expression` | `FASTFortran2kIOParameter` | name of the parameter (keyword argument)|
| `parentExpression` | `FASTTExpression` | `expression` | `FASTTUnaryExpression` | Parent (unary) expression|
| `parentExpressionLeft` | `FASTTExpression` | `leftOperand` | `FASTTBinaryExpression` | Parent (binary) expression of which I am left side|
| `parentExpressionRight` | `FASTTExpression` | `rightOperand` | `FASTTBinaryExpression` | Parent (binary) expression of which I am right side|
| `returnOwner` | `FASTTExpression` | `expression` | `FASTTReturnStatement` | The return statement that own the expression (if it's the case)|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kDerivedTypeComponentDimension',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTExpression + FASTTNamedEntity',
	#classTraits : 'FASTTExpression classTrait + FASTTNamedEntity classTrait',
	#instVars : [
		'#dimensionOwner => FMOne type: #FASTFortran2kDerivedTypeComponent opposite: #dimensions'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kDerivedTypeComponentDimension class >> annotation [

	<FMClass: #DerivedTypeComponentDimension super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponentDimension >> dimensionOwner [
	"Relation named: #dimensionOwner type: #FASTFortran2kDerivedTypeComponent opposite: #dimensions"

	<generated>
	<FMComment: 'The owner of the dimension'>
	<container>
	^ dimensionOwner
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponentDimension >> dimensionOwner: anObject [

	<generated>
	dimensionOwner := anObject
]

{ #category : 'navigation' }
FASTFortran2kDerivedTypeComponentDimension >> dimensionOwnerGroup [
	<generated>
	<navigation: 'DimensionOwner'>
	^ MooseSpecializedGroup with: self dimensionOwner
]
