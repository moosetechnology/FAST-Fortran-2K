"
I represent an argument in an entry statement: it can be a variable name, array name, formal procedure name, or an asterisk

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `entryStatement` | `FASTFortran2kTEntryArgument` | `entryArguments` | `FASTFortran2kEntryStatement` | |



"
Trait {
	#name : 'FASTFortran2kTEntryArgument',
	#instVars : [
		'#entryStatement => FMOne type: #FASTFortran2kEntryStatement opposite: #entryArguments'
	],
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTEntryArgument classSide >> annotation [

	<FMClass: #TEntryArgument super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kTEntryArgument >> entryStatement [
	"Relation named: #entryStatement type: #FASTFortran2kEntryStatement opposite: #entryArguments"

	<generated>
	<container>
	^ entryStatement
]

{ #category : 'accessing' }
FASTFortran2kTEntryArgument >> entryStatement: anObject [

	<generated>
	entryStatement := anObject
]

{ #category : 'navigation' }
FASTFortran2kTEntryArgument >> entryStatementGroup [
	<generated>
	<navigation: 'EntryStatement'>
	^ MooseSpecializedGroup with: self entryStatement
]
