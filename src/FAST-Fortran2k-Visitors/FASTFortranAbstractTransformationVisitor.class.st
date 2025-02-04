Class {
	#name : 'FASTFortranAbstractTransformationVisitor',
	#superclass : 'FASTFortranVisitor',
	#instVars : [
		'model',
		'stack'
	],
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'initialization' }
FASTFortranAbstractTransformationVisitor >> initialize [

	super initialize.

	stack := Stack new
]

{ #category : 'accessing' }
FASTFortranAbstractTransformationVisitor >> model [

	^ model
]

{ #category : 'accessing' }
FASTFortranAbstractTransformationVisitor >> model: aFASTModel [

	model := aFASTModel 
]

{ #category : 'visiting' }
FASTFortranAbstractTransformationVisitor >> visitFASTFortranComment: aCommentNode [

	^ FASTFortran2kComment new
		  content: aCommentNode content;
		  mooseModel: model;
		  yourself
]

{ #category : 'visiting - expressions' }
FASTFortranAbstractTransformationVisitor >> visitFASTFortranIntegerType: aFASTFortranIntegerType [
	^ model newIntegerType
]

{ #category : 'visiting - helpers' }
FASTFortranAbstractTransformationVisitor >> visitFASTFortranList: list [

	^ list collect: [ :item | item accept: self ]
]

{ #category : 'visiting - statements' }
FASTFortranAbstractTransformationVisitor >> visitFASTFortranVariableDeclarator: aFASTFortranVariableDeclarator [

	| varDeclarator |
	varDeclarator := FASTFortran2kVariableDeclarator new
		  name: aFASTFortranVariableDeclarator name;
		  yourself.
		
	varDeclarator dimensions:
		(varDeclarator dimensions collect: [ :dimension | 
			dimension accept: self
		]).

	^varDeclarator 
]
