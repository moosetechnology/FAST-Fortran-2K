"
I am a simplification rule for a FASTFortran AST

I take take an AST and converts some instruction to comment to ""remove them"" from the AST
"
Class {
	#name : 'FASTEsopeAbstractSimplifyingRule',
	#superclass : 'FASTFortranVisitor',
	#instVars : [
		'nodeStack'
	],
	#category : 'Famix-Esope-Transformator-Simplification',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Simplification'
}

{ #category : 'helpers' }
FASTEsopeAbstractSimplifyingRule >> commentOut: tag statement: aFASTStatement [

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
				str << '.' ; << tag asString ].
			str
				<< ' ' ;
				<< visitor outputStream contents trimBoth
		])
]

{ #category : 'initialization' }
FASTEsopeAbstractSimplifyingRule >> initialize [ 

	super initialize.

	nodeStack := Stack new
]

{ #category : 'accessing - private tests' }
FASTEsopeAbstractSimplifyingRule >> nodeStack [

	^nodeStack 
]

{ #category : 'helpers' }
FASTEsopeAbstractSimplifyingRule >> substituteStatementNode: aFASTStatement withNode: aFASTReplacement [

	nodeStack top substituteStatementNode: aFASTStatement withNode: aFASTReplacement 
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

	super visitFASTFortranStatementBlock: aFASTFortranStatementBlock.

	nodeStack pop
]
