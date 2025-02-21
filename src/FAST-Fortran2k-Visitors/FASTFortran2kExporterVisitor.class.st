"
An exporter for FASTFortran2k models

Note: Inherits from FASTFortranExporterVisitor and not FASTFortran2kAbstractVisitor to reuse the export logic of statements/expressions
"
Class {
	#name : 'FASTFortran2kExporterVisitor',
	#superclass : 'FASTFortranExporterVisitor',
	#traits : 'FASTFortran2kTTraitVisitor',
	#classTraits : 'FASTFortran2kTTraitVisitor classTrait',
	#instVars : [
		'modelIn'
	],
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

{ #category : 'exporting' }
FASTFortran2kExporterVisitor >> export [
	"visiting each file and export it to corresponding f2k file"

	(self model allWithType: FASTFortran2kProgramFile)
		do: [ :programFile | | toFilename |

			toFilename := programFile filename.
			toFilename asFileReference 
				writeStreamDo: [ :aStream | 
					programFile programUnits do: [ :programUnit | 
						programUnit accept: self.
						aStream << self outputStream contents.

						self flag: 'FIXME: It emptied the outputstream to avoid accumulation'.
						self outputStream: (WriteStream with: '') 
					]
				]
		]
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

{ #category : 'accessing' }
FASTFortran2kExporterVisitor >> model [

	^ modelIn
]

{ #category : 'accessing' }
FASTFortran2kExporterVisitor >> model: anObject [

	modelIn := anObject
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
FASTFortran2kExporterVisitor >> sixSpaces [ 
	"marks the start of a new line
	 In superclass (Fortran-77 export) lines need 6 spaces at the start.
	 in Fortran-2k, line are indented more 'naturally' "

	self outputIndentPrefix 
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

{ #category : 'outputting' }
FASTFortran2kExporterVisitor >> upToSixSpaces: preceedingSize [
	"no more mandatory six spaces at the begining of line in Fortran 2k
	 but the method is called by superclass: FASTFortranExporterVisitor
	 We keep the ide of the indent level"

	| nbSpaces |
	nbSpaces := (self indentLevel * 2) - preceedingSize.
	self spaces: nbSpaces
	
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kAbstractExpression: aFASTFortran2kAbstractExpression [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kAbstractIOStatement: aFASTFortran2kAbstractIOStatement [

	self visitList: aFASTFortran2kAbstractIOStatement ioParameters.

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kAbstractLiteral: aFASTFortran2kAbstractLiteral [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kAbstractStatement: aFASTFortran2kAbstractStatement [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kAcceptStatement: aFASTFortran2kAcceptStatement [


	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kAmpersand: aFASTFortran2kAmpersand [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kArrayRange: aFASTFortran2kArrayRange [

	"self visitFASTFortran2kAbstractExpression: aFASTFortran2kArrayRange."
	self acceptMeIfNotNil: aFASTFortran2kArrayRange upperBound.
	self acceptMeIfNotNil: aFASTFortran2kArrayRange lowerBound.
	"self acceptMeIfNotNil: aFASTFortran2kArrayRange parentVariableDeclarator."

]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kArrayVariable: aFASTFortran2kArrayVariable [

	self visitFASTFortranArrayVariable: aFASTFortran2kArrayVariable
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kAssignmentExpression: aFASTFortran2kAssignmentExpression [

	self visitFASTFortranAssignmentExpression: aFASTFortran2kAssignmentExpression
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kAssignmentStatement: aFASTFortran2kAssignmentStatement [

	self indented: ''.
	aFASTFortran2kAssignmentStatement variable accept: self.
	self << ' = '.
	aFASTFortran2kAssignmentStatement expression accept: self.
	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kAsterisk: aFASTFortran2kAsterisk [

	self << '*'
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kAutomaticStatement: aFASTFortran2kAutomaticStatement [


	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kBackspaceStatement: aFASTFortran2kBackspaceStatement [


	self newLine
]

{ #category : 'visiting - expressions' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kBinaryExpression: aFASTFortran2kBinaryExpression [ 

	aFASTFortran2kBinaryExpression leftOperand accept: self.
	self 
		space ;
		<< aFASTFortran2kBinaryExpression operator;
		space.
	aFASTFortran2kBinaryExpression rightOperand accept: self.
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kBlockData: aFASTFortran2kBlockData [

]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kBooleanLiteral: aFASTFortran2kBooleanLiteral [

	self visitFASTFortranBooleanLiteral: aFASTFortran2kBooleanLiteral
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kByteType: aFASTFortran2kByteType [

]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kCallStatement: aFASTFortran2kCallStatement [ 
	self indented: 'call ';
		<< aFASTFortran2kCallStatement name.

	self << '('.
	self visitNodeListSeparatedByCommas: aFASTFortran2kCallStatement arguments.
	self << ')'.
	self newLine
		
]

{ #category : 'visiting - expressions' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kCharacterLiteral: aFASTFortran2kCharacterLiteral [

	self 
		<< '''';
		<< aFASTFortran2kCharacterLiteral primitiveValue;
		<< ''''
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kCharacterType: aFASTFortran2kCharacterType [

	^ self visitFASTFortranCharacterType: aFASTFortran2kCharacterType
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kClassDeclarationStatement: aFASTFortran2kClassDeclarationStatement [

	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kCloseStatement: aFASTFortran2kCloseStatement [

	self visitFASTFortranCloseStatement: aFASTFortran2kCloseStatement
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kComment: aFASTFortran2kComment [

	self 
		indented: '! ';
		<< aFASTFortran2kComment content;
		newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kCommonGroup: aFASTFortran2kCommonGroup [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kCommonStatement: aFASTFortran2kCommonStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kComplexLiteral: aFASTFortran2kComplexLiteral [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kComplexType: aFASTFortran2kComplexType [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kConditionalStatement: aFASTFortran2kConditionalStatement [

	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kContinueStatement: aFASTFortran2kContinueStatement [

	self visitFASTFortranContinueStatement: aFASTFortran2kContinueStatement
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDataGroup: aFASTFortran2kDataGroup [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDataStatement: aFASTFortran2kDataStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDecodeStatement: aFASTFortran2kDecodeStatement [


	self indented: 'decode '.
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kDecodeStatement.
	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDerivedType: aFASTFortran2kDerivedType [

	self << ('type :: ', aFASTFortran2kDerivedType name).
	self indent.
	aFASTFortran2kDerivedType fields 
		do: [ :component |
			component accept: self
		].
	self unindent.
	self << ('end type ', aFASTFortran2kDerivedType name)
	
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDerivedTypeAbstractField: aFASTFortran2kDerivedTypeAbstractField [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDerivedTypeComponent: aFASTFortran2kDerivedTypeComponent [

	^ self visitFASTFortranVariableDeclarationStatement: aFASTFortran2kDerivedTypeComponent
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDerivedTypeComponentAccess: aFASTFortran2kDerivedTypeComponentAccess [

	self acceptMeIfNotNil: aFASTFortran2kDerivedTypeComponentAccess instance.
	self << ' % '.
	self acceptMeIfNotNil: aFASTFortran2kDerivedTypeComponentAccess field.

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDerivedTypeComponentDimension: aFASTFortran2kDerivedTypeComponentDimension [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDerivedTypeDeclaration: aFASTFortran2kDerivedTypeDeclaration [

	^ self visitFASTFortranTypeDeclarationStatement: aFASTFortran2kDerivedTypeDeclaration
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDerivedTypeDefinition: aFASTFortran2kDerivedTypeDefinition [

	self indented: 'type'.

	aFASTFortran2kDerivedTypeDefinition superType ifNotNil: [ :superType |
		self
			<< ', extends(';
			<< superType;
			<< ')' ].

	self
		<< ' :: ';
		<< aFASTFortran2kDerivedTypeDefinition name ;
		newLine.

	self indent.
	aFASTFortran2kDerivedTypeDefinition fields do: [ :derivedTypeComponent |
		derivedTypeComponent accept: self 
	].
	self unindent.

	self
		indented: 'end type ' ;
		<< aFASTFortran2kDerivedTypeDefinition name ;
		newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDimensionStatement: aFASTFortran2kDimensionStatement [

	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDoStatement: aFASTFortran2kDoStatement [

	self visitFASTFortranDoStatement: aFASTFortran2kDoStatement
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDoWhileStatement: aFASTFortran2kDoWhileStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDoubleComplexLiteral: aFASTFortran2kDoubleComplexLiteral [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDoubleComplexType: aFASTFortran2kDoubleComplexType [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDoublePrecisionLiteral: aFASTFortran2kDoublePrecisionLiteral [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kDoublePrecisionType: aFASTFortran2kDoublePrecisionType [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kElseStatement: aFASTFortran2kElseStatement [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kEncodeStatement: aFASTFortran2kEncodeStatement [

	self indented: 'encode '.
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kEncodeStatement.
	self newLine

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kEndFileStatement: aFASTFortran2kEndFileStatement [

	self indented: 'endfile '.
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kEndFileStatement.
	self newLine

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kEntryStatement: aFASTFortran2kEntryStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kEquivalenceGroup: aFASTFortran2kEquivalenceGroup [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kEquivalenceStatement: aFASTFortran2kEquivalenceStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kExitStatement: aFASTFortran2kExitStatement [

	self visitFASTFortranExitStatement: aFASTFortran2kExitStatement.

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kExternalStatement: aFASTFortran2kExternalStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kFieldAccess: aFASTFortran2kFieldAccess [

	self acceptMeIfNotNil: aFASTFortran2kFieldAccess pointer.
	self << ' % '.
	self acceptMeIfNotNil: aFASTFortran2kFieldAccess field.

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kFormatStatement: aFASTFortran2kFormatStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kFormattedCodeString: aFASTFortran2kFormattedCodeString [

	self << (aFASTFortran2kFormattedCodeString content format:
		 aFASTFortran2kFormattedCodeString values)
]

{ #category : 'visiting - programUnits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kFunction: aFASTFortran2kFunction [ 

	aFASTFortran2kFunction declaredType 
		ifNotNil: [ :declaredType | declaredType accept: self ].
	
	self
		<< ' function '
		<< aFASTFortran2kFunction name
		<< '('.
	self visitNodeListSeparatedByCommas: aFASTFortran2kFunction parameters.
	self << ')'.
	self newLine.
	
	aFASTFortran2kFunction statementBlock accept: self.

	self 
		newLine;
		<< 'end function ';
		<< aFASTFortran2kFunction name;
		newLine
	
]

{ #category : 'visiting - expressions' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kFunctionCall: aFASTFortran2kFunctionCall [ 
	self
		<< aFASTFortran2kFunctionCall name;
		<< ' ( '.

	self visitNodeListSeparatedByCommas: aFASTFortran2kFunctionCall arguments.
	self << ' )'
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kFunctionReturnStatement: aFASTFortran2kFunctionReturnStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kFunctionStatement: aFASTFortran2kFunctionStatement [

	self visitFASTFortranFunctionStatement: aFASTFortran2kFunctionStatement.
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kFunctionTypeDeclarationStatement: aFASTFortran2kFunctionTypeDeclarationStatement [

	self visitFASTFortranFunctionTypeDeclarationStatement: aFASTFortran2kFunctionTypeDeclarationStatement
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kGoToAssignedStatement: aFASTFortran2kGoToAssignedStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kGoToComputedStatement: aFASTFortran2kGoToComputedStatement [

	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kGoToStatement: aFASTFortran2kGoToStatement [

	self visitFASTFortranGoToStatement: aFASTFortran2kGoToStatement
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kIModuleProcedureSummary: aFASTFortran2kIModuleProcedureSummary [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kIOParameter: aFASTFortran2kIOParameter [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kIfArithmeticStatement: aFASTFortran2kIfArithmeticStatement [

	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kIfBlockStatement: aFASTFortran2kIfBlockStatement [
	"note: can we have a label on an else line ?"

	self
		indented: 'if ';
		outputExpression: [
			aFASTFortran2kIfBlockStatement condition accept: self ]
		inParentheses: true;
		<< ' then';
		newLine.
	aFASTFortran2kIfBlockStatement thenStatementBlock accept: self.
	aFASTFortran2kIfBlockStatement elseStatementBlock ifNotNil: [ :statementBlock |
		self
			indented: 'else';
			newLine.
		statementBlock accept: self ].
	self
		indented: 'end if';
		newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kIfLogicalStatement: aFASTFortran2kIfLogicalStatement [

	self visitFASTFortranIfLogicalStatement: aFASTFortran2kIfLogicalStatement
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kImplicitRange: aFASTFortran2kImplicitRange [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kImplicitStatement: aFASTFortran2kImplicitStatement [

	self visitFASTFortranImplicitStatement: aFASTFortran2kImplicitStatement 
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kImplicitTypingRule: aFASTFortran2kImplicitTypingRule [

]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kImpliedDoExpression: aFASTFortran2kImpliedDoExpression [

	self visitFASTFortranImpliedDoExpression: aFASTFortran2kImpliedDoExpression
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kImportStatement: aFASTFortran2kImportStatement [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kIncludeStatement: aFASTFortran2kIncludeStatement [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kInquireStatement: aFASTFortran2kInquireStatement [

	self indented: 'inquire '.
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kInquireStatement.
	self newLine

]

{ #category : 'visiting - expressions' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kIntegerLiteral: aFASTFortran2kIntegerLiteral [

	^ self visitFASTFortranIntegerLiteral: aFASTFortran2kIntegerLiteral
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kIntegerType: aFASTFortran2kIntegerType [

	^ self visitFASTFortranIntegerType: aFASTFortran2kIntegerType
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kInterface: aFASTFortran2kInterface [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kInterfaceProcedure: aFASTFortran2kInterfaceProcedure [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kInternalProcedure: aFASTFortran2kInternalProcedure [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kIntrinsicStatement: aFASTFortran2kIntrinsicStatement [

	self indented: 'intrinsic '.
	self visitFASTFortran2kTVariableGroup: aFASTFortran2kIntrinsicStatement.
	self newLine

]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kLabelReference: aFASTFortran2kLabelReference [

	self visitFASTFortranLabelReference: aFASTFortran2kLabelReference
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kLogicalType: aFASTFortran2kLogicalType [

	self visitFASTFortranLogicalType: aFASTFortran2kLogicalType.

]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kLoopControlExpression: aFASTFortran2kLoopControlExpression [

	self visitFASTFortranLoopControlExpression: aFASTFortran2kLoopControlExpression
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kMapStatement: aFASTFortran2kMapStatement [

]

{ #category : 'visiting - programUnits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kModule: aFASTFortranModule [

	| moduleName |
	moduleName := aFASTFortranModule name.

	self
		<< 'module '
		<< moduleName ;
		newLine.
	aFASTFortranModule statementBlock accept: self.
	
	aFASTFortranModule procedures ifNotEmpty: [ :procedures |
		self << 'contains'.
		self
			newLine ;
			indent.
		procedures do: [ :procedure | procedure accept: self ].
		self
			unindent ;
			newLine.
	].
	
	self
		<< 'end module ' ;
		<< moduleName;
		newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kNameEntity: aFASTFortran2kNameEntity [

	self << aFASTFortran2kNameEntity name
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kNameListStatement: aFASTFortran2kNameListStatement [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kNumericalConstant: aFASTFortran2kNumericalConstant [

]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kOpenStatement: aFASTFortran2kOpenStatement [

	self visitFASTFortranOpenStatement: aFASTFortran2kOpenStatement
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kOptionsStatement: aFASTFortran2kOptionsStatement [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kPTVariable: aFASTFortran2kPTVariable [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kParameterStatement: aFASTFortran2kParameterStatement [

	self visitFASTFortranParameterStatement: aFASTFortran2kParameterStatement 
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kPauseStatement: aFASTFortran2kPauseStatement [

	self visitFASTFortranPauseStatement: aFASTFortran2kPauseStatement.

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kPointerAssignmentStatement: aFASTFortran2kPointerAssignmentStatement [

	self indented: ''.
	aFASTFortran2kPointerAssignmentStatement variable accept: self.
	self << ' => '.
	aFASTFortran2kPointerAssignmentStatement expression accept: self.
	self newLine
		
	
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kPointerVariable: aFASTFortran2kPointerVariable [

	self visitFASTFortranScalarVariable: aFASTFortran2kPointerVariable.

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kPragmaStatement: aFASTFortran2kPragmaStatement [

]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kPrintStatement: aFASTFortran2kPrintStatement [ 

	self indented: 'print '.
	
	aFASTFortran2kPrintStatement format accept: self.
	
	self << ', '.
	
	self visitNodeListSeparatedByCommas: aFASTFortran2kPrintStatement arguments.
	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kPrivateStatement: aFASTFortran2kPrivateStatement [

	self indented: 'private '.
	self visitList: aFASTFortran2kPrivateStatement nameEntities.
	self newLine

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kProcedure: aFASTFortran2kProcedure [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kProgramFile: aFASTFortran2kProgramFile [

]

{ #category : 'visiting - programUnits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kProgramMain: aFASTFortran2kProgramNode [

	self
		indented: 'program ' ;
		<< aFASTFortran2kProgramNode name ;
		newLine.
	
	self visitFASTFortranTBehaviouralEntity: aFASTFortran2kProgramNode.
	
	self 
		indented: 'end program ' ;
		<< aFASTFortran2kProgramNode name ;
		newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kProgramUnit: aFASTFortran2kProgramUnit [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kPublicStatement: aFASTFortran2kPublicStatement [

	self indented: 'public '.
	self visitList: aFASTFortran2kPublicStatement nameEntities.
	self newLine

]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kReadStatement: aFASTFortran2kReadStatement [

	self visitFASTFortranReadStatement: aFASTFortran2kReadStatement
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kRealLiteral: aFASTFortran2kRealLiteral [

	self visitFASTFortranRealLiteral: aFASTFortran2kRealLiteral
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kRealType: aFASTFortran2kRealType [

	^ self visitFASTFortranRealType: aFASTFortran2kRealType
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kReturnStatement: aFASTFortran2kReturnStatement [

	self visitFASTFortranReturnStatement: aFASTFortran2kReturnStatement
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kRewindStatement: aFASTFortran2kRewindStatement [

	self indented: 'rewind '.
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kRewindStatement.
	self newLine

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kSaveStatement: aFASTFortran2kSaveStatement [

	self
		indented: 'save';
		newLine
]

{ #category : 'visiting - expressions' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kScalarVariable: aFASTFortran2kScalarVariable [ 

	self 
		<< aFASTFortran2kScalarVariable name
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kSourceCodeString: aFASTFortran2kSourceCodeString [

	self << aFASTFortran2kSourceCodeString content
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kStatementBlock: aFASTFortran2kStatementBlock [

	self indent.
	aFASTFortran2kStatementBlock statements
		ifNotNil:[ :statements |
			statements do: [ :statement | statement accept: self ].
		].
	self unindent
	
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kStaticStatement: aFASTFortran2kStaticStatement [

	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kStopStatement: aFASTFortran2kStopStatement [

	self visitFASTFortranStopStatement: aFASTFortran2kStopStatement
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kSubprogram: aFASTFortran2kSubprogram [

]

{ #category : 'visiting - programUnits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kSubroutine: aFASTFortran2kSubroutine [ 
	self
		indented: 'subroutine ';
		<< aFASTFortran2kSubroutine name.
		
	self visitFASTFortranTWithParameters: aFASTFortran2kSubroutine.

	self newLine.

	self visitFASTFortranTBehaviouralEntity: aFASTFortran2kSubroutine.
	
	self 
		<< 'end subroutine ';
		<< aFASTFortran2kSubroutine name;
		newLine
		
	
	
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kSubstring: aFASTFortran2kSubstring [

]

{ #category : 'visiting - traits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kTDeclaration: aFASTFortran2kTDeclaration [

]

{ #category : 'visiting - traits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kTDeclaredType: aFASTFortran2kTDeclaredType [

]

{ #category : 'visiting - traits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kTEntryArgument: aFASTFortran2kTEntryArgument [

]

{ #category : 'visiting - traits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kTFormat: aFASTFortran2kTFormat [

]

{ #category : 'visiting - traits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kTIOParameter: aFASTFortran2kTIOParameter [

]

{ #category : 'visiting - traits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kTPointerAssignment: aFASTFortran2kTPointerAssignment [

]

{ #category : 'visiting - traits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kTVariableGroup: aFASTFortran2kTVariableGroup [

]

{ #category : 'visiting - traits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kTWithDeclarations: aFASTFortran2kTWithDeclarations [

]

{ #category : 'visiting - traits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kTWithDeclarators: aFASTFortran2kTWithDeclarators [

]

{ #category : 'visiting - traits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kTWithFormat: aFASTFortran2kTWithFormat [

]

{ #category : 'visiting - traits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kTWithLabelReferences: aFASTFortran2kTWithLabelReferences [

]

{ #category : 'visiting - traits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kTWithLoopControl: aFASTFortran2kTWithLoopControl [

]

{ #category : 'visiting - traits' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kTWithVariableGroups: aFASTFortran2kTWithVariableGroups [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kTargetVariable: aFASTFortran2kTargetVariable [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kType: aFASTFortran2kType [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kTypeBoundProcedure: aFASTFortran2kTypeBoundProcedure [

]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kTypePBFinal: aFASTFortran2kTypePBFinal [

]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kUnaryExpression: aFASTFortran2kUnaryExpression [

	self visitFASTFortranUnaryExpression: aFASTFortran2kUnaryExpression
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kUnionStatement: aFASTFortran2kUnionStatement [

	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kUseNoRenamedStatement: aFASTFortran2kUseNoRenamedStatement [

	self indented: aFASTFortran2kUseNoRenamedStatement name
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kUseOnlyStatement: aFASTFortran2kUseOnlyStatement [ 
	self
		indented: 'use :: ';
		<< aFASTFortran2kUseOnlyStatement name;
		<< ', only: '.

	self visitNodeListSeparatedByCommas: aFASTFortran2kUseOnlyStatement useNoRenamedStatements.
	
	aFASTFortran2kUseOnlyStatement useRenamedStatements ifNotNil: [ :useRenamedStatements |  
		useRenamedStatements ifNotEmpty: [ 
			self << ', '.
			self visitNodeListSeparatedByCommas: useRenamedStatements 
		] 
	].
	self newLine 
	
	
	 
	
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kUseRenamedStatement: aFASTFortran2kUseRenamedStatement [

	self
		<< aFASTFortran2kUseRenamedStatement alias;
		<< ' => ';
		<< aFASTFortran2kUseRenamedStatement name
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kUseStatement: aFASTFortran2kUseStatement [

	self << 'use'.
	"aFASTFortran2kUseStatement isIntrinsic ifTrue: [
		self << ', intrinsic' ]."
	self
		<< ' :: ';
		<< aFASTFortran2kUseStatement name.

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

	self
		<< 'type(';
		<< aFASTFortran2kUserDefinedType name;
		<< ')'
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kVariable: aFASTFortran2kVariable [

	self visitFASTFortranVariable: aFASTFortran2kVariable 
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kVariableDeclarationStatement: aFASTFortran2kVariableDeclarationStatement [

	| comma |

	self visitFASTFortranAbstractStatement: aFASTFortran2kVariableDeclarationStatement.
	aFASTFortran2kVariableDeclarationStatement declaredType accept: self.

	comma := ''.
	"aFASTFortranVariableDeclarationStatement isPointer ifTrue: [ self << comma ; << ' pointer'. comma := ',' ].
	aFASTFortranVariableDeclarationStatement visibility ifNotNil: [ :viz | self << comma ; << viz. comma := ',' ]. "
	self flag: #TODO. "aFASTFortranVariableDeclarationStatement isTarget ifTrue: [ :viz | self << comma ; << ' target'. comma := ',' ]. "
	
	self << ' :: '.
	self visitNodeListSeparatedByCommas:
		aFASTFortran2kVariableDeclarationStatement declarators.
	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kVariableDeclarator: aFASTFortran2kVariableDeclarator [

	^ self visitFASTFortranVariableDeclarator: aFASTFortran2kVariableDeclarator
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kVirtualStatement: aFASTFortran2kVirtualStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kVolatileStatement: aFASTFortran2kVolatileStatement [

	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortran2kWriteStatement: aFASTFortran2kWriteStatement [

	self visitFASTFortranWriteStatement: aFASTFortran2kWriteStatement
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortranAttribute: aFASTFortran2kAttribute [

	^ self visitFASTFortranVariableDeclarationStatement: aFASTFortran2kAttribute
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortranColon: aFASTFortran2kColon [

	self << '(len=:)'
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortranTBehaviouralEntity: aFASTFortranTBehaviouralEntity [

	aFASTFortranTBehaviouralEntity statementBlock 
		ifNotNil: [ aFASTFortranTBehaviouralEntity statementBlock accept: self ]
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortranTReturnStatement: aFASTFortranTReturnStatement [

	self
		visitFASTFortranAbstractStatement: aFASTFortranTReturnStatement;
		<< 'return '.
	aFASTFortranTReturnStatement expression ifNotNil: [ :expr |
		expr accept: self ].
	self newLine
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortranType: aFASTFortran2kType [

	aFASTFortran2kType size 
		ifNotNil: [ :length |
				self << '(len='.
				length class = FASTFortran2kAsterisk
					ifTrue: [ self << '*)' ]
					ifFalse: [
						length accept: self.
						self << ')'
					]
		]
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortranTypeDeclarationStatement: aFASTFortran2kTypeDeclarationStatement [

	self indented: 'type ('.
	self visitFASTFortranUserDefinedType: aFASTFortran2kTypeDeclarationStatement declaredType.
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

	self
		<< anEntity localName ;
	 	<< ' => ' ;
		<< anEntity name
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTFortranUserDefinedType: aFASTFortran2kUserDefinedType [

	self << aFASTFortran2kUserDefinedType name
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	| comma |

	self visitFASTFortranAbstractStatement:
		aFASTFortranVariableDeclarationStatement.
	aFASTFortranVariableDeclarationStatement declaredType accept: self.

	comma := ''.
	"aFASTFortranVariableDeclarationStatement isPointer ifTrue: [ self << comma ; << ' pointer'. comma := ',' ].
	aFASTFortranVariableDeclarationStatement visibility ifNotNil: [ :viz | self << comma ; << viz. comma := ',' ]. "
	self flag: #TODO. "aFASTFortranVariableDeclarationStatement isTarget ifTrue: [ :viz | self << comma ; << ' target'. comma := ',' ]. "
	
	self << ' :: '.
	self visitNodeListSeparatedByCommas:
		aFASTFortranVariableDeclarationStatement declarators.
	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kExporterVisitor >> visitFASTFortranVariableDeclarator: aFASTFortran2kVariableDeclarator [

	^ super visitFASTFortranVariableDeclarator: aFASTFortran2kVariableDeclarator
]

{ #category : 'visiting' }
FASTFortran2kExporterVisitor >> visitFASTTEntity: aFASTTEntity [
	^ aFASTTEntity children do: [ :child | child accept: self ]
]

{ #category : 'visiting - expressions' }
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
