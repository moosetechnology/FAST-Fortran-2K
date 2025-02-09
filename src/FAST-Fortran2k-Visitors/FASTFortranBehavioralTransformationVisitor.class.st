Class {
	#name : 'FASTFortranBehavioralTransformationVisitor',
	#superclass : 'FASTFortranAbstractTransformationVisitor',
	#instVars : [
		'parentTransformator'
	],
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'accessing' }
FASTFortranBehavioralTransformationVisitor >> model [

	^self parentTransformator fast2kModel
]

{ #category : 'accessing' }
FASTFortranBehavioralTransformationVisitor >> parentTransformator [

	^ parentTransformator
]

{ #category : 'accessing' }
FASTFortranBehavioralTransformationVisitor >> parentTransformator: anObject [

	parentTransformator := anObject
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopePointerDeclarationStatement: aFASTEsopePointerDeclarationStatement [

	^aFASTEsopePointerDeclarationStatement pointerDeclarators 
		collect: [ :pointerDeclarator | pointerDeclarator accept: self ].
	
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopePointerDeclarator: aFASTEsopePointerDeclarator [ 
	
	| esopeDeclarator callerProgramUnit pointerDeclaredType |

	esopeDeclarator := FASTFortran2kDerivedTypeDeclaration new 
		type: (FASTFortran2kUserDefinedType new 
			name: aFASTEsopePointerDeclarator pointedTypeName;
			mooseModel: self model;
			yourself
		);
		addDeclarator: (aFASTEsopePointerDeclarator variableDeclarator accept: self);
		mooseModel: self model;
		yourself.

	callerProgramUnit := stack top.
	pointerDeclaredType := aFASTEsopePointerDeclarator variableDeclarator famixDeclaration declaredType.

	"useNeeded add: (callerProgramUnit  -> pointerDeclaredType)."

	^esopeDeclarator
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopeSegadj: aFASTEsopeSegadj [ 
	^aFASTEsopeSegadj variables collect:  [ :variable | | anEsopeCommandCall argument |
		argument := variable accept: self.
		anEsopeCommandCall := self model newCallStatement
			name: 'segadj';
			addArgument: argument;
			yourself.
		
		self flag: '#TODO: add others arguments from segment dimensional expressions'.
		anEsopeCommandCall
	]
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFASTEsopeSegini: aFASTEsopeSegini [ 
	
	^aFASTEsopeSegini variables collect:  [ :variable | | anEsopeCommandCall argument |
		argument := variable accept: self.
		anEsopeCommandCall := self model newCallStatement
			name: 'segini';
			addArgument: argument;
			yourself.
		
		self flag: '#TODO: add others arguments from segment dimensional expressions'.
		anEsopeCommandCall
	]
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranAssignmentExpression: anAssignmentExpressionNode [

	^ self model newAssignmentExpression
		  variable: (anAssignmentExpressionNode variable accept: self);
		  expression: (anAssignmentExpressionNode expression accept: self);
		  yourself
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranAssignmentStatement: anAssignmentStatementNode [

	^ FASTFortran2kAssignmentStatement new
		  variable: (anAssignmentStatementNode variable accept: self);
		  expression: (anAssignmentStatementNode expression accept: self);
		  "migrateFrom: anAssignmentStatementNode;"
		  mooseModel: self model;
		  yourself
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranAsterisk: aFASTFortranAsterisk [

	^ self model newAsterisk
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranBinaryExpression: aBinaryExpresionNode [

	^ FASTFortran2kBinaryExpression new
		  operator: aBinaryExpresionNode operator;
		  leftOperand: (aBinaryExpresionNode leftOperand accept: self);
		  rightOperand: (aBinaryExpresionNode rightOperand accept: self);
		  mooseModel: self model;
		  yourself
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranBooleanLiteral: aBooleanLiteralNode [

	^ self model newBooleanLiteral
		  primitiveValue: aBooleanLiteralNode primitiveValue;
		  yourself
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranCallStatement: aFASTFortranCallStatement [

	| callStatement callerProgramUnit calledProgramFile |

	callStatement := FASTFortran2kCallStatement new
		name: aFASTFortranCallStatement name;
		arguments: (aFASTFortranCallStatement arguments
				collect: [ :argument | argument accept: self ]
		);
		mooseModel: self model;
		yourself.

	callerProgramUnit := stack top.
	calledProgramFile := aFASTFortranCallStatement famix candidates anyOne.

	"useNeeded add: (callerProgramUnit -> calledProgramFile)."

	^ callStatement

]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranCharacterLiteral: aFASTFortranCharacterLiteral [

	^ self model newCharacterLiteral
		  primitiveValue: aFASTFortranCharacterLiteral primitiveValue;
		  yourself
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranCharacterType: aFASTFortranCharacterType [

	^ FASTFortran2kCharacterType new size:
		  (aFASTFortranCharacterType size accept: self)
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranDoStatement: aDoStatementNode [

	^self model newDoStatement
		  loopControl: (aDoStatementNode loopControl accept: self) ;
		  statementBlock: (aDoStatementNode statementBlock accept: self) ;
		  yourself
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranFunctionCall: aFASTFortranFunctionCall [

	| functionCall callerProgramUnit calledProgramFile |

	functionCall := self model newFunctionCall
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
	fct := FASTFortran2kInternalFunction new
		name: aFunctionStatementNode name.
	
	fct returnType: (aFunctionStatementNode famix declaredType accept: self).
		
	fct	 parameters: (aFunctionStatementNode parameters collect: [:parameter | 
			FASTFortran2kScalarVariable new 
				name: parameter name; 
				mooseModel: self model;
				yourself
			]).
		
	fct statementBlock: FASTFortran2kStatementBlock new.

	aFunctionStatementNode parameters do: [:parameter |
		fct statementBlock addStatement: (
			FASTFortran2kVariableDeclarationStatement new
				type: (parameter famixParameter declaredType accept: self);
				declarators: { FASTFortran2kVariableDeclarator new 
					name:  parameter name; 
					mooseModel: self model; 
					yourself 
				};
				mooseModel: self model;
				yourself
		)
	].

	
	fct statementBlock addStatement:	(	
			FASTFortran2kAssignmentStatement new
				variable: (FASTFortran2kVariable new name: aFunctionStatementNode name);
				expression: (aFunctionStatementNode expression accept: self);
				mooseModel: self model;
				yourself
			).
		
	^fct
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranImplicitStatement: aFASTFortranImplicitStatement [

	^nil
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranIntegerLiteral: anIntegerLiteralNode [

	^ self model newIntegerLiteral
		  primitiveValue: anIntegerLiteralNode primitiveValue;
		  yourself
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranLoopControlExpression: aLoopControlNode [

	^self model newLoopControlExpression
		  init: (aLoopControlNode init accept: self);
		  limit: (aLoopControlNode limit accept: self);
		  increment: (aLoopControlNode increment ifNotNil: [:increment | increment  accept: self ]);
		  yourself
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranPrintStatement: aFASTFortranPrintStatement [

	^ self model newPrintStatement
		  format: (aFASTFortranPrintStatement format accept: self);
		  arguments:
			  (aFASTFortranPrintStatement arguments collect: [ :arg |
					   arg accept: self ]);
		  yourself
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranRealLiteral: aRealLiteralNode [

	^ FASTFortran2kRealLiteral new
		  primitiveValue: aRealLiteralNode primitiveValue;
		  mooseModel: self model;
		  yourself
]

{ #category : 'visiting' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranRealType: aRealTypeNode [

	^ FASTFortran2kRealType new
		  mooseModel: self model;
		  yourself
]

{ #category : 'visiting - expressions' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranScalarVariable: aScalarVariableNode [

	^ FASTFortran2kScalarVariable new
		  name: aScalarVariableNode name;
		  mooseModel: self model;
		  yourself
]

{ #category : 'visiting - statements' }
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranStatementBlock: aFASTFortranStatementBlock [
	"Need to deal with StatementFunction that are created as InternalProcedure in the parent
	programUnit (which is on the top of the stack)"
	
	| f2kStatementBlock |
	
	f2kStatementBlock := self model newStatementBlock.

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
FASTFortranBehavioralTransformationVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	^ FASTFortran2kVariableDeclarationStatement new
		  type: (aFASTFortranVariableDeclarationStatement declaredType accept: self);
		  mooseModel: self model;
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
		mooseModel: self model;
		yourself.
]
