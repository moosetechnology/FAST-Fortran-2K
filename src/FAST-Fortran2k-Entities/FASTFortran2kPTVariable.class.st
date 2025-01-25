"
## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `assignedIn` | `FASTFortran2kPTVariable` | `expression` | `FASTFortran2kTPointerAssignment` | Optional assignment where this expression is used|



"
Class {
	#name : 'FASTFortran2kPTVariable',
	#superclass : 'FASTFortran2kVariable',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kPTVariable class >> annotation [

	<FMClass: #PTVariable super: #FASTFortran2kVariable>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kPTVariable >> assignedIn [
	"Relation named: #assignedIn type: #FASTFortran2kTPointerAssignment opposite: #expression"

	<generated>
	<FMComment: 'Optional assignment where this expression is used'>
	<container>
	<derived>
	^ assignedIn
]

{ #category : 'accessing' }
FASTFortran2kPTVariable >> assignedIn: anObject [

	<generated>
	assignedIn := anObject
]

{ #category : 'navigation' }
FASTFortran2kPTVariable >> assignedInGroup [
	<generated>
	<navigation: 'AssignedIn'>
	^ MooseSpecializedGroup with: self assignedIn
]
