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

{ #category : 'helpers' }
FASTFortranAbstractTransformationVisitor >> subVisitor: visitorClass [

	^visitorClass new
		model: model ;
		yourself
]

{ #category : 'visiting' }
FASTFortranAbstractTransformationVisitor >> visitFASTFortranComment: aCommentNode [

	^ FASTFortran2kComment new
		  content: aCommentNode content;
		  mooseModel: model;
		  yourself
]

{ #category : 'visiting - helpers' }
FASTFortranAbstractTransformationVisitor >> visitFASTFortranList: list [

	^ list collect: [ :item | item accept: self ]
]
