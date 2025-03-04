"
I represent a special Fortran intrinsic type sucha as int16, int32, real32,...

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
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
	#name : 'FASTFortran2kSpecialIntrinsicType',
	#superclass : 'FASTFortran2kType',
	#traits : 'FASTTNamedEntity',
	#classTraits : 'FASTTNamedEntity classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kSpecialIntrinsicType class >> annotation [

	<FMClass: #SpecialIntrinsicType super: #FASTFortran2kType>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]
