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
FASTFortran2kProgramUnit >> addUse: usedName [

    self statementBlock statements
        detect: [ :statement | 
            statement class = FASTFortran2kUseStatement
                and: [ statement name asLowercase = usedName asLowercase ] ]
        ifNone: [ 
            self statementBlock statements
                addFirst: (self mooseModel newUseStatement name: usedName) 
        ]
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kProgramUnit >> initBody [

	self statementBlock: self mooseModel newStatementBlock
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kProgramUnit >> useSource [

	self subclassResponsibility 
]
