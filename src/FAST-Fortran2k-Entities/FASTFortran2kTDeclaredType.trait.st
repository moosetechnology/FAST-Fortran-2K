"
I am the declared type of a function or variable

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `declaredType` | `FASTFortran2kTDeclaredType` | `parentDeclaration` | `FASTFortran2kType` | type|



"
Trait {
	#name : 'FASTFortran2kTDeclaredType',
	#instVars : [
		'#declaredType => FMOne type: #FASTFortran2kType opposite: #parentDeclaration'
	],
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTDeclaredType classSide >> annotation [

	<FMClass: #TDeclaredType super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kTDeclaredType >> declaredType [
	"Relation named: #declaredType type: #FASTFortran2kType opposite: #parentDeclaration"

	<generated>
	<FMComment: 'type'>
	^ declaredType
]

{ #category : 'accessing' }
FASTFortran2kTDeclaredType >> declaredType: anObject [

	<generated>
	declaredType := anObject
]

{ #category : 'navigation' }
FASTFortran2kTDeclaredType >> declaredTypeGroup [
	<generated>
	<navigation: 'DeclaredType'>
	^ MooseSpecializedGroup with: self declaredType
]
