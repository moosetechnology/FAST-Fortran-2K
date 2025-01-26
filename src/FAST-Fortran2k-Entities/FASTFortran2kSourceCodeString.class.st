"
## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `content` | `String` | nil | The source code string to export|

"
Class {
	#name : 'FASTFortran2kSourceCodeString',
	#superclass : 'FASTFortran2kAbstractStatement',
	#instVars : [
		'#content => FMProperty'
	],
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kSourceCodeString class >> annotation [

	<FMClass: #SourceCodeString super: #FASTFortran2kAbstractStatement>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kSourceCodeString >> content [

	<FMProperty: #content type: #String>
	<generated>
	<FMComment: 'The source code string to export'>
	^ content
]

{ #category : 'accessing' }
FASTFortran2kSourceCodeString >> content: anObject [
	<generated>
	content := anObject
]
