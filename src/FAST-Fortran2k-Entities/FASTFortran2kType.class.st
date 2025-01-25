"
I represent Fortran Type statement

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `parentDeclaration` | `FASTFortran2kType` | `type` | `FASTFortran2kVariableDeclarationStatement` | Parent declaration|
| `parentImplicitRule` | `FASTFortran2kType` | `type` | `FASTFortran2kImplicitTypingRule` | |
| `typedFunctions` | `FASTFortran2kType` | `returnType` | `FASTFortran2kInternalFunction` | |
| `typedFunctions` | `FASTFortran2kType` | `returnType` | `FASTFortran2kFunction` | |

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `size` | `FASTFortran2kType` | `parentTypeSize` | `FASTFortran2kAbstractExpression` | a data size in bytes|



"
Class {
	#name : 'FASTFortran2kType',
	#superclass : 'FASTFortran2kEntity',
	#instVars : [
		'#parentDeclaration => FMOne type: #FASTFortran2kVariableDeclarationStatement opposite: #type',
		'#parentImplicitRule => FMOne type: #FASTFortran2kImplicitTypingRule opposite: #type',
		'#size => FMOne type: #FASTFortran2kAbstractExpression opposite: #parentTypeSize',
		'#typedFunctions => FMOne type: #FASTFortran2kFunction opposite: #returnType'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kType class >> annotation [

	<FMClass: #Type super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kType >> parentDeclaration [
	"Relation named: #parentDeclaration type: #FASTFortran2kVariableDeclarationStatement opposite: #type"

	<generated>
	<FMComment: 'Parent declaration'>
	<container>
	<derived>
	^ parentDeclaration
]

{ #category : 'accessing' }
FASTFortran2kType >> parentDeclaration: anObject [

	<generated>
	parentDeclaration := anObject
]

{ #category : 'navigation' }
FASTFortran2kType >> parentDeclarationGroup [
	<generated>
	<navigation: 'ParentDeclaration'>
	^ MooseSpecializedGroup with: self parentDeclaration
]

{ #category : 'accessing' }
FASTFortran2kType >> parentImplicitRule [
	"Relation named: #parentImplicitRule type: #FASTFortran2kImplicitTypingRule opposite: #type"

	<generated>
	<container>
	<derived>
	^ parentImplicitRule
]

{ #category : 'accessing' }
FASTFortran2kType >> parentImplicitRule: anObject [

	<generated>
	parentImplicitRule := anObject
]

{ #category : 'navigation' }
FASTFortran2kType >> parentImplicitRuleGroup [
	<generated>
	<navigation: 'ParentImplicitRule'>
	^ MooseSpecializedGroup with: self parentImplicitRule
]

{ #category : 'accessing' }
FASTFortran2kType >> size [
	"Relation named: #size type: #FASTFortran2kAbstractExpression opposite: #parentTypeSize"

	<generated>
	<FMComment: 'a data size in bytes'>
	^ size
]

{ #category : 'accessing' }
FASTFortran2kType >> size: anObject [

	<generated>
	size := anObject
]

{ #category : 'navigation' }
FASTFortran2kType >> sizeGroup [
	<generated>
	<navigation: 'Size'>
	^ MooseSpecializedGroup with: self size
]

{ #category : 'accessing' }
FASTFortran2kType >> typedFunctions [
	"Relation named: #typedFunctions type: #FASTFortran2kFunction opposite: #returnType"

	<generated>
	<container>
	<derived>
	^ typedFunctions
]

{ #category : 'accessing' }
FASTFortran2kType >> typedFunctions: anObject [

	<generated>
	typedFunctions := anObject
]

{ #category : 'navigation' }
FASTFortran2kType >> typedFunctionsGroup [
	<generated>
	<navigation: 'TypedFunctions'>
	^ MooseSpecializedGroup with: self typedFunctions
]
