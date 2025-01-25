"
I represent a statement with a format (format, print)

## Relations
======================

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `format` | `FASTFortran2kTWithFormat` | `parentFormatedStatement` | `FASTFortran2kTFormat` | The description of the format|



"
Trait {
	#name : 'FASTFortran2kTWithFormat',
	#instVars : [
		'#format => FMOne type: #FASTFortran2kTFormat opposite: #parentFormatedStatement'
	],
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTWithFormat classSide >> annotation [

	<FMClass: #TWithFormat super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kTWithFormat >> format [
	"Relation named: #format type: #FASTFortran2kTFormat opposite: #parentFormatedStatement"

	<generated>
	<FMComment: 'The description of the format'>
	^ format
]

{ #category : 'accessing' }
FASTFortran2kTWithFormat >> format: anObject [

	<generated>
	format := anObject
]

{ #category : 'navigation' }
FASTFortran2kTWithFormat >> formatGroup [
	<generated>
	<navigation: 'Format'>
	^ MooseSpecializedGroup with: self format
]
