"
A null pattern entity for FASTFortran2k


"
Class {
	#name : 'FASTFortran2kNullEntity',
	#superclass : 'FASTFortran2kEntity',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kNullEntity class >> annotation [

	<FMClass: #NullEntity super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'visiting' }
FASTFortran2kNullEntity >> accept: aVisitor [

	^aVisitor visitFASTFortran2kNullEntity: self 
]
