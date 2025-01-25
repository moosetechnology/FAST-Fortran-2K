"
I represent a Fortran Function

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `returnType` | `FASTFortran2kFunction` | `typedFunctions` | `FASTFortran2kType` | |



"
Class {
	#name : 'FASTFortran2kFunction',
	#superclass : 'FASTFortran2kProcedure',
	#instVars : [
		'#returnType => FMOne type: #FASTFortran2kType opposite: #typedFunctions'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kFunction class >> annotation [

	<FMClass: #Function super: #FASTFortran2kProcedure>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kFunction >> returnType [
	"Relation named: #returnType type: #FASTFortran2kType opposite: #typedFunctions"

	<generated>
	^ returnType
]

{ #category : 'accessing' }
FASTFortran2kFunction >> returnType: anObject [

	<generated>
	returnType := anObject
]

{ #category : 'navigation' }
FASTFortran2kFunction >> returnTypeGroup [
	<generated>
	<navigation: 'ReturnType'>
	^ MooseSpecializedGroup with: self returnType
]
