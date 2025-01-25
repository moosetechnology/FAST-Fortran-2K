"
I represent Fortran Stop statement

## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `displayArgument` | `String` | nil | Optional. Displayed when the program stops. String of no more that 5 digits or a character constant|

"
Class {
	#name : 'FASTFortran2kStopStatement',
	#superclass : 'FASTFortran2kAbstractStatement',
	#instVars : [
		'#displayArgument => FMProperty'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kStopStatement class >> annotation [

	<FMClass: #StopStatement super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kStopStatement >> displayArgument [

	<FMProperty: #displayArgument type: #String>
	<generated>
	<FMComment: 'Optional. Displayed when the program stops. String of no more that 5 digits or a character constant'>
	^ displayArgument
]

{ #category : 'accessing' }
FASTFortran2kStopStatement >> displayArgument: anObject [
	<generated>
	displayArgument := anObject
]
