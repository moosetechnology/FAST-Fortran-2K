"
I represent Fortran Do statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `labelReferences` | `FASTFortran2kTWithLabelReferences` | `referencer` | `FASTFortran2kLabelReference` | the label(s) referenced|
| `loopControl` | `FASTFortran2kTWithLoopControl` | `parentLoop` | `FASTFortran2kLoopControlExpression` | loop control|
| `statementBlock` | `FASTFortran2kDoStatement` | `parentDoStatement` | `FASTFortran2kStatementBlock` | Statement block containing statements of the do body |



"
Class {
	#name : 'FASTFortran2kDoStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#traits : 'FASTFortran2kTWithLabelReferences + FASTFortran2kTWithLoopControl',
	#classTraits : 'FASTFortran2kTWithLabelReferences classTrait + FASTFortran2kTWithLoopControl classTrait',
	#instVars : [
		'#statementBlock => FMOne type: #FASTFortran2kStatementBlock opposite: #parentDoStatement'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kDoStatement class >> annotation [

	<FMClass: #DoStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kDoStatement >> statementBlock [
	"Relation named: #statementBlock type: #FASTFortran2kStatementBlock opposite: #parentDoStatement"

	<generated>
	<FMComment: 'Statement block containing statements of the do body '>
	^ statementBlock
]

{ #category : 'accessing' }
FASTFortran2kDoStatement >> statementBlock: anObject [

	<generated>
	statementBlock := anObject
]

{ #category : 'navigation' }
FASTFortran2kDoStatement >> statementBlockGroup [
	<generated>
	<navigation: 'StatementBlock'>
	^ MooseSpecializedGroup with: self statementBlock
]
