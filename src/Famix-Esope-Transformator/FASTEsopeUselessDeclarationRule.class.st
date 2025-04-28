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
		'allArguments'
	],
	#category : 'Famix-Esope-Transformator-Simplification',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Simplification'
}

{ #category : 'private' }
FASTEsopeUselessDeclarationRule >> checkUselessDeclarations [

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
	allArguments := #()
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

{ #category : 'visiting' }
FASTEsopeUselessDeclarationRule >> visitFASTFortran2kDerivedTypeComponentAccess: aFASTFortran2kDerivedTypeComponentAccess [ 

	self visitFASTFortran2kVariable: aFASTFortran2kDerivedTypeComponentAccess instance.

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

{ #category : 'visiting' }
FASTEsopeUselessDeclarationRule >> visitFASTFortran2kVariableDeclarator: aFASTFortranVariableDeclarator [
	"need to keep the context of the declaration:
	   declarationStatement + parentStatement"

	| declarationStatement |
	(allParameters includes: aFASTFortranVariableDeclarator name)
		ifTrue: [ ^nil ].

	(allArguments includes: aFASTFortranVariableDeclarator name)
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

{ #category : 'visiting - expressions' }
FASTEsopeUselessDeclarationRule >> visitFASTTWithArguments: aFASTFortran2kTWithArguments [
	"arguments in call are considered always used so we keep their names there to not add them to the useless list"
	
	"We need to collect in allArguments all arguments"
	allArguments := aFASTFortran2kTWithArguments arguments collect: #name.

	"we need to remove in uselessDeclarations dictionary this argument in case we already process all the declarations"
	aFASTFortran2kTWithArguments arguments do: [ :arg | arg accept: self ]
]

{ #category : 'visiting - expressions' }
FASTEsopeUselessDeclarationRule >> visitFASTTWithParameters: aFASTFortran2kTWithParameters [
	"parameters are considered always used so we keep their names ghere to not add them to the useless list"

	allParameters :=  aFASTFortran2kTWithParameters parameters collect: #name
]
