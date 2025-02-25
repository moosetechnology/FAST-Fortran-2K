"
mainly used by sourceCodeString and its subclasses to be able to be added as a procedure in the module

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `module` | `FASTFortran2kTProcedure` | `procedures` | `FASTFortran2kModule` | |



"
Trait {
	#name : 'FASTFortran2kTProcedure',
	#instVars : [
		'#module => FMOne type: #FASTFortran2kModule opposite: #procedures'
	],
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTProcedure classSide >> annotation [

	<FMClass: #TProcedure super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kTProcedure >> module [
	"Relation named: #module type: #FASTFortran2kModule opposite: #procedures"

	<generated>
	<container>
	^ module
]

{ #category : 'accessing' }
FASTFortran2kTProcedure >> module: anObject [

	<generated>
	module := anObject
]

{ #category : 'navigation' }
FASTFortran2kTProcedure >> moduleGroup [
	<generated>
	<navigation: 'Module'>
	^ MooseSpecializedGroup with: self module
]
