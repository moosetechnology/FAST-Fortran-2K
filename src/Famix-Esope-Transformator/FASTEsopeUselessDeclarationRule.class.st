"
I am looking for variable that are declared but not used.
By default all declarations are assumed useless.
Then if the variable is used somewhere in the code, it is removed from the useless list.

In the end everything that remains in the list are the declarations that can be removed
"
Class {
	#name : 'FASTEsopeUselessDeclarationRule',
	#superclass : 'FASTEsopeAbstractSimplifyingRule',
	#instVars : [
		'uselessDeclarations',
		'allParameters',
		'allArguments',
		'ioKeywordArguments'
	],
	#category : 'Famix-Esope-Transformator-Simplification',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Simplification'
}

{ #category : 'private' }
FASTEsopeUselessDeclarationRule >> checkUselessDeclarations [

	self removeIOKeywordArgsAndInvocationArgsFromUselessDeclarations.

	uselessDeclarations do: [ :toSimplify |
		toSimplify ifNotNil: [
			nodeStack push: toSimplify first.
			self commentOut: 'not-used' statement: toSimplify second.
			nodeStack pop
		]
	]
]

{ #category : 'initialization' }
FASTEsopeUselessDeclarationRule >> initialize [

	super initialize.

	uselessDeclarations := Dictionary new.
	allParameters := #().
	allArguments := OrderedCollection new.
	ioKeywordArguments := OrderedCollection new
]

{ #category : 'private' }
FASTEsopeUselessDeclarationRule >> removeIOKeywordArgsAndInvocationArgsFromUselessDeclarations [

	ioKeywordArguments do: [ :ioKeywordArgument | 
		uselessDeclarations removeKey: ioKeywordArgument ifAbsent: [ "Nothing" ] ].
	
	allArguments do: [ :callArgument | 
		uselessDeclarations removeKey: callArgument ifAbsent: [ "Nothing" ] ].
]

{ #category : 'accessing - private tests' }
FASTEsopeUselessDeclarationRule >> uselessDeclarations [

	^uselessDeclarations 
]

{ #category : 'visiting - expressions' }
FASTEsopeUselessDeclarationRule >> visitFASTFortran2kArrayVariable: aFASTFortranArrayVariable [

	self visitFASTFortran2kVariable: aFASTFortranArrayVariable.

	aFASTFortranArrayVariable indices do: [ :indice |
		indice accept: self
	].

]

{ #category : 'visiting - statements' }
FASTEsopeUselessDeclarationRule >> visitFASTFortran2kCloseStatement: aFASTFortran2kCloseStatement [
	"keywordArguments (IOParameter) in I/O are considered always used so we keep their names (ioSpecifier) there to not add them to the useless list"
	
	"We need to collect in ioKeywordArguments all keywordArguments"
	| ioParameters |

	ioParameters := aFASTFortran2kCloseStatement ioParameters
		select: [ :ioParameter |  
			ioParameter class = FASTFortran2kIOParameter 
				and: [ ioParameter expression class = FASTFortran2kScalarVariable ] 
		].

	ioKeywordArguments 
		addAll: (ioParameters collect: [ :ioParameter | ioParameter expression name ])
]

{ #category : 'visiting' }
FASTEsopeUselessDeclarationRule >> visitFASTFortran2kDerivedTypeComponentAccess: aFASTFortran2kDerivedTypeComponentAccess [ 

	self visitFASTFortran2kVariable: aFASTFortran2kDerivedTypeComponentAccess instance.

]

{ #category : 'visiting - statements' }
FASTEsopeUselessDeclarationRule >> visitFASTFortran2kOpenStatement: aFASTFortran2kOpenStatement [
	"keywordArguments (IOParameter) in I/O are considered always used so we keep their names (ioSpecifier) there to not add them to the useless list"
	
	"We need to collect in ioKeywordArguments all keywordArguments"
	| ioParameters |

	ioParameters := aFASTFortran2kOpenStatement ioParameters
		select: [ :ioParameter |  
			ioParameter class = FASTFortran2kIOParameter 
				and: [ ioParameter expression class = FASTFortran2kScalarVariable ] 
		].

	ioKeywordArguments 
		addAll: (ioParameters collect: [ :ioParameter | ioParameter expression name ])
]

{ #category : 'visiting' }
FASTEsopeUselessDeclarationRule >> visitFASTFortran2kPointerAssignmentStatement: aFASTEsopePointerDeclaration [

	nodeStack push: aFASTEsopePointerDeclaration.

	super visitFASTFortran2kPointerAssignmentStatement: aFASTEsopePointerDeclaration.

	nodeStack pop
]

{ #category : 'visiting - programUnits' }
FASTEsopeUselessDeclarationRule >> visitFASTFortran2kProcedure: aFASTFortranProcedure [

	uselessDeclarations := Dictionary new.
	super visitFASTFortran2kProcedure: aFASTFortranProcedure.
	self checkUselessDeclarations
]

{ #category : 'visiting - programUnits' }
FASTEsopeUselessDeclarationRule >> visitFASTFortran2kProgramMain: aFASTFortranProgramMain [

	uselessDeclarations := Dictionary new.
	super visitFASTFortran2kProgramMain: aFASTFortranProgramMain.
	self checkUselessDeclarations
]

{ #category : 'visiting - expressions' }
FASTEsopeUselessDeclarationRule >> visitFASTFortran2kScalarVariable: aFASTFortranScalarVariable [

	self visitFASTFortran2kVariable: aFASTFortranScalarVariable 

]

{ #category : 'visiting - traits' }
FASTEsopeUselessDeclarationRule >> visitFASTFortran2kTWithDeclarators: aFASTFortran2kTWithDeclarators [

	aFASTFortran2kTWithDeclarators declarators do: [ :declarator |
		declarator accept: self
	]
]

{ #category : 'visiting - expressions' }
FASTEsopeUselessDeclarationRule >> visitFASTFortran2kVariable: aFASTFortranVariable [

	uselessDeclarations removeKey: aFASTFortranVariable name ifAbsent: [ "nothing" ]
]

{ #category : 'visiting - statements' }
FASTEsopeUselessDeclarationRule >> visitFASTFortran2kVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	nodeStack push: aFASTFortranVariableDeclarationStatement.

	super visitFASTFortran2kVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement.

	nodeStack pop

]

{ #category : 'visiting - statements' }
FASTEsopeUselessDeclarationRule >> visitFASTFortran2kVariableDeclarator: aFASTFortranVariableDeclarator [
	"need to keep the context of the declaration:
	   declarationStatement + parentStatement"

	| declarationStatement |
	(allParameters includes: aFASTFortranVariableDeclarator name)
		ifTrue: [ ^nil ].

	declarationStatement := nodeStack pop.

	uselessDeclarations
		at: aFASTFortranVariableDeclarator name
		put: { nodeStack top . declarationStatement }.

	nodeStack push: declarationStatement.

	^ aFASTFortranVariableDeclarator expression
		  ifNotNil: [ :expression | expression accept: self ]
		  ifNil: [ nil ]
]

{ #category : 'visiting - traits' }
FASTEsopeUselessDeclarationRule >> visitFASTTWithArguments: aFASTFortran2kTWithArguments [
	"arguments in call are considered always used so we keep their names there to not add them to the useless list"
	
	"We need to collect in allArguments all arguments"
	allArguments addAll: (aFASTFortran2kTWithArguments arguments collect: #name)
]

{ #category : 'visiting - traits' }
FASTEsopeUselessDeclarationRule >> visitFASTTWithParameters: aFASTFortran2kTWithParameters [
	"parameters are considered always used so we keep their names there to not add them to the useless list"

	allParameters :=  aFASTFortran2kTWithParameters parameters collect: #name
]
