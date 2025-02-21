Class {
	#name : 'FASTFortranAbstractTransformationVisitor',
	#superclass : 'FASTFortranVisitor',
	#instVars : [
		'stack'
	],
	#category : 'Famix-Esope-Transformator',
	#package : 'Famix-Esope-Transformator'
}

{ #category : 'initialization' }
FASTFortranAbstractTransformationVisitor >> initialize [

	super initialize.

	stack := Stack new
]

{ #category : 'accessing' }
FASTFortranAbstractTransformationVisitor >> model [

	self subclassResponsibility 
]

{ #category : 'instance creation' }
FASTFortranAbstractTransformationVisitor >> newStatement: fastFortran2kStatementClass tracingBackTo: famixStatementEntity [

	^fastFortran2kStatementClass new
		mooseModel: self model ;
		attributeAt: #backTrace put: famixStatementEntity ;
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
