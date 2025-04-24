"
An exporter for FASTFortran2kProgramFile
The result is in `outputStream`

Note: Inherits from FASTFortranExporterVisitor and not FASTFortran2kAbstractVisitor to reuse the export logic of statements/expressions
"
Class {
	#name : 'FASTFortran2kProgramFileExporterVisitor',
	#superclass : 'FASTFortranExporterVisitor',
	#traits : 'FASTFortran2kTTraitVisitor',
	#classTraits : 'FASTFortran2kTTraitVisitor classTrait',
	#instVars : [
		'modelIn',
		'linesDescription'
	],
	#classVars : [
		'ModernRelationalOperators'
	],
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'outputting' }
FASTFortran2kProgramFileExporterVisitor >> end: programUnit named: aName [

	self
		indented: 'end ' ;
		<< programUnit ;
		<< String space ;
		<< aName;
		newLine ;
		newLine
]

{ #category : 'initialization' }
FASTFortran2kProgramFileExporterVisitor >> initialize [ 

	super initialize.

	self breakLongLines: false.
	linesDescription := #().
]

{ #category : 'accessing - private tests' }
FASTFortran2kProgramFileExporterVisitor >> linesDescription: aCollection [

	linesDescription := aCollection
]

{ #category : 'accessing' }
FASTFortran2kProgramFileExporterVisitor >> model [

	^ modelIn
]

{ #category : 'accessing' }
FASTFortran2kProgramFileExporterVisitor >> model: anObject [

	modelIn := anObject
]

{ #category : 'initialization' }
FASTFortran2kProgramFileExporterVisitor >> modernRelationalOperators [

	^ModernRelationalOperators ifNil: [	
		ModernRelationalOperators := { 
			'.eq.'  -> '==' .
			'.ne.'  -> '/=' .
			'.gt.'  -> '>' .
			'.lt.'  -> '<' .
			'.ge.'  -> '>=' .
			'.le.'  -> '<='
		} asDictionary
	]
]

{ #category : 'outputting' }
FASTFortran2kProgramFileExporterVisitor >> setLineDescriptions: aFilename [
	"For each line, creates a description consisting of 
	 last-position in the line -> whether the line is empty"

	| filecontent spaces |

	spaces := String tab , String space.
	filecontent := aFilename asFileReference readStream contents.

	"heuristic to guess the number of lines, assuming an average of 20 characters per line"
	linesDescription := OrderedCollection new: (filecontent size // 20).
	
	filecontent lineIndicesDo: [ :start :end :endWithCr || emptyLine |
		emptyLine := true.
		filecontent from: start to: end do: [ :char |
			(spaces includes: char) ifFalse: [ emptyLine := false ] ].
		linesDescription add: (endWithCr -> emptyLine)
	]
]

{ #category : 'outputting' }
FASTFortran2kProgramFileExporterVisitor >> skipLine: entity [
	"if line before anEntity is empty then produce an empty line
	 For this, we need the end position of the 2 lines before the entity (line-1 and line-2)
	 (and difference should be < 2 because the carriage-return is included"

	| previousLine |
	entity startPos ifNil: [ ^self ].

	previousLine := (0 -> false).
	linesDescription do: [ :lineDescriptor |
		(lineDescriptor key > entity startPos)
			ifTrue: [
				previousLine value ifTrue: [ self newLine ].
				^self
			].
		previousLine := lineDescriptor 
	]

]

{ #category : 'outputting' }
FASTFortran2kProgramFileExporterVisitor >> upToSixSpaces: preceedingSize [
	"no more mandatory six spaces at the begining of line in Fortran 2k
	 but the method is called by superclass: FASTFortranExporterVisitor
	 We keep the idea of the indent level"

	| nbSpaces |
	nbSpaces := (self indentLevel * 2) - preceedingSize.
	self spaces: nbSpaces
	
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kAbstractExpression: aFASTFortran2kAbstractExpression [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kAbstractIOStatement: aFASTFortran2kAbstractIOStatement [

	self visitList: aFASTFortran2kAbstractIOStatement ioParameters.

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kAbstractLiteral: aFASTFortran2kAbstractLiteral [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kAbstractStatement: aFASTFortran2kAbstractStatement [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kAcceptStatement: aFASTFortran2kAcceptStatement [


	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kAmpersand: aFASTFortran2kAmpersand [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kArrayRange: aFASTFortran2kArrayRange [
	"not sure whether '(:)' is used in old Fortran.
	 But it is needed in Fortran2k"

	aFASTFortran2kArrayRange upperBound ifNil: [
		self << ':'.
		^self
	].

	self visitFASTFortranArrayRange: aFASTFortran2kArrayRange
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kArrayVariable: aFASTFortran2kArrayVariable [

	self visitFASTFortranArrayVariable: aFASTFortran2kArrayVariable
]

{ #category : 'visiting - expressions' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kAssignmentExpression: aFASTFortran2kAssignmentExpression [

	self visitFASTFortranAssignmentExpression: aFASTFortran2kAssignmentExpression
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kAssignmentStatement: aFASTFortran2kAssignmentStatement [

	self skipLine: aFASTFortran2kAssignmentStatement.

	self indented: ''.
	aFASTFortran2kAssignmentStatement variable accept: self.
	self << ' = '.
	aFASTFortran2kAssignmentStatement expression accept: self.
	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kAsterisk: aFASTFortran2kAsterisk [

	self << '*'
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kAutomaticStatement: aFASTFortran2kAutomaticStatement [


	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kBackspaceStatement: aFASTFortran2kBackspaceStatement [


	self newLine
]

{ #category : 'visiting - expressions' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kBinaryExpression: aFASTFortran2kBinaryExpression [ 

	aFASTFortran2kBinaryExpression leftOperand accept: self.
	self 
		space ;
		<< (self modernRelationalOperators 
				at: aFASTFortran2kBinaryExpression operator
				ifAbsent: [ aFASTFortran2kBinaryExpression operator ] 
		);
		space.
	aFASTFortran2kBinaryExpression rightOperand accept: self.
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kBlockData: aFASTFortran2kBlockData [

]

{ #category : 'visiting - expressions' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kBooleanLiteral: aFASTFortran2kBooleanLiteral [

	self visitFASTFortranBooleanLiteral: aFASTFortran2kBooleanLiteral
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kByteType: aFASTFortran2kByteType [

]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kCallStatement: aFASTFortran2kCallStatement [ 


	self skipLine: aFASTFortran2kCallStatement.

	self indented: 'call ';
		<< aFASTFortran2kCallStatement name.

	self << '('.
	self visitNodeListSeparatedByCommas: aFASTFortran2kCallStatement arguments.
	self << ')'.
	self newLine
		
]

{ #category : 'visiting - expressions' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kCharacterLiteral: aFASTFortran2kCharacterLiteral [

	self 
		<< '''';
		<< aFASTFortran2kCharacterLiteral primitiveValue;
		<< ''''
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kCharacterType: aFASTFortran2kCharacterType [

	^ self visitFASTFortranCharacterType: aFASTFortran2kCharacterType
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kClassDeclarationStatement: aFASTFortran2kClassDeclarationStatement [

	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kCloseStatement: aFASTFortran2kCloseStatement [

	self visitFASTFortranCloseStatement: aFASTFortran2kCloseStatement
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kComment: aFASTFortran2kComment [

	self skipLine: aFASTFortran2kComment.

	self 
		indented: '! ';
		<< aFASTFortran2kComment content;
		newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kCommonGroup: aFASTFortran2kCommonGroup [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kCommonStatement: aFASTFortran2kCommonStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kComplexLiteral: aFASTFortran2kComplexLiteral [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kComplexType: aFASTFortran2kComplexType [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kConditionalStatement: aFASTFortran2kConditionalStatement [

	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kContinueStatement: aFASTFortran2kContinueStatement [

	self visitFASTFortranContinueStatement: aFASTFortran2kContinueStatement
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDataGroup: aFASTFortran2kDataGroup [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDataStatement: aFASTFortran2kDataStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDecodeStatement: aFASTFortran2kDecodeStatement [


	self indented: 'decode '.
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kDecodeStatement.
	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDerivedType: aFASTFortran2kDerivedType [

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
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDerivedTypeAbstractField: aFASTFortran2kDerivedTypeAbstractField [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDerivedTypeComponent: aFASTFortran2kDerivedTypeComponent [

	self indented: ''.
	aFASTFortran2kDerivedTypeComponent declaredType accept: self.
	
	aFASTFortran2kDerivedTypeComponent modifiers 
		ifNotEmpty: [ :modifiers | 
			self << ', '.
			self visitNodeListSeparatedByCommas: modifiers
	].

	self << ' :: '.

	self 
		<< aFASTFortran2kDerivedTypeComponent name;
		newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDerivedTypeComponentAccess: aFASTFortran2kDerivedTypeComponentAccess [

	self acceptMeIfNotNil: aFASTFortran2kDerivedTypeComponentAccess instance.
	self << ' % '.
	self acceptMeIfNotNil: aFASTFortran2kDerivedTypeComponentAccess field.

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDerivedTypeComponentDimension: aFASTFortran2kDerivedTypeComponentDimension [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDerivedTypeDeclaration: aFASTFortran2kDerivedTypeDeclaration [

	^ self visitFASTFortranTypeDeclarationStatement: aFASTFortran2kDerivedTypeDeclaration
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDerivedTypeDefinition: aFASTFortran2kDerivedTypeDefinition [

	self
		indented: 'public ' ;
		<< aFASTFortran2kDerivedTypeDefinition name ;
		newLine ;
		indented: 'type'.

	self visitFASTFortran2kModifiers: aFASTFortran2kDerivedTypeDefinition modifiers.

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
	aFASTFortran2kDerivedTypeDefinition statements 
		do: [ :statement | statement accept: self ].
	self unindent.

	self
		indented: 'end type ' ;
		<< aFASTFortran2kDerivedTypeDefinition name ;
		newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDimensionStatement: aFASTFortran2kDimensionStatement [

	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDoStatement: aFASTFortran2kDoStatement [

	self visitFASTFortranDoStatement: aFASTFortran2kDoStatement
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDoWhileStatement: aFASTFortran2kDoWhileStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDoubleComplexLiteral: aFASTFortran2kDoubleComplexLiteral [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDoubleComplexType: aFASTFortran2kDoubleComplexType [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDoublePrecisionLiteral: aFASTFortran2kDoublePrecisionLiteral [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kDoublePrecisionType: aFASTFortran2kDoublePrecisionType [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kElseStatement: aFASTFortran2kElseStatement [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kEmptyStatement: aFASTFortran2kEmptyStatement [ 

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kEncodeStatement: aFASTFortran2kEncodeStatement [

	self indented: 'encode '.
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kEncodeStatement.
	self newLine

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kEndFileStatement: aFASTFortran2kEndFileStatement [

	self indented: 'endfile '.
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kEndFileStatement.
	self newLine

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kEntryStatement: aFASTFortran2kEntryStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kEquivalenceGroup: aFASTFortran2kEquivalenceGroup [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kEquivalenceStatement: aFASTFortran2kEquivalenceStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kExitStatement: aFASTFortran2kExitStatement [

	self visitFASTFortranExitStatement: aFASTFortran2kExitStatement.

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kExternalStatement: aFASTFortran2kExternalStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kFieldAccess: aFASTFortran2kFieldAccess [

	self acceptMeIfNotNil: aFASTFortran2kFieldAccess pointer.
	self << ' % '.
	self acceptMeIfNotNil: aFASTFortran2kFieldAccess field.

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kFormatStatement: aFASTFortran2kFormatStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kFormattedCodeString: aFASTFortran2kFormattedCodeString [

	self 
		skipLine: aFASTFortran2kFormattedCodeString ;
		indented: '' ; 
		<< (aFASTFortran2kFormattedCodeString content format:
		 aFASTFortran2kFormattedCodeString values);
		newLine
]

{ #category : 'visiting - programUnits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kFunction: aFASTFortran2kFunction [ 

	aFASTFortran2kFunction backTrace 
		ifNotNil: [ self setLineDescriptions: aFASTFortran2kFunction backTrace ].

	self indented: ''.

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
		end: 'function' named: aFASTFortran2kFunction name
]

{ #category : 'visiting - expressions' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kFunctionCall: aFASTFortran2kFunctionCall [

	self
		<< aFASTFortran2kFunctionCall name;
		<< '( '.

	self visitNodeListSeparatedByCommas: aFASTFortran2kFunctionCall arguments.
	self << ')'
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kFunctionCallStatement: aFASTFortran2kFunctionCallStatement [ 

	self skipLine: aFASTFortran2kFunctionCallStatement.

	self 
		indented: '';
		visitFASTFortran2kFunctionCall: aFASTFortran2kFunctionCallStatement;
		newLine 
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kFunctionReturnStatement: aFASTFortran2kFunctionReturnStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kFunctionStatement: aFASTFortran2kFunctionStatement [

	self visitFASTFortranFunctionStatement: aFASTFortran2kFunctionStatement.
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kFunctionTypeDeclarationStatement: aFASTFortran2kFunctionTypeDeclarationStatement [

	self visitFASTFortranFunctionTypeDeclarationStatement: aFASTFortran2kFunctionTypeDeclarationStatement
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kGoToAssignedStatement: aFASTFortran2kGoToAssignedStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kGoToComputedStatement: aFASTFortran2kGoToComputedStatement [

	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kGoToStatement: aFASTFortran2kGoToStatement [

	self visitFASTFortranGoToStatement: aFASTFortran2kGoToStatement
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kIModuleProcedureSummary: aFASTFortran2kIModuleProcedureSummary [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kIOParameter: aFASTFortran2kIOParameter [

	self 
		<< aFASTFortran2kIOParameter name;
		<< '='. "Not need to surround = by space since we dealing with keywordNamed like"
	
	aFASTFortran2kIOParameter expression accept: self
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kIfArithmeticStatement: aFASTFortran2kIfArithmeticStatement [

	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kIfBlockStatement: aFASTFortran2kIfBlockStatement [
	"note: can we have a label on an else line ?"

	self skipLine: aFASTFortran2kIfBlockStatement.

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
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kIfLogicalStatement: aFASTFortran2kIfLogicalStatement [

	self visitFASTFortranIfLogicalStatement: aFASTFortran2kIfLogicalStatement
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kImplicitRange: aFASTFortran2kImplicitRange [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kImplicitStatement: aFASTFortran2kImplicitStatement [

	self visitFASTFortranImplicitStatement: aFASTFortran2kImplicitStatement 
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kImplicitTypingRule: aFASTFortran2kImplicitTypingRule [

]

{ #category : 'visiting - expressions' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kImpliedDoExpression: aFASTFortran2kImpliedDoExpression [

	self visitFASTFortranImpliedDoExpression: aFASTFortran2kImpliedDoExpression
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kImportStatement: aFASTFortran2kImportStatement [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kIncludeStatement: aFASTFortran2kIncludeStatement [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kInquireStatement: aFASTFortran2kInquireStatement [

	self indented: 'inquire '.
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kInquireStatement.
	self newLine

]

{ #category : 'visiting - expressions' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kIntegerLiteral: aFASTFortran2kIntegerLiteral [

	^ self visitFASTFortranIntegerLiteral: aFASTFortran2kIntegerLiteral
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kIntegerType: aFASTFortran2kIntegerType [

	^ self visitFASTFortranIntegerType: aFASTFortran2kIntegerType
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kInterface: aFASTFortran2kInterface [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kInterfaceProcedure: aFASTFortran2kInterfaceProcedure [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kInternalProcedure: aFASTFortran2kInternalProcedure [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kIntrinsicStatement: aFASTFortran2kIntrinsicStatement [

	self indented: 'intrinsic '.
	self visitFASTFortran2kTVariableGroup: aFASTFortran2kIntrinsicStatement.
	self newLine

]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kLabelReference: aFASTFortran2kLabelReference [

	self visitFASTFortranLabelReference: aFASTFortran2kLabelReference
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kLogicalType: aFASTFortran2kLogicalType [

	self visitFASTFortranLogicalType: aFASTFortran2kLogicalType.

]

{ #category : 'visiting - expressions' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kLoopControlExpression: aFASTFortran2kLoopControlExpression [

	self visitFASTFortranLoopControlExpression: aFASTFortran2kLoopControlExpression
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kMapStatement: aFASTFortran2kMapStatement [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kModifier: aFASTFortran2kModifier [ 

	self
		<< aFASTFortran2kModifier token
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kModifiers: modifiers [
	"modifier are simple bytestring"

	modifiers ifNotEmpty: [  
			self << ', '.
			modifiers 
				do: [ :modifier | self << modifier ]
				separatedBy: [ self << ', ' ]
	 	].
]

{ #category : 'visiting - programUnits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kModule: aFASTFortranModule [

	| moduleName |

	moduleName := aFASTFortranModule name.

	self
		<< 'module '
		<< moduleName ;
		newLine.
	aFASTFortranModule statementBlock accept: self.
	
	aFASTFortranModule procedures ifNotEmpty: [ :procedures |
		self
			newLine ;
			<< 'contains' ;
			newLine ;
			newLine ;
			indent.

		procedures do: [ :procedure | procedure accept: self ].
		self
			unindent ;
			newLine.
	].
	
	self end: 'module' named: moduleName
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kNameEntity: aFASTFortran2kNameEntity [

	self << aFASTFortran2kNameEntity name
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kNameListStatement: aFASTFortran2kNameListStatement [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kNumericalConstant: aFASTFortran2kNumericalConstant [

]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kOpenStatement: aFASTFortran2kOpenStatement [

	self visitFASTFortranOpenStatement: aFASTFortran2kOpenStatement
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kOptionsStatement: aFASTFortran2kOptionsStatement [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kPTVariable: aFASTFortran2kPTVariable [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kParameterStatement: aFASTFortran2kParameterStatement [

	self visitFASTFortranParameterStatement: aFASTFortran2kParameterStatement 
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kPauseStatement: aFASTFortran2kPauseStatement [

	self visitFASTFortranPauseStatement: aFASTFortran2kPauseStatement.

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kPointerAssignmentStatement: aFASTFortran2kPointerAssignmentStatement [

	self indented: ''.
	aFASTFortran2kPointerAssignmentStatement variable accept: self.
	self << ' => '.
	aFASTFortran2kPointerAssignmentStatement expression accept: self.
	self newLine
		
	
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kPointerVariable: aFASTFortran2kPointerVariable [

	self visitFASTFortranScalarVariable: aFASTFortran2kPointerVariable.

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kPragmaStatement: aFASTFortran2kPragmaStatement [

]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kPrintStatement: aFASTFortran2kPrintStatement [ 

	self skipLine: aFASTFortran2kPrintStatement.

	self indented: 'print '.
	
	aFASTFortran2kPrintStatement format accept: self.
	
	self << ', '.
	
	self visitNodeListSeparatedByCommas: aFASTFortran2kPrintStatement arguments.
	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kPrivateStatement: aFASTFortran2kPrivateStatement [

	self indented: 'private '.
	self visitList: aFASTFortran2kPrivateStatement nameEntities.
	self newLine

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kProcedure: aFASTFortran2kProcedure [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kProgramFile: aFASTFortran2kProgramFile [

]

{ #category : 'visiting - programUnits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kProgramMain: aFASTFortran2kProgramNode [

	self setLineDescriptions: aFASTFortran2kProgramNode backTrace.

	self
		indented: 'program ' ;
		<< aFASTFortran2kProgramNode name ;
		newLine.
	
	self visitFASTFortranTBehaviouralEntity: aFASTFortran2kProgramNode.
	
	self end: 'program' named: aFASTFortran2kProgramNode name
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kProgramUnit: aFASTFortran2kProgramUnit [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kPublicStatement: aFASTFortran2kPublicStatement [

	self indented: 'public '.
	self visitList: aFASTFortran2kPublicStatement nameEntities.
	self newLine

]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kReadStatement: aFASTFortran2kReadStatement [

	self 
		skipLine: aFASTFortran2kReadStatement ;
		indented: '' ;
		visitFASTFortranReadStatement: aFASTFortran2kReadStatement ;
		newLine
		
]

{ #category : 'visiting - expressions' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kRealLiteral: aFASTFortran2kRealLiteral [

	self visitFASTFortranRealLiteral: aFASTFortran2kRealLiteral
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kRealType: aFASTFortran2kRealType [

	^ self visitFASTFortranRealType: aFASTFortran2kRealType
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kReturnStatement: aFASTFortran2kReturnStatement [

	self visitFASTFortranReturnStatement: aFASTFortran2kReturnStatement
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kRewindStatement: aFASTFortran2kRewindStatement [

	self indented: 'rewind '.
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kRewindStatement.
	self newLine

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kSaveStatement: aFASTFortran2kSaveStatement [

	self
		indented: 'save';
		newLine
]

{ #category : 'visiting - expressions' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kScalarVariable: aFASTFortran2kScalarVariable [ 

	self 
		<< aFASTFortran2kScalarVariable name
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kSourceCodeString: aFASTFortran2kSourceCodeString [

	self 
		skipLine: aFASTFortran2kSourceCodeString ;
		indented: '' ; 
		<< aFASTFortran2kSourceCodeString content ;
		newLine 
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kSpecialIntrinsicType: aFASTFortran2kSpecialIntrinsicType [
	"not sure how it works exactly and when you should use, for example 'integer(int16)' or just 'int16' ?"

	(aFASTFortran2kSpecialIntrinsicType name beginsWith: 'int')
	ifTrue: [
		self
			<< 'integer(' ;
			<< aFASTFortran2kSpecialIntrinsicType name ;
			<< ')'.
		^self
	].

	(aFASTFortran2kSpecialIntrinsicType name beginsWith: 'real')
	ifTrue: [
		self
			<< 'real(' ;
			<< aFASTFortran2kSpecialIntrinsicType name ;
			<< ')'.
		^self
	].

	self << aFASTFortran2kSpecialIntrinsicType name
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kStatementBlock: aFASTFortran2kStatementBlock [

	self skipLine: aFASTFortran2kStatementBlock.

	self indent.
	aFASTFortran2kStatementBlock statements
		ifNotNil:[ :statements |
			statements do: [ :statement | statement accept: self ].
		].
	self unindent
	
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kStaticStatement: aFASTFortran2kStaticStatement [

	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kStopStatement: aFASTFortran2kStopStatement [

	self visitFASTFortranStopStatement: aFASTFortran2kStopStatement
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kSubprogram: aFASTFortran2kSubprogram [

]

{ #category : 'visiting - programUnits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kSubroutine: aFASTFortran2kSubroutine [ 

	aFASTFortran2kSubroutine backTrace
		ifNotNil: [ self setLineDescriptions: aFASTFortran2kSubroutine backTrace ].

	self
		indented: 'subroutine ';
		<< aFASTFortran2kSubroutine name.
		
	self visitFASTFortranTWithParameters: aFASTFortran2kSubroutine.

	self newLine.

	self visitFASTFortranTBehaviouralEntity: aFASTFortran2kSubroutine.
	
	self  end: 'subroutine' named: aFASTFortran2kSubroutine name
		
	
	
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kSubstring: aFASTFortran2kSubstring [

]

{ #category : 'visiting - traits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kTDeclaration: aFASTFortran2kTDeclaration [

]

{ #category : 'visiting - traits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kTDeclaredType: aFASTFortran2kTDeclaredType [

]

{ #category : 'visiting - traits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kTEntryArgument: aFASTFortran2kTEntryArgument [

]

{ #category : 'visiting - traits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kTFormat: aFASTFortran2kTFormat [

]

{ #category : 'visiting - traits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kTIOParameter: aFASTFortran2kTIOParameter [

]

{ #category : 'visiting - traits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kTPointerAssignment: aFASTFortran2kTPointerAssignment [

]

{ #category : 'visiting - traits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kTVariableGroup: aFASTFortran2kTVariableGroup [

]

{ #category : 'visiting - traits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kTWithDeclarations: aFASTFortran2kTWithDeclarations [

]

{ #category : 'visiting - traits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kTWithDeclarators: aFASTFortran2kTWithDeclarators [

]

{ #category : 'visiting - traits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kTWithFormat: aFASTFortran2kTWithFormat [

]

{ #category : 'visiting - traits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kTWithLabelReferences: aFASTFortran2kTWithLabelReferences [

]

{ #category : 'visiting - traits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kTWithLoopControl: aFASTFortran2kTWithLoopControl [

]

{ #category : 'visiting - traits' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kTWithVariableGroups: aFASTFortran2kTWithVariableGroups [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kTargetVariable: aFASTFortran2kTargetVariable [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kType: aFASTFortran2kType [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kTypeBoundProcedure: aFASTFortran2kTypeBoundProcedure [

]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kTypePBFinal: aFASTFortran2kTypePBFinal [

]

{ #category : 'visiting - expressions' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kUnaryExpression: aFASTFortran2kUnaryExpression [

	self
		outputExpression: [
			self
				<< (self modernRelationalOperators 
					at: aFASTFortran2kUnaryExpression operator
					ifAbsent: [ aFASTFortran2kUnaryExpression operator ] 
				) ;
				space.
			aFASTFortran2kUnaryExpression expression accept: self ]
		withOperator: aFASTFortran2kUnaryExpression operator
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kUnionStatement: aFASTFortran2kUnionStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kUseNoRename: aFASTFortran2kUseNoRename [

	self indented: aFASTFortran2kUseNoRename name
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kUseNoRenamedStatement: aFASTFortran2kUseNoRenamedStatement [

	self indented: aFASTFortran2kUseNoRenamedStatement name
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kUseOnlyStatement: aFASTFortran2kUseOnlyStatement [

	self skipLine: aFASTFortran2kUseOnlyStatement.

	self
		indented: 'use :: ';
		<< aFASTFortran2kUseOnlyStatement name;
		<< ', only: '.

	self visitNodeListSeparatedByCommas: aFASTFortran2kUseOnlyStatement useNoRenames.
	
	aFASTFortran2kUseOnlyStatement useRenames ifNotEmpty: [ :useRenames | 
		self << ', '.
		self visitNodeListSeparatedByCommas: useRenames 
	].
	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kUseRename: aFASTFortran2kUseRename [ 

	self 
		skipLine: aFASTFortran2kUseRename ;
		<< aFASTFortran2kUseRename alias ;
		<< ' => ' ;
		<< aFASTFortran2kUseRename name
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kUseRenamedStatement: aFASTFortran2kUseRenamedStatement [

	self skipLine: aFASTFortran2kUseRenamedStatement.

	self
		<< aFASTFortran2kUseRenamedStatement alias;
		<< ' => ';
		<< aFASTFortran2kUseRenamedStatement name
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kUseStatement: aFASTFortran2kUseStatement [

	self skipLine: aFASTFortran2kUseStatement.

	self indented: 'use'.

	self visitFASTFortran2kModifiers: aFASTFortran2kUseStatement modifiers.

	self
		<< ' :: ';
		<< aFASTFortran2kUseStatement name.

	aFASTFortran2kUseStatement useRenames 
		ifNotNil: [:useRenames | 
			useRenames ifNotEmpty: [ 
				self << ', '.
				self visitNodeListSeparatedByCommas: useRenames
			]
		].

	aFASTFortran2kUseStatement useNoRenames 
		ifNotNil: [ :useNoRenames |
			useNoRenames ifNotEmpty: [ 
				self << ', only: '.
				self visitNodeListSeparatedByCommas: useNoRenames
			]
		].

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kUserDefinedType: aFASTFortran2kUserDefinedType [

	self
		<< 'type(';
		<< aFASTFortran2kUserDefinedType name;
		<< ')'
]

{ #category : 'visiting - expressions' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kVariable: aFASTFortran2kVariable [

	self visitFASTFortranVariable: aFASTFortran2kVariable 
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kVariableDeclarationStatement: aFASTFortran2kVariableDeclarationStatement [

	self skipLine: aFASTFortran2kVariableDeclarationStatement.

	self indented: ''.
	aFASTFortran2kVariableDeclarationStatement declaredType accept: self.

	self visitFASTFortran2kModifiers: aFASTFortran2kVariableDeclarationStatement modifiers.
	
	self << ' :: '.
	self visitNodeListSeparatedByCommas:
		aFASTFortran2kVariableDeclarationStatement declarators.
	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kVariableDeclarator: aFASTFortran2kVariableDeclarator [

	^ self visitFASTFortranVariableDeclarator: aFASTFortran2kVariableDeclarator
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kVirtualStatement: aFASTFortran2kVirtualStatement [

	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kVolatileStatement: aFASTFortran2kVolatileStatement [

	self newLine
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortran2kWriteStatement: aFASTFortran2kWriteStatement [

	self visitFASTFortranWriteStatement: aFASTFortran2kWriteStatement
]

{ #category : 'visiting - statements' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortranAbstractStatement: aFASTFortranAbstractStatement [
	"Checking line numbers  to add possible 'gap' lines (empty lines)"

	self skipLine: aFASTFortranAbstractStatement .

	super visitFASTFortranAbstractStatement: aFASTFortranAbstractStatement
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortranColon: aFASTFortran2kColon [

	self << '(len=:)'
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortranTBehaviouralEntity: aFASTFortranTBehaviouralEntity [

	aFASTFortranTBehaviouralEntity statementBlock 
		ifNotNil: [ aFASTFortranTBehaviouralEntity statementBlock accept: self ]
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortranType: aFASTFortran2kType [

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
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortranTypeDeclarationStatement: aFASTFortran2kTypeDeclarationStatement [

	self skipLine: aFASTFortran2kTypeDeclarationStatement.

	self indented: 'type ('.
	self visitFASTFortranUserDefinedType: aFASTFortran2kTypeDeclarationStatement declaredType.
	self << ')'.
	self << ' :: '.

	aFASTFortran2kTypeDeclarationStatement declarators 
		ifNotNil: [ :declarators | self visitNodeListSeparatedByCommas: declarators ].
	self newLine
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortranUsedEntity: aFASTFortran2kUsedEntity [

	self << aFASTFortran2kUsedEntity name
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortranUsedEntityRenamed: anEntity [

	self
		<< anEntity localName ;
	 	<< ' => ' ;
		<< anEntity name
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTFortranUserDefinedType: aFASTFortran2kUserDefinedType [

	self << aFASTFortran2kUserDefinedType name
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTTEntity: aFASTTEntity [
	^ aFASTTEntity children do: [ :child | child accept: self ]
]

{ #category : 'visiting - expressions' }
FASTFortran2kProgramFileExporterVisitor >> visitFASTTNumericalLiteral: aFASTTNumericalLiteral [

	self
		<< '(len=';
		<< aFASTTNumericalLiteral primitiveValue asString;
		<< ')'
]

{ #category : 'visiting' }
FASTFortran2kProgramFileExporterVisitor >> visitNodeListSeparatedByCommas: aCollection [

	aCollection
		do: [ :node | node accept: self ]
		separatedBy: [ self << ', ' ]
]
