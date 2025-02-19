"
self commentForTPointerAssignment

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `argumentOwner` | `FASTTExpression` | `arguments` | `FASTTWithArguments` | my owner|
| `assignedIn` | `FASTTExpression` | `expression` | `FASTTAssignment` | Optional assignment where this expression is used|
| `expressionStatementOwner` | `FASTTExpression` | `expression` | `FASTTExpressionStatement` | The expression statement that own me (if it's the case|
| `ioSpecifier` | `FASTTExpression` | `expression` | `FASTFortran2kIOParameter` | name of the parameter (keyword argument)|
| `parentExpression` | `FASTTExpression` | `expression` | `FASTTUnaryExpression` | Parent (unary) expression|
| `parentExpressionLeft` | `FASTTExpression` | `leftOperand` | `FASTTBinaryExpression` | Parent (binary) expression of which I am left side|
| `parentExpressionRight` | `FASTTExpression` | `rightOperand` | `FASTTBinaryExpression` | Parent (binary) expression of which I am right side|
| `returnOwner` | `FASTTExpression` | `expression` | `FASTTReturnStatement` | The return statement that own the expression (if it's the case)|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `expression` | `FASTFortran2kTPointerAssignment` | `assignedIn` | `FASTFortran2kPTVariable` | Assigned expression (rhs of assignment)|
| `variable` | `FASTFortran2kTPointerAssignment` | `parentAssignmentExpression` | `FASTFortran2kPointerVariable` | An assigned variable (lhs of assignment)|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `startPos` | `Number` | nil | |

"
Trait {
	#name : 'FASTFortran2kTPointerAssignment',
	#instVars : [
		'#variable => FMOne type: #FASTFortran2kPointerVariable opposite: #parentAssignmentExpression',
		'#expression => FMOne type: #FASTFortran2kPTVariable opposite: #assignedIn'
	],
	#traits : 'FASTTExpression',
	#classTraits : 'FASTTExpression classTrait',
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTPointerAssignment classSide >> annotation [

	<FMClass: #TPointerAssignment super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kTPointerAssignment >> expression [
	"Relation named: #expression type: #FASTFortran2kPTVariable opposite: #assignedIn"

	<generated>
	<FMComment: 'Assigned expression (rhs of assignment)'>
	^ expression
]

{ #category : 'accessing' }
FASTFortran2kTPointerAssignment >> expression: anObject [

	<generated>
	expression := anObject
]

{ #category : 'navigation' }
FASTFortran2kTPointerAssignment >> expressionGroup [
	<generated>
	<navigation: 'Expression'>
	^ MooseSpecializedGroup with: self expression
]

{ #category : 'accessing' }
FASTFortran2kTPointerAssignment >> variable [
	"Relation named: #variable type: #FASTFortran2kPointerVariable opposite: #parentAssignmentExpression"

	<generated>
	<FMComment: 'An assigned variable (lhs of assignment)'>
	^ variable
]

{ #category : 'accessing' }
FASTFortran2kTPointerAssignment >> variable: anObject [

	<generated>
	variable := anObject
]

{ #category : 'navigation' }
FASTFortran2kTPointerAssignment >> variableGroup [
	<generated>
	<navigation: 'Variable'>
	^ MooseSpecializedGroup with: self variable
]
