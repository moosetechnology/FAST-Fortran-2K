Class {
	#name : 'FASTFortran2kModel',
	#superclass : 'MooseModel',
	#traits : 'FASTFortran2kTEntityCreator + FASTTEntityCreator',
	#classTraits : 'FASTFortran2kTEntityCreator classTrait + FASTTEntityCreator classTrait',
	#category : 'FAST-Fortran2k-Entities-Model',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Model'
}

{ #category : 'accessing' }
FASTFortran2kModel class >> allSubmetamodelsPackagesNames [
	<generated>
	^ #(#'Moose-Query' #'Famix-Traits' #'FAST-Core-Model')
]

{ #category : 'meta' }
FASTFortran2kModel class >> annotation [
	<FMClass: #FASTFortran2kModel super: #MooseModel>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
]
