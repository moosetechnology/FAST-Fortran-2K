"
## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `parentAssignmentExpression` | `FASTFortran2kPointerVariable` | `variable` | `FASTFortran2kTPointerAssignment` | Optional assignment to the variable|



"
Class {
	#name : 'FASTFortran2kPointerVariable',
	#superclass : 'FASTFortran2kPTVariable',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kPointerVariable class >> annotation [

	<FMClass: #PointerVariable super: #FASTFortran2kPTVariable>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kPointerVariable >> parentAssignmentExpression [
	"Relation named: #parentAssignmentExpression type: #FASTFortran2kTPointerAssignment opposite: #variable"

	<generated>
	<FMComment: 'Optional assignment to the variable'>
	<container>
	<derived>
	^ parentAssignmentExpression
]

{ #category : 'accessing' }
FASTFortran2kPointerVariable >> parentAssignmentExpression: anObject [

	<generated>
	parentAssignmentExpression := anObject
]

{ #category : 'navigation' }
FASTFortran2kPointerVariable >> parentAssignmentExpressionGroup [
	<generated>
	<navigation: 'ParentAssignmentExpression'>
	^ MooseSpecializedGroup with: self parentAssignmentExpression
]
