Class {
	#name : 'FASTFortranAbstractTransformationVisitor',
	#superclass : 'FASTFortranVisitor',
	#instVars : [
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

{ #category : 'visiting' }
FASTFortranAbstractTransformationVisitor >> visitFASTFortranComment: aCommentNode [

	^ self model newComment
		  content: aCommentNode content;
		  yourself
]

{ #category : 'visiting - expressions' }
FASTFortranAbstractTransformationVisitor >> visitFASTFortranIntegerType: aFASTFortranIntegerType [

	^ self model newIntegerType
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
