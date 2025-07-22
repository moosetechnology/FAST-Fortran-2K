"
I am the super class of all Fortran expressions

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `argumentOwner` | `FASTTExpression` | `arguments` | `FASTTWithArguments` | my owner|
| `assignedIn` | `FASTTExpression` | `expression` | `FASTTAssignment` | Optional assignment where this expression is used|
| `assignementExpressionOwner` | `FASTFortran2kAbstractExpression` | `expression` | `FASTFortran2kFunctionStatement` | The AssignementExpression owner (if possible)|
| `expressionStatementOwner` | `FASTTExpression` | `expression` | `FASTTExpressionStatement` | The expression statement that own me (if it's the case|
| `ioSpecifier` | `FASTTExpression` | `expression` | `FASTFortran2kIOParameter` | name of the parameter (keyword argument)|
| `kindOwner` | `FASTFortran2kAbstractExpression` | `kind` | `FASTFortran2kType` | |
| `parentArrayDimensionDeclarator` | `FASTFortran2kAbstractExpression` | `lowerBound` | `FASTFortran2kArrayRange` | Parent array dimension declarator|
| `parentArrayDimensionDeclarator` | `FASTFortran2kAbstractExpression` | `upperBound` | `FASTFortran2kArrayRange` | Parent array dimension declarator|
| `parentArrayExpression` | `FASTFortran2kAbstractExpression` | `indices` | `FASTFortran2kArrayVariable` | an ArrayVariable expression of which I am an indice|
| `parentConditionalStatement` | `FASTTExpression` | `condition` | `FASTTConditionalStatement` | Optional condition statement where this expression is used|
| `parentDataStatement` | `FASTFortran2kAbstractExpression` | `dataConstants` | `FASTFortran2kDataGroup` | |
| `parentExpression` | `FASTTExpression` | `expression` | `FASTTUnaryExpression` | Parent (unary) expression|
| `parentExpressionLeft` | `FASTTExpression` | `leftOperand` | `FASTTBinaryExpression` | Parent (binary) expression of which I am left side|
| `parentExpressionRight` | `FASTTExpression` | `rightOperand` | `FASTTBinaryExpression` | Parent (binary) expression of which I am right side|
| `parentGotoAssignedStatement` | `FASTFortran2kAbstractExpression` | `selectorExpression` | `FASTFortran2kGoToAssignedStatement` | |
| `parentGotoComputedStatement` | `FASTFortran2kAbstractExpression` | `selectorExpression` | `FASTFortran2kGoToComputedStatement` | |
| `parentLoopControlIncrement` | `FASTFortran2kAbstractExpression` | `increment` | `FASTFortran2kLoopControlExpression` | |
| `parentLoopControlLimit` | `FASTFortran2kAbstractExpression` | `limit` | `FASTFortran2kLoopControlExpression` | |
| `parentTypeSize` | `FASTFortran2kAbstractExpression` | `size` | `FASTFortran2kType` | |
| `returnOwner` | `FASTTExpression` | `expression` | `FASTTReturnStatement` | The return statement that own the expression (if it's the case)|
| `variableDeclaratorOwner` | `FASTFortran2kAbstractExpression` | `expression` | `FASTFortran2kVariableDeclarator` | |


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kAbstractExpression',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTTExpression',
	#classTraits : 'FASTTExpression classTrait',
	#instVars : [
		'#assignementExpressionOwner => FMOne type: #FASTFortran2kFunctionStatement opposite: #expression',
		'#kindOwner => FMOne type: #FASTFortran2kType opposite: #kind',
		'#parentArrayDimensionDeclarator => FMOne type: #FASTFortran2kArrayRange opposite: #upperBound',
		'#parentArrayExpression => FMOne type: #FASTFortran2kArrayVariable opposite: #indices',
		'#parentDataStatement => FMOne type: #FASTFortran2kDataGroup opposite: #dataConstants',
		'#parentGotoAssignedStatement => FMOne type: #FASTFortran2kGoToAssignedStatement opposite: #selectorExpression',
		'#parentGotoComputedStatement => FMOne type: #FASTFortran2kGoToComputedStatement opposite: #selectorExpression',
		'#parentLoopControlIncrement => FMOne type: #FASTFortran2kLoopControlExpression opposite: #increment',
		'#parentLoopControlLimit => FMOne type: #FASTFortran2kLoopControlExpression opposite: #limit',
		'#parentTypeSize => FMOne type: #FASTFortran2kType opposite: #size',
		'#variableDeclaratorOwner => FMOne type: #FASTFortran2kVariableDeclarator opposite: #expression'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kAbstractExpression class >> annotation [

	<FMClass: #AbstractExpression super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> assignementExpressionOwner [
	"Relation named: #assignementExpressionOwner type: #FASTFortran2kFunctionStatement opposite: #expression"

	<generated>
	<FMComment: 'The AssignementExpression owner (if possible)'>
	<container>
	<derived>
	^ assignementExpressionOwner
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> assignementExpressionOwner: anObject [

	<generated>
	assignementExpressionOwner := anObject
]

{ #category : 'navigation' }
FASTFortran2kAbstractExpression >> assignementExpressionOwnerGroup [
	<generated>
	<navigation: 'AssignementExpressionOwner'>
	^ MooseSpecializedGroup with: self assignementExpressionOwner
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> kindOwner [
	"Relation named: #kindOwner type: #FASTFortran2kType opposite: #kind"

	<generated>
	<container>
	<derived>
	^ kindOwner
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> kindOwner: anObject [

	<generated>
	kindOwner := anObject
]

{ #category : 'navigation' }
FASTFortran2kAbstractExpression >> kindOwnerGroup [
	<generated>
	<navigation: 'KindOwner'>
	^ MooseSpecializedGroup with: self kindOwner
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> parentArrayDimensionDeclarator [
	"Relation named: #parentArrayDimensionDeclarator type: #FASTFortran2kArrayRange opposite: #upperBound"

	<generated>
	<FMComment: 'Parent array dimension declarator'>
	<container>
	<derived>
	^ parentArrayDimensionDeclarator
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> parentArrayDimensionDeclarator: anObject [

	<generated>
	parentArrayDimensionDeclarator := anObject
]

{ #category : 'navigation' }
FASTFortran2kAbstractExpression >> parentArrayDimensionDeclaratorGroup [
	<generated>
	<navigation: 'ParentArrayDimensionDeclarator'>
	^ MooseSpecializedGroup with: self parentArrayDimensionDeclarator
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> parentArrayExpression [
	"Relation named: #parentArrayExpression type: #FASTFortran2kArrayVariable opposite: #indices"

	<generated>
	<FMComment: 'an ArrayVariable expression of which I am an indice'>
	<container>
	^ parentArrayExpression
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> parentArrayExpression: anObject [

	<generated>
	parentArrayExpression := anObject
]

{ #category : 'navigation' }
FASTFortran2kAbstractExpression >> parentArrayExpressionGroup [
	<generated>
	<navigation: 'ParentArrayExpression'>
	^ MooseSpecializedGroup with: self parentArrayExpression
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> parentDataStatement [
	"Relation named: #parentDataStatement type: #FASTFortran2kDataGroup opposite: #dataConstants"

	<generated>
	<container>
	^ parentDataStatement
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> parentDataStatement: anObject [

	<generated>
	parentDataStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kAbstractExpression >> parentDataStatementGroup [
	<generated>
	<navigation: 'ParentDataStatement'>
	^ MooseSpecializedGroup with: self parentDataStatement
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> parentGotoAssignedStatement [
	"Relation named: #parentGotoAssignedStatement type: #FASTFortran2kGoToAssignedStatement opposite: #selectorExpression"

	<generated>
	<container>
	<derived>
	^ parentGotoAssignedStatement
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> parentGotoAssignedStatement: anObject [

	<generated>
	parentGotoAssignedStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kAbstractExpression >> parentGotoAssignedStatementGroup [
	<generated>
	<navigation: 'ParentGotoAssignedStatement'>
	^ MooseSpecializedGroup with: self parentGotoAssignedStatement
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> parentGotoComputedStatement [
	"Relation named: #parentGotoComputedStatement type: #FASTFortran2kGoToComputedStatement opposite: #selectorExpression"

	<generated>
	<container>
	<derived>
	^ parentGotoComputedStatement
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> parentGotoComputedStatement: anObject [

	<generated>
	parentGotoComputedStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kAbstractExpression >> parentGotoComputedStatementGroup [
	<generated>
	<navigation: 'ParentGotoComputedStatement'>
	^ MooseSpecializedGroup with: self parentGotoComputedStatement
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> parentLoopControlIncrement [
	"Relation named: #parentLoopControlIncrement type: #FASTFortran2kLoopControlExpression opposite: #increment"

	<generated>
	<container>
	<derived>
	^ parentLoopControlIncrement
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> parentLoopControlIncrement: anObject [

	<generated>
	parentLoopControlIncrement := anObject
]

{ #category : 'navigation' }
FASTFortran2kAbstractExpression >> parentLoopControlIncrementGroup [
	<generated>
	<navigation: 'ParentLoopControlIncrement'>
	^ MooseSpecializedGroup with: self parentLoopControlIncrement
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> parentLoopControlLimit [
	"Relation named: #parentLoopControlLimit type: #FASTFortran2kLoopControlExpression opposite: #limit"

	<generated>
	<container>
	<derived>
	^ parentLoopControlLimit
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> parentLoopControlLimit: anObject [

	<generated>
	parentLoopControlLimit := anObject
]

{ #category : 'navigation' }
FASTFortran2kAbstractExpression >> parentLoopControlLimitGroup [
	<generated>
	<navigation: 'ParentLoopControlLimit'>
	^ MooseSpecializedGroup with: self parentLoopControlLimit
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> parentTypeSize [
	"Relation named: #parentTypeSize type: #FASTFortran2kType opposite: #size"

	<generated>
	<container>
	<derived>
	^ parentTypeSize
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> parentTypeSize: anObject [

	<generated>
	parentTypeSize := anObject
]

{ #category : 'navigation' }
FASTFortran2kAbstractExpression >> parentTypeSizeGroup [
	<generated>
	<navigation: 'ParentTypeSize'>
	^ MooseSpecializedGroup with: self parentTypeSize
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> variableDeclaratorOwner [
	"Relation named: #variableDeclaratorOwner type: #FASTFortran2kVariableDeclarator opposite: #expression"

	<generated>
	<container>
	<derived>
	^ variableDeclaratorOwner
]

{ #category : 'accessing' }
FASTFortran2kAbstractExpression >> variableDeclaratorOwner: anObject [

	<generated>
	variableDeclaratorOwner := anObject
]

{ #category : 'navigation' }
FASTFortran2kAbstractExpression >> variableDeclaratorOwnerGroup [
	<generated>
	<navigation: 'VariableDeclaratorOwner'>
	^ MooseSpecializedGroup with: self variableDeclaratorOwner
]
