Class {
	#name : 'FASTEsopeUselessDeclarationRule',
	#superclass : 'FASTEsopeAbstractSimplifyingRule',
	#instVars : [
		'declaredVariables'
	],
	#category : 'Famix-Esope-Transformator-Simplification',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Simplification'
}

{ #category : 'initialization' }
FASTEsopeUselessDeclarationRule >> initialize [

	super initialize.

	declaredVariables := Dictionary new
]

{ #category : 'visiting' }
FASTEsopeUselessDeclarationRule >> visitFASTEsopePointerDeclarationStatement: aFASTEsopePointerDeclaration [

	nodeStack push: aFASTEsopePointerDeclaration.

	super visitFASTEsopePointerDeclarationStatement: aFASTEsopePointerDeclaration.

	nodeStack pop
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
FASTEsopeUselessDeclarationRule >> visitFASTFortranVariable: aFASTFortranVariable [

	declaredVariables at: aFASTFortranVariable name put: nil
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

	declaredVariables
		at: aFASTFortranVariableDeclarator name
		put: { nodeStack top . declarationStatement }.

	nodeStack push: declarationStatement.

	^ aFASTFortranVariableDeclarator expression
		  ifNotNil: [ :expression | expression accept: self ]
		  ifNil: [ nil ]
]
