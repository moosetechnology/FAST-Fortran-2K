"
An abstract class for all the steps in the transformation Esope to Fortran2k
Keeps a pointer on the main `controller` (`EsopeTransformationController`) and offers access methods for various instance variables in this controller.
There is a `description` on class side to display the progress on a progress bar
"
Class {
	#name : 'EsopeTransfoAbstractStep',
	#superclass : 'Object',
	#instVars : [
		'controller'
	],
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'accessing' }
EsopeTransfoAbstractStep class >> description [

	| anEsopeTransfoAbstractStep |
	anEsopeTransfoAbstractStep := self new.

	anEsopeTransfoAbstractStep subclassResponsibility
]

{ #category : 'accessing' }
EsopeTransfoAbstractStep >> controller [

	^ controller
]

{ #category : 'accessing' }
EsopeTransfoAbstractStep >> controller: anObject [

	controller := anObject
]

{ #category : 'private' }
EsopeTransfoAbstractStep >> createVariableDeclarationStatment: famixVariable in: aFastModel [
	
	^aFastModel newVariableDeclarationStatement
		declaredType: (famixVariable declaredType generateFastF77InModel: aFastModel);
		declarators: { aFastModel newVariableDeclarator name: famixVariable name };
		yourself
]

{ #category : 'running' }
EsopeTransfoAbstractStep >> declareUndeclaredVariablesIn: aFastProgramUnit [

	| index missingFamixVariablesInFastModel |

	index := self getLastVariableDeclarationsStatementIndex: 
		aFastProgramUnit statementBlock statements.
	
	missingFamixVariablesInFastModel := self getMissingVariableDeclarations: aFastProgramUnit.

	missingFamixVariablesInFastModel ifNotEmpty: [
		aFastProgramUnit statementBlock statements
			add: (aFastProgramUnit mooseModel newComment content: '[ooo].not-declared: begin')
			afterIndex: index.

		index := index + 1
	].

	missingFamixVariablesInFastModel
		do: [ :missingVariable |
			aFastProgramUnit statementBlock statements
				add: (self 
					createVariableDeclarationStatment: missingVariable
					in: aFastProgramUnit mooseModel
				)
				afterIndex: index.

			index := index + 1.
		].

	missingFamixVariablesInFastModel ifNotEmpty: [
		aFastProgramUnit statementBlock statements
			add: (aFastProgramUnit mooseModel newComment content: '[ooo].not-declared: end')
			afterIndex: index
	]
]

{ #category : 'accessing' }
EsopeTransfoAbstractStep >> famixModel [

	^self controller famixModel
]

{ #category : 'private' }
EsopeTransfoAbstractStep >> fastProgramUnitFor: famixProgUnit [

	| fastProgramUnit |
	famixProgUnit bindFASTModel.
	fastProgramUnit := famixProgUnit fast.

	fastProgramUnit 
		ifNotNil: [ fastProgramUnit programFile: famixProgUnit programFile fast ].

	^fastProgramUnit 
]

{ #category : 'private' }
EsopeTransfoAbstractStep >> getLastVariableDeclarationsStatementIndex: statements [

	^statements findLast: [ :statement |
		statement class = FASTFortranVariableDeclarationStatement 
	]
]

{ #category : 'private' }
EsopeTransfoAbstractStep >> getMissingVariableDeclarations: aFastProgramUnit [

	| declarators |

	declarators := (aFastProgramUnit mooseModel 
		allWithType: FASTFortranVariableDeclarator
	) reject: [ :declarator |
			(aFastProgramUnit parameters collect: #name)
				anySatisfy: [ :parameterName |
					parameterName sameAs: declarator name ] 
		].

	^aFastProgramUnit famix localVariables 
		reject: [ :famixVariable |
			(declarators collect: #name) 
				anySatisfy: [ :declaratorName |
					declaratorName sameAs: famixVariable name ] 
	]
]

{ #category : 'accessing' }
EsopeTransfoAbstractStep >> includedFiles [

	^self controller includedFiles
]

{ #category : 'running' }
EsopeTransfoAbstractStep >> run [ 
	self subclassResponsibility 
]

{ #category : 'private' }
EsopeTransfoAbstractStep >> transformationVisitor: visitorClass [

	^visitorClass new
		parentTransformator: self controller ;
		model2k: self controller fast2kModel;
		yourself
]
