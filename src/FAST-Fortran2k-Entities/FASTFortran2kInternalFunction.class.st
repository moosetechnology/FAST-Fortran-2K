"
I represent a internal procedure

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `returnType` | `FASTFortran2kInternalFunction` | `typedFunctions` | `FASTFortran2kType` | |



"
Class {
	#name : 'FASTFortran2kInternalFunction',
	#superclass : 'FASTFortran2kInternalProcedure',
	#instVars : [
		'#returnType => FMOne type: #FASTFortran2kType opposite: #typedFunctions'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kInternalFunction class >> annotation [

	<FMClass: #InternalFunction super: #FASTFortran2kInternalProcedure>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	<abstract>
	^ self
]

{ #category : 'testing' }
FASTFortran2kInternalFunction class >> isAbstract [

	<generated>
	^ self == FASTFortran2kInternalFunction
]

{ #category : 'accessing' }
FASTFortran2kInternalFunction >> returnType [
	"Relation named: #returnType type: #FASTFortran2kType opposite: #typedFunctions"

	<generated>
	^ returnType
]

{ #category : 'accessing' }
FASTFortran2kInternalFunction >> returnType: anObject [

	<generated>
	returnType := anObject
]

{ #category : 'navigation' }
FASTFortran2kInternalFunction >> returnTypeGroup [
	<generated>
	<navigation: 'ReturnType'>
	^ MooseSpecializedGroup with: self returnType
]
