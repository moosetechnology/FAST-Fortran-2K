Extension { #name : 'FASTFortran2kProgramUnit' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kProgramUnit >> addComment: content [

	self addStatement: (self mooseModel newComment
		content: content)
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kProgramUnit >> addStatement: f2kStatement [

	self statementBlock addStatement: f2kStatement
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kProgramUnit >> initBody [

	self statementBlock: self mooseModel newStatementBlock
]
