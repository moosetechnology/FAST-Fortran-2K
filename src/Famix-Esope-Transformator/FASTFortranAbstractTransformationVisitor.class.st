Class {
	#name : 'FASTFortranAbstractTransformationVisitor',
	#superclass : 'FASTFortranVisitor',
	#instVars : [
		'stack',
		'filename'
	],
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'accessing' }
FASTFortranAbstractTransformationVisitor >> filename [

	^filename
]

{ #category : 'accessing' }
FASTFortranAbstractTransformationVisitor >> filename: aString [

	filename := aString 
]

{ #category : 'instance creation' }
FASTFortranAbstractTransformationVisitor >> fortran2k: fastFortran2kClass traceBack: fortranEntity [

	| fortran2kEntity |
	fortran2kEntity := fastFortran2kClass new
		mooseModel: self model ;
		yourself.
	fortranEntity startPos
		ifNil: [ fortran2kEntity startPos: 0 ; endPos: 0 ]
		ifNotNil: [ fortran2kEntity startPos: fortranEntity startPos ; endPos: fortranEntity endPos ].

	^fortran2kEntity
]

{ #category : 'initialization' }
FASTFortranAbstractTransformationVisitor >> initialize [

	super initialize.

	stack := Stack new
]

{ #category : 'accessing' }
FASTFortranAbstractTransformationVisitor >> model [

	self subclassResponsibility 
]

{ #category : 'accessing - private tests' }
FASTFortranAbstractTransformationVisitor >> stack [

	^stack
]

{ #category : 'visiting - helpers' }
FASTFortranAbstractTransformationVisitor >> visitFASTFortranList: list [

	^ list collect: [ :item | item accept: self ]
]

{ #category : 'visiting - statements' }
FASTFortranAbstractTransformationVisitor >> visitFASTFortranVariableDeclarator: aFASTFortranVariableDeclarator [

	| varDeclarator |
	varDeclarator := self model newVariableDeclarator
		  name: aFASTFortranVariableDeclarator name;
		  yourself.
		
	varDeclarator dimensions:
		(varDeclarator dimensions collect: [ :dimension | 
			dimension accept: self
		]).

	^varDeclarator 
]
