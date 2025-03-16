"
I am a simplification rule for a FASTFortran AST

I take take an AST and converts some instruction to comment to ""remove them"" from the AST
"
Class {
	#name : 'FASTEsopeAbstractSimplifyingRule',
	#superclass : 'FASTFortranVisitor',
	#traits : 'FASTEsopeTVisitor',
	#classTraits : 'FASTEsopeTVisitor classTrait',
	#instVars : [
		'nodeStack',
		'simplified'
	],
	#category : 'Famix-Esope-Transformator-Simplification',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Simplification'
}

{ #category : 'as yet unclassified' }
FASTEsopeAbstractSimplifyingRule class >> simplify: aFASTEntity [

	^self new
		simplify: aFASTEntity
]

{ #category : 'helpers' }
FASTEsopeAbstractSimplifyingRule >> commentOut: commentTag statement: aFASTStatement [

	| comment |

	simplified := true.

	comment := self makeComment: commentTag fromStatement: aFASTStatement.
	nodeStack top
		substituteStatementNode: aFASTStatement
		withNode: comment.
	^comment
]

{ #category : 'initialization' }
FASTEsopeAbstractSimplifyingRule >> initialize [ 

	super initialize.

	simplified := false.
	nodeStack := Stack new
]

{ #category : 'helpers' }
FASTEsopeAbstractSimplifyingRule >> makeComment: tag fromStatement: aFASTStatement [

	| visitor |

	visitor := FASTEsopeExporterVisitor new.

	String streamContents: [ :str |
			visitor outputStream: str.
			aFASTStatement accept: visitor
	].
	
	^aFASTStatement mooseModel newComment
		content: (String streamContents: [ : str |
			str << '[ooo]'.
			tag ifNotNil: [
				str
					<< '.' ;
				 	<< tag asString ;
					<< ':'
			].
			str
				<< ' ' ;
				<< visitor outputStream contents trimBoth
		])
]

{ #category : 'accessing - private tests' }
FASTEsopeAbstractSimplifyingRule >> nodeStack [

	^nodeStack 
]

{ #category : 'accessing' }
FASTEsopeAbstractSimplifyingRule >> simplified [

	^simplified
]

{ #category : 'run' }
FASTEsopeAbstractSimplifyingRule >> simplify: aFASTEntity [

	simplified := false.

	aFASTEntity accept: self.

	^simplified
]

{ #category : 'visiting - statements' }
FASTEsopeAbstractSimplifyingRule >> visitFASTFortranIfLogicalStatement: aFASTFortranIfLogicalStatement [

	nodeStack push: aFASTFortranIfLogicalStatement.

	super visitFASTFortranIfLogicalStatement: aFASTFortranIfLogicalStatement.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeAbstractSimplifyingRule >> visitFASTFortranStatementBlock: aFASTFortranStatementBlock [

	nodeStack push: aFASTFortranStatementBlock.

	aFASTFortranStatementBlock statements do: [:stmt | stmt accept: self ].

	nodeStack pop
]
