Trait {
	#name : 'FASTTSimplifier',
	#category : 'Famix-Esope-Transformator-Simplification',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Simplification'
}

{ #category : 'ast manipulation' }
FASTTSimplifier >> commentOut: commentTag statement: aFASTStatement [

	| comment |
	self toggleSimplifiedOn.

	comment := self makeComment: commentTag fromStatement: aFASTStatement.
	self parentStatement
		substituteStatementNode: aFASTStatement
		withNode: comment.
	^ comment
]

{ #category : 'ast manipulation' }
FASTTSimplifier >> exportFASTEntity: aFASTStatement [

	| visitor |
	visitor := self fastExporter.

	String streamContents: [ :str |
		visitor outputStream: str.
		aFASTStatement accept: visitor ].
	^ visitor outputStream contents trimBoth
]

{ #category : 'accessing' }
FASTTSimplifier >> fastExporter [

	self explicitRequirement
]

{ #category : 'ast manipulation' }
FASTTSimplifier >> makeComment: tag fromStatement: aFASTStatement [

	| asString |
	asString := self exportFASTEntity: aFASTStatement.

	^ aFASTStatement mooseModel newComment content:
		  (String streamContents: [ :str |
			   str << '[ooo]'.
			   tag ifNotNil: [
				   str
					   << '.';
					   << tag asString;
					   << ':' ].
			   str
				   << ' ';
				   << asString ])
]

{ #category : 'accessing' }
FASTTSimplifier >> parentStatement [

	self explicitRequirement 
]

{ #category : 'accessing' }
FASTTSimplifier >> toggleSimplifiedOn [

	self explicitRequirement 
]
