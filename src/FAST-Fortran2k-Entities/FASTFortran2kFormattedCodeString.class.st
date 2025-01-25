"
## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `values` | `Object` | nil | Values of the variables to format the string|

"
Class {
	#name : 'FASTFortran2kFormattedCodeString',
	#superclass : 'FASTFortran2kSourceCodeString',
	#instVars : [
		'#values => FMProperty'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kFormattedCodeString class >> annotation [

	<FMClass: #FormattedCodeString super: #FASTFortran2kSourceCodeString>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kFormattedCodeString >> values [

	<FMProperty: #values type: #Object>
	<generated>
	<FMComment: 'Values of the variables to format the string'>
	^ values
]

{ #category : 'accessing' }
FASTFortran2kFormattedCodeString >> values: anObject [
	<generated>
	values := anObject
]
