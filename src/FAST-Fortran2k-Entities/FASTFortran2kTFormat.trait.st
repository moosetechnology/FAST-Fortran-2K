"
I represent a format description (eg. in Format or Print statement)

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `parentFormatedStatement` | `FASTFortran2kTFormat` | `format` | `FASTFortran2kTWithFormat` | A format description in a Format/Print/Read/Write statement|
| `parentIOStatement` | `FASTFortran2kTIOParameter` | `ioParameters` | `FASTFortran2kAbstractIOStatement` | |



"
Trait {
	#name : 'FASTFortran2kTFormat',
	#instVars : [
		'#parentFormatedStatement => FMOne type: #FASTFortran2kTWithFormat opposite: #format'
	],
	#traits : 'FASTFortran2kTIOParameter',
	#classTraits : 'FASTFortran2kTIOParameter classTrait',
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTFormat classSide >> annotation [

	<FMClass: #TFormat super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kTFormat >> parentFormatedStatement [
	"Relation named: #parentFormatedStatement type: #FASTFortran2kTWithFormat opposite: #format"

	<generated>
	<FMComment: 'A format description in a Format/Print/Read/Write statement'>
	<container>
	<derived>
	^ parentFormatedStatement
]

{ #category : 'accessing' }
FASTFortran2kTFormat >> parentFormatedStatement: anObject [

	<generated>
	parentFormatedStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kTFormat >> parentFormatedStatementGroup [
	<generated>
	<navigation: 'ParentFormatedStatement'>
	^ MooseSpecializedGroup with: self parentFormatedStatement
]
