"
I am a simplification rule for a FASTFortran AST

I take take an AST and converts some instruction to comment to ""remove them"" from the AST
"
Class {
	#name : 'FASTEsopeAbstractSimplifyingRule',
	#superclass : 'FASTFortranVisitor',
	#category : 'Famix-Esope-Transformator-Simplification',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Simplification'
}

{ #category : 'as yet unclassified' }
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

{ #category : 'as yet unclassified' }
FASTEsopeAbstractSimplifyingRule >> substitueNode: aFASTNode withNode: aFASTReplacement [

]
