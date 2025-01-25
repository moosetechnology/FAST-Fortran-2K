"
a Fortran Unary Expression (arithmetic, logical, character)

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `argumentOwner` | `FASTTExpression` | `arguments` | `FASTTWithArguments` | my owner|
| `assignedIn` | `FASTTExpression` | `expression` | `FASTTAssignment` | Optional assignment where this expression is used|
| `expressionStatementOwner` | `FASTTExpression` | `expression` | `FASTTExpressionStatement` | The expression statement that own me (if it's the case|
| `parentExpression` | `FASTTExpression` | `expression` | `FASTTUnaryExpression` | Parent (unary) expression|
| `parentExpressionLeft` | `FASTTExpression` | `leftOperand` | `FASTTBinaryExpression` | Parent (binary) expression of which I am left side|
| `parentExpressionRight` | `FASTTExpression` | `rightOperand` | `FASTTBinaryExpression` | Parent (binary) expression of which I am right side|
| `returnOwner` | `FASTTExpression` | `expression` | `FASTTReturnStatement` | The return statement that own the expression (if it's the case)|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `expression` | `FASTTUnaryExpression` | `parentExpression` | `FASTTExpression` | (sub-)expression in the unary expression|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `operator` | `String` | nil | Unary expression operator|
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kUnaryExpression',
	#superclass : 'FASTFortran2kAbstractExpression',
	#traits : 'FASTTUnaryExpression',
	#classTraits : 'FASTTUnaryExpression classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kUnaryExpression class >> annotation [

	<FMClass: #UnaryExpression super: #FASTFortran2kAbstractExpression>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
