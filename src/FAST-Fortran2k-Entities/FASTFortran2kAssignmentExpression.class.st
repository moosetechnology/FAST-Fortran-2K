"
I represent an assignment expression as a part of assignment statement

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
| `parentIOStatement` | `FASTFortran2kTIOParameter` | `ioParameters` | `FASTFortran2kAbstractIOStatement` | |
| `parentLoopControlInitialization` | `FASTFortran2kAssignmentExpression` | `init` | `FASTFortran2kLoopControlExpression` | |
| `returnOwner` | `FASTTExpression` | `expression` | `FASTTReturnStatement` | The return statement that own the expression (if it's the case)|

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `expression` | `FASTTAssignment` | `assignedIn` | `FASTTExpression` | Assigned expression (rhs of assignment)|
| `variable` | `FASTTAssignment` | `parentAssignmentExpression` | `FASTTVariableEntity` | An assigned variable (lhs of assignment)|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kAssignmentExpression',
	#superclass : 'FASTFortran2kAbstractExpression',
	#traits : 'FASTFortran2kTIOParameter + FASTTAssignment',
	#classTraits : 'FASTFortran2kTIOParameter classTrait + FASTTAssignment classTrait',
	#instVars : [
		'#parentLoopControlInitialization => FMOne type: #FASTFortran2kLoopControlExpression opposite: #init'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kAssignmentExpression class >> annotation [

	<FMClass: #AssignmentExpression super: #FASTFortran2kAbstractExpression>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kAssignmentExpression >> parentLoopControlInitialization [
	"Relation named: #parentLoopControlInitialization type: #FASTFortran2kLoopControlExpression opposite: #init"

	<generated>
	<container>
	<derived>
	^ parentLoopControlInitialization
]

{ #category : 'accessing' }
FASTFortran2kAssignmentExpression >> parentLoopControlInitialization: anObject [

	<generated>
	parentLoopControlInitialization := anObject
]

{ #category : 'navigation' }
FASTFortran2kAssignmentExpression >> parentLoopControlInitializationGroup [
	<generated>
	<navigation: 'ParentLoopControlInitialization'>
	^ MooseSpecializedGroup with: self parentLoopControlInitialization
]
