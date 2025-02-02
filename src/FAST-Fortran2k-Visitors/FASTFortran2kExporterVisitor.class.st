"
An exporter for FASTFortran2k models

Note: Inherits from FASTFortranExporterVisitor and not FASTFortran2kAbstractVisitor to reuse the export logic of statements/expressions
"
Class {
	#name : 'FASTFortran2kExporterVisitor',
	#superclass : 'FASTFortranExporterVisitor',
	#traits : 'FASTTExporter',
	#classTraits : 'FASTTExporter classTrait',
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'outputting' }
FASTFortran2kExporterVisitor >> << aPrintable [
	"syntactical sugar"

	self output: aPrintable
]

{ #category : 'precedence' }
FASTFortran2kExporterVisitor >> defaultOperatorsPrecedence [
	"operatorsPrecedence is a dictionary: operator -> precedence for all possible operators
	Higher number means higher precedence
	the same operator can be entered in different forms (eg: #add and #'+')
	
	The value here are examples but should be correct for many languages.
	They fit C/Java operators definition.
	The gaps in precedence values allow to introduce other operators if needed.
	And the precedences value can also be changed.

	The last one (#topLevelExpression) is introduced to deal with expressions within other expressions
	For example in `1 * someFunction(2 + 3)` , '*' has no precedence over '+', but because the check
	(see #lowerPrecedence:) uses a global expression stack, it could get confused.
	The solution is to push #topLevelExpression on the stack at the start of a new expression (here
	'2 + 3')"

	^{
		"unary postfix operators"
		#'unary++' -> 120 .
		#'unary--' -> 120 .

		"unary prefix operators
		 cannot be just the operator itself because '-' would be confused with the binary '-'"
		#'++unary' -> 110 .
		#'--unary' -> 110 .
		#'+unary' -> 110 .
		#'-unary' -> 110 .

		#'!' -> 110 .
		#'!unary' -> 110.
		#not -> 110 .
		
		"cast"
		#cast -> 100 .

		"multiplicative operators"
		#'*' -> 90 .
		#times -> 90 .
		#'/' -> 90 .
		#divide -> 90 .
		#'%' -> 90 .
		#mod -> 90 .
	
		"stringConcatenationOperator -- needed to deal with: String+(i+1)"
		#concat -> 80 .

		"additive operators"
		#'+' -> 70 .
		#add -> 70 .
		#'-' -> 70 .
		#minus -> 70 .

		"relational operators"
		#'<' -> 60 .
		#lt -> 60 .
		#lessThan -> 60 .

		#'>' -> 60 .
		#gt -> 60 .
		#greaterThan -> 60 .

		#'<=' -> 60 .
		#le -> 60 .
		#lessEqual -> 60 .

		#'>=' -> 60 .
		#ge -> 60 .
		#greaterEqual -> 60 .

		"equality operators"
		#'==' -> 50 .
		#eq -> 50 .
		#equal -> 50 .

		#'!=' -> 50 .
		#ne -> 50 .
		#notEqual -> 50 .

		"logical And operators"
		#'&&' -> 40 .
		#and -> 40 .

		"logical Or operators"
		#'||' -> 30 .
		#or -> 30 .

		"ternary operator"
		#'?:' -> 20 .

		"assignment operators"
		#'=' ->  10 .
		#'+=' -> 10 .
		#'-=' -> 10 .
		#'*=' -> 10 .
		#'/=' -> 10 .

		#topLevelExpression -> 0
	}
]

{ #category : 'precedence' }
FASTFortran2kExporterVisitor >> expressionContextOperator [
	"lazy accessor"

	^expressionContextOperator ifNil: [ expressionContextOperator := Stack new ].

]

{ #category : 'outputting' }
FASTFortran2kExporterVisitor >> indent [

	^indentLevel := self indentLevel + 1
]

{ #category : 'accessing' }
FASTFortran2kExporterVisitor >> indentLevel [

	^ indentLevel ifNil: [ indentLevel := 0 ]
]

{ #category : 'outputting' }
FASTFortran2kExporterVisitor >> indentSize [

	^  indentSize ifNil: [ indentSize := 2 ]
]

{ #category : 'accessing' }
FASTFortran2kExporterVisitor >> indentSize: anObject [

	indentSize := anObject
]

{ #category : 'outputting' }
FASTFortran2kExporterVisitor >> indented: aPrintable [

	self outputIndentPrefix.
	self unindented: aPrintable
]

{ #category : 'precedence' }
FASTFortran2kExporterVisitor >> languageOperatorsPrecedence [
	"this methods gives a chance to redefine precedence in different languages

	specific language exporters should redefine it and make changes to the #operatorsPrecedence Dictionary"

]

{ #category : 'precedence' }
FASTFortran2kExporterVisitor >> lowerPrecedence: operator [
	"check whether #operator has lower precedence than a surounding expression (top of
	expressionContextOperator)
	If so, the current expression will need to be parenthesized"

	^self expressionContextOperator
		ifEmpty: [ false ]
		ifNotEmpty: [ :operatorStack |
			(self operatorPrecedence: operator) < (self operatorPrecedence: operatorStack top)]
]

{ #category : 'outputting' }
FASTFortran2kExporterVisitor >> newLine [

	self outputStream cr
]

{ #category : 'precedence' }
FASTFortran2kExporterVisitor >> operatorPrecedence: operator [

	^self operatorsPrecedence at: operator asSymbol
]

{ #category : 'precedence' }
FASTFortran2kExporterVisitor >> operatorsPrecedence [
	"lazy accessor"

	^operatorsPrecedence ifNil: [
			operatorsPrecedence := Dictionary newFrom: self defaultOperatorsPrecedence.
			self languageOperatorsPrecedence.
			operatorsPrecedence ]
]

{ #category : 'outputting' }
FASTFortran2kExporterVisitor >> output: aPrintable [

	self outputStream << aPrintable
]

{ #category : 'precedence' }
FASTFortran2kExporterVisitor >> outputExpression: aBlock inParentheses: aBoolean [
	"executes aBlock to output some expression, putting it within parenthesis if needed"

	aBoolean ifTrue: [ self output: '(' ].
	aBlock value.
	aBoolean ifTrue: [ self output: ')' ]
]

{ #category : 'precedence' }
FASTFortran2kExporterVisitor >> outputExpression: aBlock withOperator: operator [
	"execute aBlock possibly putting parenthesis around the result depending on the precedence of #operator
	 But before executing a block, we need to push the operator on the context stack so that 
	 precedence of possible sub-expressions be compared to it"

	self
		outputExpression: [
			self expressionContextOperator push: operator.
			aBlock value.
			self expressionContextOperator pop
		]
		 inParentheses: (self lowerPrecedence: operator)
]

{ #category : 'outputting' }
FASTFortran2kExporterVisitor >> outputIndentPrefix [
	"prints indentation spaces"

	self spaces: self indentLevel * self indentSize
]

{ #category : 'outputting' }
FASTFortran2kExporterVisitor >> outputStream [
	"lazy accessor"

	^outputStream ifNil: [ outputStream := WriteStream on: '' ]
]

{ #category : 'outputting' }
FASTFortran2kExporterVisitor >> outputStream: anOutputStream [

	^ outputStream := anOutputStream
]

{ #category : 'precedence' }
FASTFortran2kExporterVisitor >> outputTopLevelExpression: aBlock [
	"Execute aBlock to output an expression.
	 Puts special symbol on the expressionContextOperator stack to indicate the start of a
	 new expression

	See comment in #initializeOperatorsPrecedence"

	self expressionContextOperator push: #topLevelExpression.
	aBlock value.
	self expressionContextOperator pop
]

{ #category : 'outputting' }
FASTFortran2kExporterVisitor >> space [

	self output: String space
]

{ #category : 'outputting' }
FASTFortran2kExporterVisitor >> spaces: n [

	n timesRepeat: [ self space ]
]

{ #category : 'outputting' }
FASTFortran2kExporterVisitor >> unindent [

	(self indentLevel <= 0) ifTrue: [ ^indentLevel := 0 ].
	^indentLevel := self indentLevel - 1
]

{ #category : 'outputting' }
FASTFortran2kExporterVisitor >> unindented: aPrintable [

	self output: aPrintable
]

{ #category : 'precedence' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDerivedType: aFASTFortran2kDerivedType [

	self << ('type :: ', aFASTFortran2kDerivedType name).
	aFASTFortran2kDerivedType derivedTypeComponents 
		do: [ :component |
			component accept: self
		].
	self << ('end type ', aFASTFortran2kDerivedType name)
	
]

{ #category : 'precedence' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDerivedTypeComponent: aFASTFortran2kDerivedTypeComponent [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kFormattedCodeString: aFASTFortran2kFormattedCodeString [

	self << (aFASTFortran2kFormattedCodeString content format:
		 aFASTFortran2kFormattedCodeString values)
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kModule: aFASTFortranModule [

	| moduleName |
	moduleName := aFASTFortranModule name.

	self
		<< ('module ' , moduleName);
		newLine.
	aFASTFortranModule statementBlock ifNotNil: [ :statementBlock |
		statementBlock statements do: [ :each | each accept: self ] ].
	self
		<< ('end module ' , moduleName);
		newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kProgramMain: aFASTFortran2kProgramNode [

	self
		<< 'program ';
		<< aFASTFortran2kProgramNode name;
		newLine.
	
	self visitFASTFortranTBehaviouralEntity: aFASTFortran2kProgramNode.
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kSourceCodeString: aFASTFortran2kSourceCodeString [

	self << aFASTFortran2kSourceCodeString content
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kUseStatement: aFASTFortran2kUseStatement [

	self << 'use'.
	aFASTFortran2kUseStatement isIntrinsic ifTrue: [
		self << ', intrinsic' ].
	self
		<< ' :: ';
		<< aFASTFortran2kUseStatement moduleName.

	aFASTFortran2kUseStatement useRenamedStatements 
		ifNotNil: [:useRenamedStatement | 
			self << ', '.
			self visitNodeListSeparatedByCommas: useRenamedStatement
		].

	aFASTFortran2kUseStatement useNoRenamedStatements 
		ifNotNil: [ :onlyList |
			self << ', only: '.
			self visitNodeListSeparatedByCommas: onlyList.
		].

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kUserDefinedType: aFASTFortran2kUserDefinedType [

	self << 'type(';
		<< aFASTFortran2kUserDefinedType name;
		<< ')'
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortranAttribute: aFASTFortran2kAttribute [

	^ self visitFASTFortranVariableDeclarationStatement:
		  aFASTFortran2kAttribute
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortranColon: aFASTFortran2kColon [

	self << '(len=:)'
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortranDerivedType: aFASTFortran2kDerivedType [

	self << 'type'.

	aFASTFortran2kDerivedType superType ifNotNil: [ :superType |
		self
			<< ', extends(';
			<< superType;
			<< ')' ].

	self
		<< ' :: ';
		<< aFASTFortran2kDerivedType name.
	self newLine.

	aFASTFortran2kDerivedType attributes do: [ :attribute |
		attribute accept: self ].

	self
		<< 'end type ';
		<< aFASTFortran2kDerivedType name;
		newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortranTBehaviouralEntity: aFASTFortranTBehaviouralEntity [

	aFASTFortranTBehaviouralEntity statementBlock 
	ifNotNil: [ 
		aFASTFortranTBehaviouralEntity statementBlock statements 
			do: [ :statement | statement accept: self ]
	].
	self
		<< 'end program ';
		<< aFASTFortranTBehaviouralEntity name;
		newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortranType: aFASTFortran2kType [

	aFASTFortran2kType size 
		ifNotNil: [ :length |
				length class = FASTFortran2kAsterisk
					ifTrue: [ self << '(len=*)' ]
					ifFalse: [ length accept: self ] 
		]
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortranTypeDeclarationStatement: aFASTFortran2kTypeDeclarationStatement [

	self sixSpaces.
	self << 'type ('.
	self visitFASTFortranUserDefinedType: aFASTFortran2kTypeDeclarationStatement type.
	self << ')'.
	self << ' :: '.

	aFASTFortran2kTypeDeclarationStatement declarators 
		ifNotNil: [ :declarators | self visitNodeListSeparatedByCommas: declarators ].
	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortranUsedEntity: aFASTFortran2kUsedEntity [

	self << aFASTFortran2kUsedEntity name
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortranUsedEntityRenamed: anEntity [

	self << (anEntity localName , ' => ' , anEntity name)
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortranUserDefinedType: aFASTFortran2kUserDefinedType [

	self << aFASTFortran2kUserDefinedType name
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	| comma |

	self visitFASTFortranAbstractStatement:
		aFASTFortranVariableDeclarationStatement.
	aFASTFortranVariableDeclarationStatement type accept: self.

	comma := ''.
	"aFASTFortranVariableDeclarationStatement isPointer ifTrue: [ self << comma ; << ' pointer'. comma := ',' ].
	aFASTFortranVariableDeclarationStatement visibility ifNotNil: [ :viz | self << comma ; << viz. comma := ',' ]. "
	self flag: #TODO. "aFASTFortranVariableDeclarationStatement isTarget ifTrue: [ :viz | self << comma ; << ' target'. comma := ',' ]. "
	
	self << ' :: '.
	self visitNodeListSeparatedByCommas:
		aFASTFortranVariableDeclarationStatement declarators.
	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortranVariableDeclarator: aFASTFortran2kVariableDeclarator [

	^ super visitFASTFortranVariableDeclarator: aFASTFortran2kVariableDeclarator
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTTEntity: aFASTTEntity [
	^ aFASTTEntity children do: [ :child | child accept: self ]
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTTNumericalLiteral: aFASTTNumericalLiteral [

	self
		<< '(len=';
		<< aFASTTNumericalLiteral primitiveValue asString;
		<< ')'
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitNodeListSeparatedByCommas: aCollection [

	aCollection
		do: [ :node | node accept: self ]
		separatedBy: [ self << ', ' ]
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> vititFASTFortranVariableDeclarator: aFASTFortran2kVariableDeclarator [

	^ aFASTFortran2kVariableDeclarator name
]
