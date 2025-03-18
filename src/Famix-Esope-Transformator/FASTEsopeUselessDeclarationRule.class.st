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
		'uselessDeclarations'
	],
	#category : 'Famix-Esope-Transformator-Simplification',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Simplification'
}

{ #category : 'initialization' }
FASTEsopeUselessDeclarationRule >> initialize [

	super initialize.

	uselessDeclarations := Dictionary new
]

{ #category : 'accessing - private tests' }
FASTEsopeUselessDeclarationRule >> uselessDeclarations [

	^uselessDeclarations 
]

{ #category : 'visiting' }
FASTEsopeUselessDeclarationRule >> visitFASTEsopePointerDeclarationStatement: aFASTEsopePointerDeclaration [

	nodeStack push: aFASTEsopePointerDeclaration.

	super visitFASTEsopePointerDeclarationStatement: aFASTEsopePointerDeclaration.

	nodeStack pop
]

{ #category : 'visiting - expressions' }
FASTEsopeUselessDeclarationRule >> visitFASTFortranArrayVariable: aFASTFortranArrayVariable [

	self visitFASTFortranVariable: aFASTFortranArrayVariable.

	aFASTFortranArrayVariable indices do: [ :indice |
		indice accept: self
	].

]

{ #category : 'visiting - programUnits' }
FASTEsopeUselessDeclarationRule >> visitFASTFortranProcedure: aFASTFortranProcedure [

	declaredVariables := Dictionary new.

	super visitFASTFortranProcedure: aFASTFortranProcedure.

	declaredVariables do: [ :toSimplify |
		(toSimplify second accept: FASTEsopeExporterVisitor new)
			traceCr.
	]
]

{ #category : 'visiting - programUnits' }
FASTEsopeUselessDeclarationRule >> visitFASTFortranProgramMain: aFASTFortranProgramMain [

	declaredVariables := Dictionary new.

	super visitFASTFortranProgramMain: aFASTFortranProgramMain.

	declaredVariables do: [ :toSimplify |
		(toSimplify second accept: FASTEsopeExporterVisitor new)
			traceCr.
	]
]

{ #category : 'visiting - expressions' }
FASTEsopeUselessDeclarationRule >> visitFASTFortranScalarVariable: aFASTFortranScalarVariable [

	self visitFASTFortranVariable: aFASTFortranScalarVariable 

]

{ #category : 'visiting - expressions' }
FASTEsopeUselessDeclarationRule >> visitFASTFortranVariable: aFASTFortranVariable [

	uselessDeclarations removeKey: aFASTFortranVariable name ifAbsent: [ "nothing" ]
]

{ #category : 'visiting - statements' }
FASTEsopeUselessDeclarationRule >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	nodeStack push: aFASTFortranVariableDeclarationStatement.

	super visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement.

	nodeStack pop

]

{ #category : 'visiting' }
FASTEsopeUselessDeclarationRule >> visitFASTFortranVariableDeclarator: aFASTFortranVariableDeclarator [
	"need to keep the context of the declaration:
	   declarationStatement + parentStatement"

	| declarationStatement |
	declarationStatement := nodeStack pop.

	uselessDeclarations
		at: aFASTFortranVariableDeclarator name
		put: { nodeStack top . declarationStatement }.

	nodeStack push: declarationStatement.

	^ aFASTFortranVariableDeclarator expression
		  ifNotNil: [ :expression | expression accept: self ]
		  ifNil: [ nil ]
]
