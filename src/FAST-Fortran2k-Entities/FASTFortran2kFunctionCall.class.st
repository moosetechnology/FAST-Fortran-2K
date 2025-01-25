"
I represent a call to a function (or function statement)

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `arguments` | `FASTTWithArguments` | `argumentOwner` | `FASTTExpression` | My arguments|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `name` | `String` | nil | Name of called function|

"
Class {
	#name : 'FASTFortran2kFunctionCall',
	#superclass : 'FASTFortran2kAbstractExpression',
	#traits : 'FASTTWithArguments',
	#classTraits : 'FASTTWithArguments classTrait',
	#instVars : [
		'#name => FMProperty'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kFunctionCall class >> annotation [

	<FMClass: #FunctionCall super: #FASTFortran2kAbstractExpression>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kFunctionCall >> name [

	<FMProperty: #name type: #String>
	<generated>
	<FMComment: 'Name of called function'>
	^ name
]

{ #category : 'accessing' }
FASTFortran2kFunctionCall >> name: anObject [
	<generated>
	name := anObject
]
