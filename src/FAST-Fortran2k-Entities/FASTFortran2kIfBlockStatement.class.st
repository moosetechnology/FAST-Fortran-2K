"
I represent Fortran If (BLock) statement

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `elseStatementBlock` | `FASTFortran2kIfBlockStatement` | `parentIfBlock` | `FASTFortran2kStatementBlock` | Statement block containing statements of else branch |
| `thenStatementBlock` | `FASTFortran2kIfBlockStatement` | `parentIfBlock` | `FASTFortran2kStatementBlock` | Statement block containing statements of then branch |



"
Class {
	#name : 'FASTFortran2kIfBlockStatement',
	#superclass : 'FASTFortran2kConditionalStatement',
	#instVars : [
		'#thenStatementBlock => FMOne type: #FASTFortran2kStatementBlock opposite: #parentIfBlock',
		'#elseStatementBlock => FMOne type: #FASTFortran2kStatementBlock opposite: #parentIfBlock'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kIfBlockStatement class >> annotation [

	<FMClass: #IfBlockStatement super: #FASTFortran2kConditionalStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kIfBlockStatement >> elseStatementBlock [
	"Relation named: #elseStatementBlock type: #FASTFortran2kStatementBlock opposite: #parentIfBlock"

	<generated>
	<FMComment: 'Statement block containing statements of else branch '>
	^ elseStatementBlock
]

{ #category : 'accessing' }
FASTFortran2kIfBlockStatement >> elseStatementBlock: anObject [

	<generated>
	elseStatementBlock := anObject
]

{ #category : 'navigation' }
FASTFortran2kIfBlockStatement >> elseStatementBlockGroup [
	<generated>
	<navigation: 'ElseStatementBlock'>
	^ MooseSpecializedGroup with: self elseStatementBlock
]

{ #category : 'accessing' }
FASTFortran2kIfBlockStatement >> thenStatementBlock [
	"Relation named: #thenStatementBlock type: #FASTFortran2kStatementBlock opposite: #parentIfBlock"

	<generated>
	<FMComment: 'Statement block containing statements of then branch '>
	^ thenStatementBlock
]

{ #category : 'accessing' }
FASTFortran2kIfBlockStatement >> thenStatementBlock: anObject [

	<generated>
	thenStatementBlock := anObject
]

{ #category : 'navigation' }
FASTFortran2kIfBlockStatement >> thenStatementBlockGroup [
	<generated>
	<navigation: 'ThenStatementBlock'>
	^ MooseSpecializedGroup with: self thenStatementBlock
]
