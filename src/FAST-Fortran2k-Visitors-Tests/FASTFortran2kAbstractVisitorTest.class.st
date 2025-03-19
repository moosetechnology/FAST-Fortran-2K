Class {
	#name : 'FASTFortran2kAbstractVisitorTest',
	#superclass : 'TestCase',
	#instVars : [
		'visitor',
		'ast'
	],
	#category : 'FAST-Fortran2k-Visitors-Tests',
	#package : 'FAST-Fortran2k-Visitors-Tests'
}

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> add: statementBlock statement: aStatement [

	^statementBlock addStatement: aStatement.

]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> addParameter: name type: typeDescription [
	"assume #ast contains a function definition"

	self entity: ast parameters: ((ast parameters collect: #name)
			 add: name asString;
			 yourself).

	^ self addStatement: (self declarationStatement: name type: typeDescription)
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> addStatement: aStatement [

	^self add: ast statementBlock statement: aStatement

]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> assignementExpression: aName value: value [

	^FASTFortran2kAssignmentExpression new
		variable: (self makeSimpleExpression: aName) ;
		expression: (self makeSimpleExpression: value) ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> assignementStatement: aName value: rhs [

	^FASTFortran2kAssignmentStatement new
		variable: (self scalarVariable: aName) ;
		expression: (self makeSimpleExpression: rhs) ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> callStatement: aName arguments: aCollection [	
	"end position is approximate, test should adjust if a real value is needed"

	^FASTFortran2kCallStatement new
		name: aName ;
		arguments: (aCollection collect: [ :expr | self makeSimpleExpression: expr]) ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> characterLiteral: value [

	^FASTFortran2kCharacterLiteral new
		primitiveValue: value ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> characterType: dimension [
	^FASTFortran2kCharacterType new
		size: (self typeSize: dimension) ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> declarationStatement: name type: typeDescription [ 

	^self declarationStatement: name type: typeDescription init: nil
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> declarationStatement: aName type: typeDescription init: expression [

	| decl |
	decl := (self declarationStatement: (self makeType: typeDescription) variables: { aName }).
	decl declarators anyOne expression: (self makeSimpleExpression: expression).

	^decl
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> declarationStatement: typeDescription variables: aCollection [
	"Bulk declaration of several variables"

	^FASTFortran2kVariableDeclarationStatement new
		declaredType: (self makeType: typeDescription) ;
		declarators: (self variableDeclarators: aCollection)  ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> entity: owner parameters: aCollection [
	^owner
		parameters: (self scalarVariables: aCollection) ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> function: name type: typeDescription [

	ast := self functionDeclaration: name.
	ast declaredType: (self makeType: typeDescription).

	^ast

]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> functionDeclaration: aName [

	^FASTFortran2kFunction new
		name: aName ;
		declaredType: FASTFortran2kRealType new ;
		parameters: {  } ;
		statementBlock: FASTFortran2kStatementBlock new
		yourself.
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> integerLiteral: value [
	^FASTFortran2kIntegerLiteral new
		primitiveValue: value ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> integerType: dimension [
	^FASTFortran2kIntegerType new
		size: (self typeSize: dimension) ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> ioParameter: aName value: expression [

	^FASTFortran2kIOParameter new
		name: aName ;
		expression: (self makeSimpleExpression: expression) ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> ioStatement: aClass ioParams: params arguments: args [

	^aClass new
		ioParameters: (params collect: [:each | self makeSimpleExpression: each]) ;
		arguments: (args collect: [:each | self makeSimpleExpression: each]) ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> logicalIf: condition statement: statement [

	^ FASTFortran2kIfLogicalStatement new
		  condition: (self makeSimpleExpression: condition);
		  statement: statement;
		  yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> logicalLiteral: value [
	^FASTFortran2kBooleanLiteral new
		primitiveValue: value ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> logicalType: dimension [
	^FASTFortran2kLogicalType new
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> makeSimpleExpression: description [

	description ifNil: [ ^nil ].
	(description = '*') ifTrue: [ ^FASTFortran2kAsterisk new ].
	description isInteger ifTrue: [ ^self integerLiteral: description asString ].
	description isFloat ifTrue: [ ^self realLiteral: description asString ].
	description isSymbol ifTrue: [ ^self scalarVariable: description asString ].
	description isString ifTrue: [ ^self characterLiteral: description asString ].
	description isMooseEntity ifTrue: [ ^description ].

	ShouldBeImplemented signal: 'ExpressionDescription: ' , description class name
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> makeType: typeDescription [
	"typeDescription can be a FamixType, a symbol (eg. #integer) or a pair: #(character '*')"

	| helper pair |

	typeDescription isMooseEntity ifTrue: [ ^typeDescription ].

	pair := typeDescription isSymbol
		ifTrue: [ { typeDescription . nil } ]
		ifFalse: [ typeDescription ].

	helper := (pair first asString , 'Type:') asSymbol.
	^self perform: helper with: pair second.	
]

{ #category : 'running' }
FASTFortran2kAbstractVisitorTest >> newVisitor [

	self subclassResponsibility 
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> readStatement: args ioParams: params [

	^self ioStatement: FASTFortran2kReadStatement ioParams: params arguments: args
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> realLiteral: value [

	^FASTFortran2kRealLiteral new
		primitiveValue: value ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> realType: dimension [
	^FASTFortran2kRealType new
		size: (self typeSize: dimension) ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> returnStatement: expressionDescription [

	^FASTFortran2kReturnStatement new
		expression: (self makeSimpleExpression: expressionDescription) ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> scalarVariable: aName [

	^FASTFortran2kScalarVariable new
		name: aName ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> scalarVariables: aCollectionOfString [

	^aCollectionOfString collect: [ :aString | self scalarVariable: aString ]
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> segmentBookDefinition [

	^ FASTFortran2kDerivedTypeDefinition new
		  name: 'book';
		  statements: {
				  (FASTFortran2kVariableDeclarationStatement new
						addDeclarator: (FASTFortran2kVariableDeclarator new name: 'btitle');
					   declaredType: (FASTFortran2kCharacterType new size:
								    (FASTFortran2kIntegerLiteral new primitiveValue: 40));
					   yourself).
				  (FASTFortran2kVariableDeclarationStatement new
						addDeclarator: (FASTFortran2kVariableDeclarator new name: 'bpages');
					   declaredType: FASTFortran2kIntegerType new;
					   yourself).
				  (FASTFortran2kVariableDeclarationStatement new
						addDeclarator: (FASTFortran2kVariableDeclarator new name: 'budc');
					   declaredType: FASTFortran2kRealType new;
					   yourself) };
		  yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> segmentBoxedBookDefinition [

	^ FASTFortran2kDerivedTypeDefinition new
		  name: 'boxed_book';
		  superType: 'segment';
		  statements: {
				  (FASTFortran2kVariableDeclarationStatement new
						addDeclarator: (FASTFortran2kVariableDeclarator new name: 'this');
					   declaredType: (FASTFortran2kUserDefinedType new name: 'book');
						modifiers: #( pointer private ) ;
						yourself
					)
			};
		  yourself
]

{ #category : 'running' }
FASTFortran2kAbstractVisitorTest >> setUp [
	super setUp.

	visitor := self newVisitor
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> statementBlock: aCollection [
	^FASTFortran2kStatementBlock new
		statements: aCollection ;
		yourself
]

{ #category : 'running' }
FASTFortran2kAbstractVisitorTest >> stubFile [

	| stubFile |
	stubFile := Mock named: 'fortranSource.f'.
	stubFile stub asFileReference willReturn: stubFile.
	stubFile stub readStream willReturn: stubFile.
	stubFile stub contents willReturn: ''.

	^stubFile
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> subroutine: aName [

	ast := FASTFortran2kSubroutine new
		name: aName ;
		statementBlock: (self statementBlock: #()) ;
		yourself.

	^ast
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> typeSize: dimension [
	dimension isNumber ifTrue: [ ^self integerLiteral: dimension asString ].
	dimension = '*' ifTrue: [ ^FASTFortran2kAsterisk new ].
	^nil
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> variableDeclarator: aName [
	^FASTFortran2kVariableDeclarator new
		name: aName ;
		yourself
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> variableDeclarators: aCollectionOfString [
	^aCollectionOfString collect: [ :aString | self variableDeclarator: aString ]
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> writeStatement: aCollection [

	^self writeStatement: aCollection ioParams: #( * * )
]

{ #category : 'entity creation' }
FASTFortran2kAbstractVisitorTest >> writeStatement: args ioParams: params [

	^self 
		ioStatement: FASTFortran2kWriteStatement 
		ioParams: params 
		arguments: args
]
