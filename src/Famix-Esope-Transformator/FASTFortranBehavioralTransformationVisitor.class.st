Class {
	#name : 'FASTFortranBehavioralTransformationVisitor',
	#superclass : 'FASTFortranAbstractTransformationVisitor',
	#instVars : [
		'parentTransformator',
		'model2k'
	],
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'accessing' }
FASTFortranBehavioralTransformationVisitor >> handleProgramUnitSegmentDeclaration: declarations [
	
	declarations ifNotNil: [ 
		
		declarations do: [ :declaration | | programFile |
			programFile := self model2k newProgramFile
				filename: (declaration famix migratedModuleName , '.f90').

			programFile addProgramUnit: (
				declaration accept: (FASTFortranSegmentTransformationVisitor new 
					model2k: self model2k
				)
			)
		]
	]
]

{ #category : 'accessing' }
FASTFortranBehavioralTransformationVisitor >> includedStatements: includedFilename [
	"Statements from the included file to be inserted in the including file
	 Ignore comments which do not seem relevant
	 MAke a copy so that they can be added safely to the parentStatementBlock"

	^(parentTransformator includedFiles at: includedFilename)
		reject: [ :stmt | stmt class = FASTFortran2kComment ]
		thenCollect: [ :stmt | stmt copy]
]

{ #category : 'accessing' }
FASTFortranBehavioralTransformationVisitor >> model2k [

	^model2k
]

{ #category : 'accessing' }
FASTFortranBehavioralTransformationVisitor >> model2k: anObject [

	model2k := anObject
]

{ #category : 'accessing - private tests' }
FASTFortranBehavioralTransformationVisitor >> parentTransformator [

	^parentTransformator
]

{ #category : 'accessing' }
FASTFortranBehavioralTransformationVisitor >> parentTransformator: anObject [

	parentTransformator := anObject
]

{ #category : 'private - helpers' }
FASTFortranBehavioralTransformationVisitor >> retrieveOtherArgumentNamesFromDimensioningExpressions: variable [

	^variable famixVariable 
		ifNotNil: [ :famixVariable |
			famixVariable declaredType 
				ifNotNil: [ :declaredType | 
					declaredType accesses collect: [ :access |
						access variable name
					]
				]
				ifNil: [ #() ]
		]
		ifNil: [ #() ]
]

{ #category : 'private - helpers' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopeCommandMayDimensionned: variables named: aSymbol [
	| anEsopeCommandCall arguments |

	anEsopeCommandCall := self model2k newCallStatement
			name: aSymbol;
			yourself.

	arguments := OrderedCollection new.
	variables do:  [ :variable | | argument |
		argument := variable accept: self.
		arguments add: argument.

		"#FIXME: add others arguments from segment dimensioning expressions"
		(self retrieveOtherArgumentNamesFromDimensioningExpressions: variable)
			do: [ :argName |
				((arguments collect: #name) includes: argName)
					ifFalse: [ 
						arguments add: (model2k newScalarVariable name: argName)
					]
			]
	].

	anEsopeCommandCall arguments: arguments.

	^anEsopeCommandCall
]

{ #category : 'private - helpers' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopeCommandNonMigrated: aFASTEsopeSegCommand [

	^nil
]

{ #category : 'private - helpers' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopeCommandSimple: aFASTEsopeSegCommand named: aName [

	^aFASTEsopeSegCommand variables 
		collect:  [ :variable |
			self model2k newCallStatement
				name: aName;
				addArgument: (variable accept: self);
				yourself.
		]

]

{ #category : 'visiting - esope' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopeIncludeStatement: aFASTEsopeIncludeStatement [ 
	"in place of the #include,puts all statements of the included file which are not segment declaration
	 (so all variable declarations or other statements)
	 Enclose this in 2 comments as visual aids.
	 The first one is set to be in the same position of the original comment so that computing
	 empty lines can work for it."

	| includedStatements return startCommentContent |
	includedStatements := (self includedStatements:
		aFASTEsopeIncludeStatement famixInclude included programFile filename).
	return := OrderedCollection new: includedStatements size + 2.

	startCommentContent := '[ooo] ' ,
		(includedStatements ifEmpty: [ 'empty ' ] ifNotEmpty: [ '' ]) ,
		'#include ' ,
		aFASTEsopeIncludeStatement filename.

	return add: (self model2k newComment
		content: startCommentContent ;
		startPos: aFASTEsopeIncludeStatement startPos ;
		endPos: (aFASTEsopeIncludeStatement startPos + startCommentContent size) ;
		yourself ).

	return addAll: includedStatements.

	includedStatements
		ifNotEmpty: [
			return addLast: (self model2k newComment
				content: '[ooo] #end-include ' , aFASTEsopeIncludeStatement filename) ].

	^return
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopePointerDeclarationStatement: aFASTEsopePointerDeclarationStatement [
	"FASTEsopePointerDeclarator do not have start/en-pos (see FAST-Esope/issue #20)
	 As a work around, we put the position of the FASTEsopePointerDeclarationStatement into each (usually 1)
	 pointerDeclarator"

	^aFASTEsopePointerDeclarationStatement pointerDeclarators 
		collect: [ :pointerDeclarator |
			(pointerDeclarator accept: self)
				startPos: aFASTEsopePointerDeclarationStatement startPos ;
				endPos: aFASTEsopePointerDeclarationStatement endPos
		].
	
]

{ #category : 'visiting - esope' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopePointerDeclarator: aFASTEsopePointerDeclarator [ 
	
	| esopeDeclarator callerProgramUnit pointerDeclaredType |

	esopeDeclarator := self model2k newVariableDeclarationStatement
		declaredType: (self model2k newUserDefinedType  
			name: aFASTEsopePointerDeclarator pointedTypeName;
			yourself
		);
		addDeclarator: (aFASTEsopePointerDeclarator variableDeclarator accept: self);
		mooseModel: self model2k;
		yourself.

	callerProgramUnit := stack top.
	pointerDeclaredType := aFASTEsopePointerDeclarator variableDeclarator famixDeclaration declaredType.

	"useNeeded add: (callerProgramUnit  -> pointerDeclaredType)."

	^esopeDeclarator
]

{ #category : 'visiting - esope' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopeSegact: aFASTEsopeSegact [ 

	^self visitFASTEsopeCommandNonMigrated: aFASTEsopeSegact
]

{ #category : 'visiting - esope' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopeSegadj: aFASTEsopeSegadj [ 

	^self 
		visitFASTEsopeCommandMayDimensionned: aFASTEsopeSegadj variables 
		named: 'segadj'
]

{ #category : 'visiting - esope' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopeSegcop: aFASTEsopeSegcop [

	"muts be migrated as call segcop (p, q)
	the semantics of this object is:
		segini p=q, which will first allocate memory space for p and copy the contents of q into p
	"
	self shouldBeImplemented
]

{ #category : 'visiting - esope' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopeSegdes: aFASTEsopeSegdes [ 

	^self visitFASTEsopeCommandNonMigrated: aFASTEsopeSegdes
]

{ #category : 'visiting - esope' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopeSegini: aFASTEsopeSegini [ 

	^self 
		visitFASTEsopeCommandMayDimensionned: aFASTEsopeSegini variables 
		named: 'segini'
]

{ #category : 'visiting - esope' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopeSegment: aFASTEsopeSegmentNode [

	^nil
]

{ #category : 'visiting - esope' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopeSegmov: aFASTEsopeSegmov [

	"muts be migrated as call segmov (p, q)
	the semantics of this object is:
		segact p=q, which copies the contents of q into p, without first allocating memory
	"
	self shouldBeImplemented
]

{ #category : 'visiting - esope' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopeSegprt: aFASTEsopeSegprt [ 

	^self visitFASTEsopeCommandSimple: aFASTEsopeSegprt named: 'segprt'
]

{ #category : 'visiting - esope' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopeSegsup: aFASTEsopeSegsup [

	^self visitFASTEsopeCommandSimple: aFASTEsopeSegsup named: 'segsup'
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranArrayRange: aFASTFortranArrayRange [

	^self model2k newArrayRange
		lowerBound: (aFASTFortranArrayRange lowerBound accept: self);
		upperBound: (aFASTFortranArrayRange upperBound accept: self);
		yourself
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranArrayVariable: aFASTFortranArrayVariable [

	^self model2k newArrayVariable
		name: aFASTFortranArrayVariable name;
		indices: (self visitFASTFortranList: aFASTFortranArrayVariable indices);
		yourself
		
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranAssignmentExpression: anAssignmentExpressionNode [

	^ self model2k newAssignmentExpression
		  variable: (anAssignmentExpressionNode variable accept: self);
		  expression: (anAssignmentExpressionNode expression accept: self);
		  yourself
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranAssignmentStatement: aFASTFortranAssignmentStatement [

	^(self
		fortran2k: FASTFortran2kAssignmentStatement
		traceBack: aFASTFortranAssignmentStatement)

		variable: (aFASTFortranAssignmentStatement variable accept: self);
		expression: (aFASTFortranAssignmentStatement expression accept: self);
		yourself
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranAsterisk: aFASTFortranAsterisk [

	^ self model2k newAsterisk
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranBinaryExpression: aBinaryExpresionNode [

	^ FASTFortran2kBinaryExpression new
		  operator: aBinaryExpresionNode operator;
		  leftOperand: (aBinaryExpresionNode leftOperand accept: self);
		  rightOperand: (aBinaryExpresionNode rightOperand accept: self);
		  mooseModel: self model2k;
		  yourself
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranBooleanLiteral: aBooleanLiteralNode [

	^ self model2k newBooleanLiteral
		  primitiveValue: aBooleanLiteralNode primitiveValue;
		  yourself
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranCallStatement: aFASTFortranCallStatement [

	| callStatement callerProgramUnit calledProgramFile |

	callStatement := self
		fortran2k: FASTFortran2kCallStatement
		traceBack: aFASTFortranCallStatement.

	callStatement
		name: aFASTFortranCallStatement name;
		arguments: (self visitFASTFortranList: aFASTFortranCallStatement arguments).

	callerProgramUnit := stack top.
	calledProgramFile := aFASTFortranCallStatement famix candidates anyOne.

	"useNeeded add: (callerProgramUnit -> calledProgramFile)."

	^ callStatement

]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranCharacterLiteral: aFASTFortranCharacterLiteral [

	^ self model2k newCharacterLiteral
		  primitiveValue: aFASTFortranCharacterLiteral primitiveValue;
		  yourself
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranCharacterType: aFASTFortranCharacterType [

	^self model2k newCharacterType
		size: (aFASTFortranCharacterType size accept: self);
		yourself
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranCloseStatement: aFASTFortranCloseStatement [

	^self
		fortran2k: FASTFortran2kCloseStatement
		traceBack: aFASTFortranCloseStatement
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranComment: aCommentNode [

	^(self
		fortran2k: FASTFortran2kComment
		traceBack: aCommentNode)

		content: aCommentNode content;
		yourself
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranContinueStatement: aFASTFortranContinueStatement [

	^(self
		fortran2k: FASTFortran2kContinueStatement
		traceBack: aFASTFortranContinueStatement)

		label: aFASTFortranContinueStatement label;
		yourself
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranDoStatement: aDoStatementNode [

	^(self
		fortran2k: FASTFortran2kDoStatement
		traceBack: aDoStatementNode)

		  loopControl: (aDoStatementNode loopControl accept: self) ;
		  statementBlock: (aDoStatementNode statementBlock accept: self) ;
		  yourself
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranExternalStatement: aFASTFortranExternalStatement [

	^nil
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranFieldAccess: aFASTFortranFieldAccess [

	^ aFASTFortranFieldAccess field isArrayVariable
		ifTrue: [ 
			((aFASTFortranFieldAccess field indices size = 1)
				and: [ (aFASTFortranFieldAccess field indices anyOne class = FASTFortranUnaryExpression) 
				and: [ aFASTFortranFieldAccess field indices anyOne operator asLowercase = '/' ]]
			) 
			ifTrue: [ 
				self model2k newFunctionCall
					name: 'size';
					arguments: { 
						self model2k newDerivedTypeComponentAccess
							instance: (aFASTFortranFieldAccess pointer accept: self);
							field: (self model2k newScalarVariable name: aFASTFortranFieldAccess field name);
							yourself.

						(aFASTFortranFieldAccess field indices anyOne expression accept: self)
					};
					yourself
			] ifFalse: [ 
				self model2k newDerivedTypeComponentAccess
					instance: (aFASTFortranFieldAccess pointer accept: self);
					field: (aFASTFortranFieldAccess field accept: self);
					yourself.
			]
		]
		ifFalse: [ 
			self model2k newDerivedTypeComponentAccess
				instance: (aFASTFortranFieldAccess pointer accept: self);
				field: (aFASTFortranFieldAccess field accept: self);
				yourself.
		]
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranFunctionCall: aFASTFortranFunctionCall [

	| functionCall callerProgramUnit calledProgramFile |

	functionCall := self model2k newFunctionCall
		name: aFASTFortranFunctionCall name ;
		arguments: (aFASTFortranFunctionCall arguments collect: [:arg | arg accept: self]) ;
		yourself.

	callerProgramUnit := stack top.
	calledProgramFile := aFASTFortranFunctionCall famix candidates anyOne.

	"useNeeded add: (callerProgramUnit -> calledProgramFile)."

	^functionCall 
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranFunctionStatement: aFunctionStatementNode [

	| fct |
	fct := self model2k newInternalFunction
		name: aFunctionStatementNode name;
		declaredType: (aFunctionStatementNode famix declaredType accept: self)
		yourself.

	fct	 parameters: (aFunctionStatementNode parameters collect: [:parameter | 
			self model2k newScalarVariable 
				name: parameter name;
				yourself
			]).

	fct statementBlock: self model2k  newStatementBlock.

	aFunctionStatementNode parameters do: [:parameter |
		fct statementBlock addStatement: (
			self model2k newVariableDeclarationStatement
				declaredType: (parameter famixParameter declaredType accept: self);
				declarators: { self model2k newVariableDeclarator 
					name:  parameter name;
					yourself 
				};
				yourself
		)
	].

	fct statementBlock addStatement:	(	
			self model2k newAssignmentStatement
				variable: (self model2k newVariable name: aFunctionStatementNode name);
				expression: (aFunctionStatementNode expression accept: self);
				yourself
			).
		
	^fct
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranGoToStatement: aFASTFortranGoToStatement [

	^(self
		fortran2k: FASTFortran2kGoToStatement
		traceBack: aFASTFortranGoToStatement)

		labelReferences: (self visitFASTFortranList: aFASTFortranGoToStatement labelReferences);
		yourself
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranIOParameter: aFASTFortranIOParameter [

	^self model2k newIOParameter
		name: aFASTFortranIOParameter name;
		expression: (aFASTFortranIOParameter expression accept: self);
		yourself
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranIfBlockStatement: aFASTFortranIfBlockStatement [
	| ifBlockStatement |

	ifBlockStatement := self
		fortran2k: FASTFortran2kIfBlockStatement
		traceBack: aFASTFortranIfBlockStatement.

	ifBlockStatement condition: (aFASTFortranIfBlockStatement condition accept: self).

	aFASTFortranIfBlockStatement thenStatementBlock
		ifNotNil: [ :thenStatementBlock |
			ifBlockStatement thenStatementBlock: (thenStatementBlock accept: self)
		].

	aFASTFortranIfBlockStatement elseStatementBlock
		ifNotNil: [ :elseStatementBlock |
			ifBlockStatement elseStatementBlock: (elseStatementBlock accept: self)
		].
	
	^ifBlockStatement
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranIfLogicalStatement: aFASTFortranIfLogicalStatement [

	^(self
		fortran2k: FASTFortran2kIfLogicalStatement
		traceBack: aFASTFortranIfLogicalStatement)

		condition: (aFASTFortranIfLogicalStatement condition accept: self);
		statement: (aFASTFortranIfLogicalStatement statement accept: self);
		yourself
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranImplicitStatement: aFASTFortranImplicitStatement [

	^nil
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranImpliedDoExpression: aFASTFortranImpliedDoExpression [ 

	^self model2k newImpliedDoExpression
		loopControl: (aFASTFortranImpliedDoExpression loopControl accept: self);
		variables: (self visitFASTFortranList: aFASTFortranImpliedDoExpression variables);
		yourself
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranIntegerLiteral: anIntegerLiteralNode [

	^ self model2k newIntegerLiteral
		  primitiveValue: anIntegerLiteralNode primitiveValue;
		  yourself
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranIntegerType: aFASTFortranIntegerType [

	^ self model2k newIntegerType
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranLabelReference: aFASTFortranLabelReference [

	^self model2k newLabelReference
		label: aFASTFortranLabelReference label;
		yourself.
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranLogicalType: aFASTFortranLogicalType [

	^ self model2k newLogicalType
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranLoopControlExpression: aLoopControlNode [

	^self model2k newLoopControlExpression
		  init: (aLoopControlNode init accept: self);
		  limit: (aLoopControlNode limit accept: self);
		  increment: (aLoopControlNode increment ifNotNil: [:increment | increment  accept: self ]);
		  yourself
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranOpenStatement: aFASTFortranOpenStatement [

	^(self
		fortran2k: FASTFortran2kOpenStatement
		traceBack: aFASTFortranOpenStatement)

		ioParameters: (self visitFASTFortranList: aFASTFortranOpenStatement ioParameters);
		yourself
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranPrintStatement: aFASTFortranPrintStatement [

	^(self
		fortran2k: FASTFortran2kPrintStatement
		traceBack: aFASTFortranPrintStatement)

		  format: (aFASTFortranPrintStatement format accept: self);
		  arguments: (self visitFASTFortranList: aFASTFortranPrintStatement arguments);
		  yourself
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranReadStatement: aFASTFortranReadStatement [

	^(self
		fortran2k: FASTFortran2kReadStatement
		traceBack: aFASTFortranReadStatement)

		ioParameters: (self visitFASTFortranList: aFASTFortranReadStatement ioParameters);
		arguments:
			(self visitFASTFortranList: aFASTFortranReadStatement arguments);
		yourself
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranRealLiteral: aRealLiteralNode [

	^ FASTFortran2kRealLiteral new
		  primitiveValue: aRealLiteralNode primitiveValue;
		  mooseModel: self model2k;
		  yourself
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranRealType: aRealTypeNode [

	^ self model2k newRealType
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranReturnStatement: aFASTFortranReturnStatement [
	| returnStatement |

	returnStatement := self
		fortran2k: FASTFortran2kReturnStatement
		traceBack: aFASTFortranReturnStatement.
	aFASTFortranReturnStatement expression 
		ifNotNil: [:expression | 	
			returnStatement expression: (expression accept: self) 
		].

	aFASTFortranReturnStatement alternateReturnLabel 
		ifNotNil: [:alternateReturnLabel | 	
			returnStatement alternateReturnLabel: (alternateReturnLabel accept: self) 
		].

	aFASTFortranReturnStatement label 
		ifNotNil: [:label | 	
			returnStatement label: (label accept: self) 
		].
	
	^returnStatement
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranScalarVariable: aScalarVariableNode [

	^ self model2k newScalarVariable
		  name: aScalarVariableNode name;
		  yourself
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranStatementBlock: aFASTFortranStatementBlock [
	"Need to deal with StatementFunction that are created as InternalProcedure in the parent
	programUnit (which is on the top of the stack)"
	
	| f2kStatementBlock |
	
	f2kStatementBlock := self
		fortran2k: FASTFortran2kStatementBlock
		traceBack: aFASTFortranStatementBlock.

	aFASTFortranStatementBlock statements
		do: [ :statement | 
			(statement accept: self)
				ifNotNil: [ :f2kStatementOrModule | 
					f2kStatementOrModule class = FASTFortran2kModule 
						ifFalse: [ 
							statement class = FASTFortranFunctionStatement
								ifTrue: [stack top addInternalProcedure: f2kStatementOrModule ]
								ifFalse: [ 
									f2kStatementOrModule isCollection
										ifTrue: [ f2kStatementBlock statements addAll: f2kStatementOrModule ]
										ifFalse: [  f2kStatementBlock addStatement: f2kStatementOrModule ]
								]
						]
			 	]
		].

	^f2kStatementBlock
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranStopStatement: aFASTFortranStopStatement [

	^(self
		fortran2k: FASTFortran2kStopStatement
		traceBack: aFASTFortranStopStatement)

		displayArgument: (aFASTFortranStopStatement displayArgument);
		yourself
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranUnaryExpression: aFASTFortranUnaryExpression [

	^self model2k newUnaryExpression 
		expression: (aFASTFortranUnaryExpression expression accept: self);
		operator: aFASTFortranUnaryExpression operator;
		yourself.
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	^(self
		fortran2k: FASTFortran2kVariableDeclarationStatement
		traceBack: aFASTFortranVariableDeclarationStatement)

		declaredType: (aFASTFortranVariableDeclarationStatement declaredType accept: self);
		declarators: (self visitFASTFortranList: aFASTFortranVariableDeclarationStatement declarators) ;
		yourself
		
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranWriteStatement: aFASTFortranWriteStatement [

	^(self
		fortran2k: FASTFortran2kWriteStatement
		traceBack: aFASTFortranWriteStatement)

		ioParameters: (self visitFASTFortranList: aFASTFortranWriteStatement ioParameters);
		arguments: (self visitFASTFortranList: aFASTFortranWriteStatement arguments);
		yourself
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFamixF77Type: aFamixF77Type [
	| aTypeClass |
	aTypeClass := {
		#real -> FASTFortran2kRealType.
		#integer -> FASTFortran2kIntegerType.
		#character -> FASTFortran2kCharacterType.
		#logical -> FASTFortran2kLogicalType.
	} asDictionary at: aFamixF77Type name.

	^aTypeClass new
		mooseModel: self model2k;
		yourself.
]
