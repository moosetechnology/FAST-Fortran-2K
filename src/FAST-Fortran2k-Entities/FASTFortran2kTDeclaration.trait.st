"
I am a declaration in fortran

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `fortranDeclarationOwner` | `FASTFortran2kTDeclaration` | `declarations` | `FASTFortran2kTWithDeclarations` | The element that declares me|



"
Trait {
	#name : 'FASTFortran2kTDeclaration',
	#instVars : [
		'#fortranDeclarationOwner => FMOne type: #FASTFortran2kTWithDeclarations opposite: #declarations'
	],
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTDeclaration classSide >> annotation [

	<FMClass: #TDeclaration super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kTDeclaration >> fortranDeclarationOwner [
	"Relation named: #fortranDeclarationOwner type: #FASTFortran2kTWithDeclarations opposite: #declarations"

	<generated>
	<FMComment: 'The element that declares me'>
	<container>
	^ fortranDeclarationOwner
]

{ #category : 'accessing' }
FASTFortran2kTDeclaration >> fortranDeclarationOwner: anObject [

	<generated>
	fortranDeclarationOwner := anObject
]

{ #category : 'navigation' }
FASTFortran2kTDeclaration >> fortranDeclarationOwnerGroup [
	<generated>
	<navigation: 'FortranDeclarationOwner'>
	^ MooseSpecializedGroup with: self fortranDeclarationOwner
]
