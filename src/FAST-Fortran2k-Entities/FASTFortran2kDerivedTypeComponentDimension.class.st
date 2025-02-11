"
## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `derivedTypeComponent` | `FASTFortran2kDerivedTypeComponentDimension` | `derivedTypeComponentDimensions` | `FASTFortran2kDerivedTypeComponent` | |
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kDerivedTypeComponentDimension',
	#superclass : 'FASTFortran2kAbstractExpression',
	#traits : 'FASTTNamedEntity',
	#classTraits : 'FASTTNamedEntity classTrait',
	#instVars : [
		'#derivedTypeComponent => FMOne type: #FASTFortran2kDerivedTypeComponent opposite: #derivedTypeComponentDimensions'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kDerivedTypeComponentDimension class >> annotation [

	<FMClass: #DerivedTypeComponentDimension super: #FASTFortran2kAbstractExpression>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponentDimension >> derivedTypeComponent [
	"Relation named: #derivedTypeComponent type: #FASTFortran2kDerivedTypeComponent opposite: #derivedTypeComponentDimensions"

	<generated>
	<container>
	^ derivedTypeComponent
]

{ #category : 'accessing' }
FASTFortran2kDerivedTypeComponentDimension >> derivedTypeComponent: anObject [

	<generated>
	derivedTypeComponent := anObject
]

{ #category : 'navigation' }
FASTFortran2kDerivedTypeComponentDimension >> derivedTypeComponentGroup [
	<generated>
	<navigation: 'DerivedTypeComponent'>
	^ MooseSpecializedGroup with: self derivedTypeComponent
]
