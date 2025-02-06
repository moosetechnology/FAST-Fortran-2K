Class {
	#name : 'FASTFortran2kUseResolver',
	#superclass : 'FASTFortranVisitor',
	#instVars : [
		'model',
		'stack'
	],
	#category : 'FAST-Fortran2k-Visitors-Resolver',
	#package : 'FAST-Fortran2k-Visitors',
	#tag : 'Resolver'
}

{ #category : 'running' }
FASTFortran2kUseResolver class >> runOn: aFASTFortran2kModel [ 
	self new
		model: aFASTFortran2kModel;
		resolve
]

{ #category : 'accessing' }
FASTFortran2kUseResolver >> model [

	^ model
]

{ #category : 'accessing' }
FASTFortran2kUseResolver >> model: anObject [

	model := anObject
]

{ #category : 'navigating' }
FASTFortran2kUseResolver >> resolve [
	| resolvableEntities |
	resolvableEntities := self getAllResolvableEntities.
	resolvableEntities do: [ :resolvableEntity |
		self resolve: resolvableEntity 
	]
]

{ #category : 'accessing' }
FASTFortran2kUseResolver >> stack [

	^ stack
]

{ #category : 'accessing' }
FASTFortran2kUseResolver >> stack: anObject [

	stack := anObject
]
