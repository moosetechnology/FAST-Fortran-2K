"
The SUBROUTINE statement identifies a subprogram, a named program unit as a subroutine, and specifies arguments for it


"
Class {
	#name : 'FASTFortran2kSubroutine',
	#superclass : 'FASTFortran2kProcedure',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kSubroutine class >> annotation [

	<FMClass: #Subroutine super: #FASTFortran2kProcedure>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'helpers' }
FASTFortran2kSubroutine >> inSameFileAs: aFASTFortran2kEntity [

	^self migratedModuleName = aFASTFortran2kEntity migratedModuleName
]
