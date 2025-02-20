Class {
	#name : 'FASTFortran2kGenerator',
	#superclass : 'FamixMetamodelGenerator',
	#instVars : [
		'acceptStatement',
		'assignmentStatement',
		'automaticStatement',
		'backspaceStatement',
		'blockData',
		'callStatement',
		'closeStatement',
		'comment',
		'commonStatement',
		'continueStatement',
		'dataStatement',
		'decodeStatement',
		'encodeStatement',
		'dimensionStatement',
		'doStatement',
		'doWhileStatement',
		'elseStatement',
		'endFileStatement',
		'entryStatement',
		'equivalenceStatement',
		'externalStatement',
		'formatStatement',
		'function',
		'goToStatement',
		'goToAssignedStatement',
		'goToComputed',
		'ifArithmeticStatement',
		'ifBlockStatement',
		'ifLogicalStatement',
		'implicitStatement',
		'includeStatement',
		'inquireStatement',
		'intrinsicStatement',
		'loopControlExpression',
		'mainprogram',
		'mapStatement',
		'nameListStatement',
		'openStatement',
		'optionsStatement',
		'parameterStatement',
		'pauseStatement',
		'pragmaStatement',
		'printStatement',
		'procedure',
		'programUnit',
		'readStatement',
		'rewindStatement',
		'saveStatement',
		'staticStatement',
		'subprogram',
		'substring',
		'stopStatement',
		'subroutine',
		'unionStatement',
		'virtualStatement',
		'volatileStatement',
		'writeStatement',
		'complexConstant',
		'type',
		'byteType',
		'characterType',
		'complexType',
		'doubleComplexType',
		'doublePrecisionType',
		'integerType',
		'logicalType',
		'realType',
		'exitStatement',
		'doubleComplexConstant',
		'doublePrecisionConstant',
		'integerConstant',
		'realConstant',
		'asterisk',
		'ampersand',
		'functionStatement',
		'returnStatement',
		'variable',
		'binaryExpression',
		'unaryExpression',
		'programFile',
		'functionCall',
		'booleanConstant',
		'characterConstant',
		'statementBlock',
		'assignmentExpression',
		'tEntryArgument',
		'dataGroup',
		'labelReference',
		'abstractStatement',
		'abstractExpression',
		'abstractLiteral',
		'scalarVariable',
		'arrayVariable',
		'variableDeclarationStatement',
		'tWithDeclarators',
		'variableDeclarator',
		'commonGroup',
		'tWithLabelReferences',
		'equivalenceGroup',
		'tVariableGroup',
		'tWithVariableGroup',
		'tWithFormat',
		'tFormat',
		'tIOParameter',
		'arrayRange',
		'implicitTypingRule',
		'implicitRange',
		'impliedDoExpression',
		'tWithLoopControl',
		'abstractIOStatement',
		'numericalConstant',
		'conditionalStatement',
		'tEntity',
		'tBehaviouralEntity',
		'tNamedEntity',
		'tWithParameters',
		'tWithComments',
		'tComment',
		'tStatement',
		'tAssignment',
		'tWithArguments',
		'tReturnStatement',
		'tStatementBlock',
		'tExpression',
		'tCharacterLiteral',
		'tBooleanLiteral',
		'tNumericalLiteral',
		'tUnaryExpression',
		'tBinaryExpression',
		'tVariableEntity',
		'entity',
		'useStatement',
		'useRenamedStatement',
		'useNoRenamedStatement',
		'useOnlyStatement',
		'derivedTypeDeclarationStatement',
		'derivedTypeComponent',
		'typeBoundProcedure',
		'tHasBindingAttribute',
		'module',
		'publicStatement',
		'privateStatement',
		'internalProcedure',
		'interface',
		'internalFunction',
		'internalSubroutine',
		'nameEntity',
		'userDefinedType',
		'interfaceModuleProcedureSummary',
		'interfaceProcedure',
		'typeBPFinal',
		'pointerAssignmentStatement',
		'ptVariable',
		'pointerVariable',
		'targetVariable',
		'tPointerAssignment',
		'importStatement',
		'classDeclarationStatement',
		'sourceCodeString',
		'formattedCodeString',
		'derivedTypeDefinition',
		'derivedTypeComponentAccess',
		'derivedTypeComponentDimension',
		'derivedTypeParameter',
		'derivedTypeAbstractField',
		'tDeclaration',
		'tDeclaredType',
		'tWithDeclarations',
		'functionTypeDeclarationStatement',
		'fieldAccess',
		'ioParameter'
	],
	#classInstVars : [
		'typeBoundProcedure'
	],
	#category : 'FAST-Fortran2k-Generator',
	#package : 'FAST-Fortran2k-Generator'
}

{ #category : 'generating' }
FASTFortran2kGenerator class >> packageName [

	^ #'FAST-Fortran2k-Entities'
]

{ #category : 'generating' }
FASTFortran2kGenerator class >> prefix [

	^ #FASTFortran2k
]

{ #category : 'generating' }
FASTFortran2kGenerator class >> submetamodels [

	^ { FASTMetamodelGenerator }
]

{ #category : 'definition' }
FASTFortran2kGenerator >> commentForDerivedTypeDefinition [

	^ 'I represent a derived type definition for example:
	
	```fortran
	!this a general commment
	public bar
	type :: bar
		integer, private ::idim= 0
		integer, private ::jdim= 0
		
		!idata is an integer array of rank 1
		integer, pointer, public ::idata(:) => null()
		
		!jdata is an integer array of rank 2 with non-trivial expression of its dimensions
		integer, pointer, public ::jdata(:, :) => null()
	end type bar
	```
	
	it is a translation of this esope segment definition
	
	```fortran
	c this a general commment
	segment bar
		C idata is an integer array ofrank 1
		integeridata(idim)
	
		C jdata is an integer array ofrank 2with non-trivial expression of its dimensions
		integerjdata(jdim + 1, jdim + 2)
	end segment
	```
	'
]

{ #category : 'definition' }
FASTFortran2kGenerator >> commentForIOParameter [
	^'I represent a specifier keywords used in I/O statement (open, write, read, close, ...).

where the most common specifiers are:

```fortran
    [UNIT=]  u
    IOSTAT=  ios
    ERR=     err
    FILE=    fname
    STATUS=  sta
    ACCESS=  acc
    FORM=    frm
    RECL=    rl
```
	
	'
]

{ #category : 'definition' }
FASTFortran2kGenerator >> defineClasses [

	super defineClasses.

	self defineFASTClasses. 
	self defineStatements.
	self defineData.
	
	self defineClasses2k.
]

{ #category : 'definition' }
FASTFortran2kGenerator >> defineClasses2k [

	nameEntity := self
		              newClassNamed: #NameEntity
		              comment: 'Im an item of access-id-list'.

	classDeclarationStatement := self
		                             newClassNamed:
		                             #ClassDeclarationStatement
		                             comment:
		                             '`class(type_name) [, pointer/allocatable/target] [, other_attributes ] :: declarators`'.

	derivedTypeDefinition := self
		                         newClassNamed: #DerivedTypeDefinition
		                         comment:
		                         self commentForDerivedTypeDefinition.

	derivedTypeAbstractField := self
		                            newClassNamed: #DerivedTypeAbstractField
		                            comment:
		                            'I represent a field (attribute, component,...) for a segment: either DerivedTypeComponent and DerivedTypeParameter'.

	derivedTypeComponent := self
		                        newClassNamed: #DerivedTypeComponent
		                        comment: 'I''m a derived type component'.

	derivedTypeComponentDimension := self newClassNamed:
		                                 #DerivedTypeComponentDimension.
	derivedTypeParameter := self newClassNamed: #DerivedTypeParameter.

	derivedTypeComponentAccess := self
		                              newClassNamed:
		                              #DerivedTypeComponentAccess
		                              comment:
		                              'I represent an access to object % field in derived type (therefore an expression)'.

	derivedTypeDeclarationStatement := self
		                                   newClassNamed:
		                                   #DerivedTypeDeclaration
		                                   comment:
		                                   'I represent a derived type declaration'.

	interface := self
		             newClassNamed: #Interface
		             comment: 'I represent an interface'.
	interfaceProcedure := self
		                      newClassNamed: #InterfaceProcedure
		                      comment:
		                      'I represent an interface procedure declaration'.

	interfaceModuleProcedureSummary := self
		                                   newClassNamed:
		                                   #IModuleProcedureSummary
		                                   comment: ''.


	internalProcedure := self
		                     newAbstractClassNamed: #InternalProcedure
		                     comment: 'I represent a internal procedure'.

	internalFunction := self
		                    newClassNamed: #InternalFunction
		                    comment: 'I represent a internal procedure'.

	internalSubroutine := self
		                      newClassNamed: #InternalSubroutine
		                      comment: 'I represent a internal procedure'.

	importStatement := self newClassNamed: #ImportStatement comment: ''.

	module := self newClassNamed: #Module comment: 'I represent a module'.

	pointerAssignmentStatement := self
		                              newClassNamed:
		                              #PointerAssignmentStatement
		                              comment: ''.
	ptVariable := self newClassNamed: #PTVariable comment: ''.
	pointerVariable := self newClassNamed: #PointerVariable comment: ''.

	publicStatement := self
		                   newClassNamed: #PublicStatement
		                   comment: 'Im a public statement'.

	privateStatement := self
		                    newClassNamed: #PrivateStatement
		                    comment: 'Im a private statement'.

	sourceCodeString := self newClassNamed: #SourceCodeString comment: ''.
	formattedCodeString := self
		                       newClassNamed: #FormattedCodeString
		                       comment: ''.


	targetVariable := self newClassNamed: #TargetVariable comment: ''.

	typeBoundProcedure := self
		                      newClassNamed: #TypeBoundProcedure
		                      comment: 'Im a type-bound-procedure'.

	typeBPFinal := self
		               newClassNamed: #TypePBFinal
		               comment: 'I represent a finalizer'.

	useStatement := self
		                newClassNamed: #UseStatement
		                comment: 'I represent a use statement'.
	useRenamedStatement := self
		                       newClassNamed: #UseRenamedStatement
		                       comment:
		                       'I represent a use renamed statement'.
	useNoRenamedStatement := self
		                         newClassNamed: #UseNoRenamedStatement
		                         comment:
		                         'I represent a non use renamed statement'.
	useOnlyStatement := self
		                    newClassNamed: #UseOnlyStatement
		                    comment: 'I represent a only use statement'.

	userDefinedType := self
		                   newClassNamed: #UserDefinedType
		                   comment: 'I represent a user defined type'
]

{ #category : 'definition' }
FASTFortran2kGenerator >> defineData [
	"sorted alphabetically, please keep the order"

	abstractExpression := self
		                   newClassNamed: #AbstractExpression
		                   comment: 'I am the super class of all Fortran expressions'.

	abstractLiteral := self
		                   newClassNamed: #AbstractLiteral
		                   comment: 'I am the super class of all Fortran Literals'.

	ampersand := self
		             newClassNamed: #Ampersand
		             comment:
		             'I represent an Ampersand Character Literal (Constant) that is often used in parameters and format identifiers'.

	arrayRange := self
		                            newClassNamed: #ArrayRange
		                            comment:
		                            'I represent an array lower/upper bounds'.

	arrayVariable := self
		                            newClassNamed: #ArrayVariable
		                            comment:
		                            'An array Fortran Variable, accessed in the code'.

	assignmentExpression := self
		                        newClassNamed: #AssignmentExpression
		                        comment:
		                        'I represent an assignment expression as a part of assignment statement'.

	asterisk := self
		            newClassNamed: #Asterisk
		            comment:
		            'I represent an Asterisk Character Literal (Constant) that is often used as a format identifier'.

	binaryExpression := self
		                    newClassNamed: #BinaryExpression
		                    comment:
		                    'a Fortran Binary Expression (arithmetic, logical)'.

	booleanConstant := self
		                   newClassNamed: #BooleanLiteral
		                   comment:
		                   'I represent Fortran Boolean Literal (Constant)'.

	byteType := self
		            newClassNamed: #ByteType
		            comment:
			            'I represent Fortran Byte statement. The BYTE data type provides a data type that uses only one byte of storage. It is a logical data type, and has the synonym,
LOGICAL*1. A variable of type BYTE can hold any of the following: 1)one character, 2)an integer between -128 and 127, 3)the logical values, .TRUE. or .FALSE. If it is interpreted as a logical value, a value of 0 represents .FALSE., and any other value is interpreted as .TRUE.
f77 allows the BYTE type as an array index, just as it allows the REAL type, but it does not allow BYTE as a DO loop index (where it allows only INTEGER, REAL, and DOUBLE PRECISION). Wherever the compiler expects INTEGER explicitly, it will not allow BYTE.'.

	characterConstant := self
		                     newClassNamed: #CharacterLiteral
		                     comment:
		                     'I represent Fortran Character Literal (Constant)'.

	characterType := self
		                 newClassNamed: #CharacterType
		                 comment:
		                 'I represent Fortran Character Literal'.

	commonGroup := self
		                   newClassNamed: #CommonGroup
		                   comment: 'I represent Common group inside a Common statement'.

	complexConstant := self
		                   newClassNamed: #ComplexLiteral
		                   comment:
		                   'I represent Fortran Arithmetic Complex Literal (Constant)'.

	complexType := self
		               newClassNamed: #ComplexType
		               comment:
		               'I represent Fortran Complex type COMPLEX, ie. a pair of REAL*4 values'.

	doubleComplexConstant := self
		                         newClassNamed: #DoubleComplexLiteral
		                         comment:
		                         'I represent Fortran Arithmetic Double Complex Literal (Constant)'.

	doubleComplexType := self
		                     newClassNamed: #DoubleComplexType
		                     comment:
		                     'I represent Fortran Double type'.

	doublePrecisionConstant := self
		                           newClassNamed: #DoublePrecisionLiteral
		                           comment:
		                           'I represent Fortran Arithmetic Double Precision Literal (Constant)'.

	doublePrecisionType := self
		                       newClassNamed: #DoublePrecisionType
		                       comment:
		                       'I represent Fortran Double Precision type, synonym of REAL*8'.

	fieldAccess := self
		                   newClassNamed: #FieldAccess
		                   comment:
		                   'I represent an access to pointer.field in Esope (therefore an expression)'.

	impliedDoExpression := self
		                   newClassNamed: #ImpliedDoExpression
		                   comment:
		                   'I represent a Fortran "implied do" expression'.

	integerConstant := self
		                   newClassNamed: #IntegerLiteral
		                   comment:
		                   'I represent Fortran Arithmetic Integer Literal (Constant)'.

	integerType := self
		               newClassNamed: #IntegerType
		               comment:
			               'I represent Fortran Integer type'.

	labelReference := self
		newClassNamed: #LabelReference
		comment: 'I represent a reference to a Fortran label, like in a GoTo statement.
I contain the value of the label referred to'.

	logicalType := self
		               newClassNamed: #LogicalType
		               comment:
		               'I represent Fortran boolean type'.

	loopControlExpression := self
		                         newClassNamed: #LoopControlExpression
		                         comment:
		                         'a Fortran Loop Control Expression'.

	numericalConstant := self
		newClassNamed: #NumericalConstant
		comment: 'I represent Fortran numerical Literals (Integer, Real, Complex)'.

	realConstant := self
		                newClassNamed: #RealLiteral
		                comment:
		                'I represent Fortran Arithmetic Real Literal (Constant)'.

	realType := self
		            newClassNamed: #RealType
		            comment:
		            'I represent Fortran Real type, synonym REAL*4'.

	scalarVariable := self
		                             newClassNamed: #ScalarVariable
		                             comment:
		                             'a scalar Fortran Variable, used in declarations'.

	substring := self
		             newClassNamed: #Substring
		             comment: 'I represent Fortran Substring'.

	type := self
		        newClassNamed: #Type
		        comment: 'I represent Fortran Type statement'.

	variable := self
		            newClassNamed: #Variable
		            comment:
		            'an abstract Fortran Variable, could be an array or a scalar'.

	variableDeclarator := self
		            newClassNamed: #VariableDeclarator
		            comment:
		            'Part of a variable declaration: name of the variable + optional initial value'.

	unaryExpression := self
		                   newClassNamed: #UnaryExpression
		                   comment:
		                   'a Fortran Unary Expression (arithmetic, logical, character)'

]

{ #category : 'definition' }
FASTFortran2kGenerator >> defineFASTClasses [
	"FAMIX-level classes (might be removed later)"

	entity  := self newClassNamed: #Entity.

	programFile := self
		               newClassNamed: #ProgramFile
		               comment:
		               'An entity that can contain fortran program units and comments'.

	programUnit := self
		               newClassNamed: #ProgramUnit
		               comment:
		               'A fortran program unit is a sequence of statements, terminated by an END statement. Every program unit is either a main program or a subprogram. If a program is to be executable, it must have a main program'.

	comment := self
		           newClassNamed: #Comment
		           comment: 'A fortran comment'.


	subprogram := self
		              newClassNamed: #Subprogram
		              comment:
		              'I represent a fortran subprogram: procedure or block data'.

	mainprogram := self
		               newClassNamed: #ProgramMain
		               comment:
		               'The PROGRAM statement identifies the program unit as a main program. program. For the loader, the main program is always named MAIN. The PROGRAM statement serves only the person who reads the program'.


	procedure := self
		             newClassNamed: #Procedure
		             comment:
		             'I represent a fortran subroutine or a function'.

	function := self
		            newClassNamed: #Function
		            comment: 'I represent a Fortran Function'.
	
	functionCall := self
		                     newClassNamed: #FunctionCall
		                     comment:
		                     'I represent a call to a function (or function statement)'.

	subroutine := self
		              newClassNamed: #Subroutine
		              comment:
		              'The SUBROUTINE statement identifies a subprogram, a named program unit as a subroutine, and specifies arguments for it'.

	blockData := self
		             newClassNamed: #BlockData
		             comment:
		             'The BLOCK DATA statement identifies a subprogram that initializes variables and arrays in labeled common blocks.'.

	statementBlock := self
		             newClassNamed: #StatementBlock
		             comment:
		             'Contains the block of Fortran statements'.

	conditionalStatement := self newClassNamed: #ConditionalStatement comment: 'I represent a fortran statement with a condition: if-block, if-logical'.

	ioParameter := self newClassNamed: #IOParameter comment: self commentForIOParameter.
]

{ #category : 'definition' }
FASTFortran2kGenerator >> defineHierarchy [

	super defineHierarchy.

	entity --|> tEntity.

	programUnit --|> tEntity.
	programUnit --|> tBehaviouralEntity.
	programUnit --|> tWithDeclarations.
	programUnit --|> tNamedEntity.
	subprogram --|> programUnit.
	mainprogram --|> programUnit.
	procedure --|> subprogram.
	procedure --|> tWithParameters.
	blockData --|> subprogram.
	function --|> procedure.
	function --|> tDeclaredType.
	subroutine --|> procedure.

	programFile --|> tWithComments.
	programFile --|> tWithDeclarations.
	programUnit --|> tWithComments.

	"other entities"
	comment --|> tEntity.
	comment --|> tComment.

	"FORTRAN STATEMENTS"
	abstractStatement --|> tStatement.
	abstractIOStatement --|> abstractStatement.
	acceptStatement --|> abstractStatement.
	assignmentStatement --|> abstractStatement.
	assignmentStatement --|> tAssignment.
	automaticStatement --|> abstractStatement.
	backspaceStatement --|> abstractIOStatement.
	callStatement --|> abstractStatement.
	callStatement --|> tWithArguments.
	closeStatement --|> abstractIOStatement.
	commonStatement --|> abstractStatement.
	conditionalStatement --|> abstractStatement.
	continueStatement --|> abstractStatement.
	dataStatement --|> abstractStatement.
	dataStatement --|> tWithVariableGroup.
	decodeStatement --|> abstractIOStatement.
	dimensionStatement --|> abstractStatement.
	dimensionStatement --|> tWithDeclarators.
	doStatement --|> abstractStatement.
	doStatement --|> tWithLabelReferences.
	doStatement --|> tWithLoopControl.
	doWhileStatement --|> conditionalStatement.
	elseStatement --|> abstractStatement.
	encodeStatement --|> abstractIOStatement.
	endFileStatement --|> abstractIOStatement.
	entryStatement --|> abstractStatement.
	entryStatement --|> tNamedEntity.
	equivalenceStatement --|> abstractStatement.
	equivalenceStatement --|> tWithVariableGroup.
	exitStatement --|> abstractStatement.
	externalStatement --|> abstractStatement.
	externalStatement --|> tNamedEntity.
	formatStatement --|> abstractStatement.
	formatStatement --|> tWithFormat.
	functionStatement --|> abstractStatement.
	functionStatement --|> tWithParameters.
	functionStatement --|> tNamedEntity.
	functionTypeDeclarationStatement --|> abstractStatement.
	functionTypeDeclarationStatement --|> tNamedEntity.
	functionTypeDeclarationStatement --|> tDeclaredType.
	goToStatement --|> abstractStatement.
	goToStatement --|> tWithLabelReferences.
	goToAssignedStatement --|> abstractStatement.
	goToAssignedStatement --|> tWithLabelReferences.
	goToComputed --|> abstractStatement.
	goToComputed --|> tWithLabelReferences.
	ifArithmeticStatement --|> conditionalStatement.
	ifBlockStatement --|> conditionalStatement.
	ifLogicalStatement --|> conditionalStatement.
	implicitStatement --|> abstractStatement.
	includeStatement --|> abstractStatement.
	inquireStatement --|> abstractIOStatement.
	intrinsicStatement --|> abstractStatement.
	intrinsicStatement --|> tVariableGroup.
	mapStatement --|> abstractStatement.
	nameListStatement --|> abstractStatement.
	openStatement --|> abstractIOStatement.
	optionsStatement --|> abstractStatement.
	parameterStatement --|> abstractStatement.
	parameterStatement --|> tWithDeclarators.
	pauseStatement --|> abstractStatement.
	pragmaStatement --|> abstractStatement.
	printStatement --|> abstractStatement.
	printStatement --|> tWithFormat.
	printStatement --|> tWithArguments.
	readStatement --|> abstractIOStatement.
	readStatement --|> tWithArguments.
	returnStatement --|> abstractStatement.
	returnStatement --|> tReturnStatement.
	rewindStatement --|> abstractIOStatement.
	saveStatement --|> abstractStatement.
	statementBlock --|> tStatementBlock.
	statementBlock --|> tWithComments.
	staticStatement --|> abstractStatement.
	stopStatement --|> abstractStatement.
	unionStatement --|> abstractStatement.
	variableDeclarationStatement --|> tDeclaredType.
	variableDeclarationStatement --|> abstractStatement.
	variableDeclarationStatement --|> tWithDeclarators.
	virtualStatement --|> abstractStatement.
	volatileStatement --|> abstractStatement.
	writeStatement --|> abstractIOStatement.
	writeStatement --|> tWithArguments.


	"Expressions"
	abstractExpression --|> tExpression.
	abstractLiteral --|> abstractExpression.
	ampersand --|> abstractLiteral.
	ampersand --|> tCharacterLiteral.
	arrayRange --|> abstractExpression.
	arrayVariable --|> variable.
	assignmentExpression --|> abstractExpression.
	assignmentExpression --|> tAssignment.
	assignmentExpression --|> tIOParameter.
	binaryExpression --|> abstractExpression.
	binaryExpression --|> tBinaryExpression.
	booleanConstant --|> abstractLiteral.
	booleanConstant --|> tBooleanLiteral.
	characterConstant --|> abstractLiteral.
	characterConstant --|> tCharacterLiteral.
	characterConstant --|> tFormat.
	commonGroup --|> tWithDeclarators.
	commonGroup --|> tNamedEntity.
	complexConstant --|> numericalConstant.
	dataGroup --|> tVariableGroup.
	doubleComplexConstant --|> numericalConstant.
	doublePrecisionConstant --|> numericalConstant.
	equivalenceGroup --|> tVariableGroup.
	fieldAccess --|> variable.
	functionCall --|> abstractExpression.
	functionCall --|> tWithArguments.
	impliedDoExpression --|> tWithLoopControl.
	impliedDoExpression --|> abstractExpression.
	impliedDoExpression --|> tVariableGroup.
	integerConstant --|> numericalConstant.
	integerConstant --|> tFormat.
	ioParameter --|> tNamedEntity.
	ioParameter --|> tIOParameter.
	numericalConstant --|> abstractLiteral.
	numericalConstant --|> tNumericalLiteral.
	realConstant --|> numericalConstant.
	scalarVariable --|> variable.
	substring --|> abstractExpression.
	unaryExpression --|> abstractExpression.
	unaryExpression --|> tUnaryExpression.
	variable --|> abstractExpression.
	variable --|> tVariableEntity.
	variable --|> tEntryArgument.
	variable --|> tFormat.
	variableDeclarator --|> tNamedEntity.

	"types"
	byteType --|> type.
	characterType --|> type.
	complexType --|> type.
	doubleComplexType --|> type.
	doublePrecisionType --|> type.
	integerType --|> type.
	logicalType --|> type.
	realType --|> type.

	asterisk --|> integerConstant. "used as type size"
	asterisk --|> tEntryArgument.
	asterisk --|> tFormat.

	tFormat --|> tIOParameter.
	
	self defineHierarchy2k.
]

{ #category : 'definition' }
FASTFortran2kGenerator >> defineHierarchy2k [

	nameEntity --|> tNamedEntity.

	derivedTypeDefinition --|> type.
	derivedTypeDefinition --|> tNamedEntity.
	derivedTypeDefinition --|> abstractStatement.
	
	derivedTypeDeclarationStatement --|> variableDeclarationStatement.
	classDeclarationStatement --|> variableDeclarationStatement.

	derivedTypeAbstractField --|> variableDeclarationStatement.
	
	derivedTypeComponent --|> derivedTypeAbstractField.
	derivedTypeParameter --|> derivedTypeAbstractField.

	derivedTypeComponentDimension --|> abstractExpression.
	derivedTypeComponentDimension --|> tNamedEntity.

	derivedTypeComponentAccess --|> variable.
	
	importStatement --|> abstractStatement.
	
	interface --|> tNamedEntity. "name is optional"
	interface --|> abstractStatement.
	
	interfaceProcedure --|> tNamedEntity.
	interfaceModuleProcedureSummary --|> interfaceProcedure.
	
	internalProcedure --|> tEntity.
	internalProcedure --|> tBehaviouralEntity.
	internalProcedure --|> tNamedEntity.
	internalProcedure --|> tWithComments.

	internalFunction --|> internalProcedure.
	internalSubroutine --|> internalProcedure.
	
	module --|> programUnit.
	
	pointerAssignmentStatement --|> tPointerAssignment.
	
	ptVariable --|> variable.
	
	pointerVariable --|> ptVariable.
	
	privateStatement --|> abstractStatement.
	publicStatement --|> abstractStatement.
	
	sourceCodeString --|> abstractStatement.
	formattedCodeString --|> sourceCodeString.
	
	targetVariable --|> ptVariable.
	
	tPointerAssignment --|> tExpression.
	
	typeBoundProcedure --|> tNamedEntity.
	typeBPFinal --|> typeBoundProcedure.
	
	useStatement --|> tNamedEntity.
	useStatement --|> abstractStatement.
	
	useRenamedStatement --|> tNamedEntity.
	useNoRenamedStatement --|> tNamedEntity.
	
	useOnlyStatement --|> useStatement.
	
	userDefinedType --|> type.
	userDefinedType  --|> tNamedEntity.
	

]

{ #category : 'definition' }
FASTFortran2kGenerator >> defineProperties [

	super defineProperties.

	(callStatement property: #name type: #String) comment:
		'Name of called entity (a subroutine)'.

	(comment property: #content type: #String) comment:
		'Determines a content of a comment'.

	(formatStatement property: #formatDescription type: #String).

	(functionCall property: #name type: #String) comment:
		'Name of called function'.

	(implicitRange property: #from type: #String) comment:
		'Start of character range for implicit rule'.

	(implicitRange property: #to type: #String) comment:
		'End of character range for implicit rule'.

	(labelReference property: #label type: #String) comment: 'The value of the label. The value is an integer literal, stored in a String'.

	(programFile property: #filename type: #String).

	(returnStatement property: #alternateReturnLabel type: #String)
		comment: 'Optional. Expression of type INTEGER or REAL'.

	(pauseStatement property: #displayArgument type: #String) comment:
		'Optional. Displayed when the program pauses. String of no more that 5 digits or a character constant'.

	(stopStatement property: #displayArgument type: #String) comment:
		'Optional. Displayed when the program stops. String of no more that 5 digits or a character constant'.

	(tBinaryExpression property: #operator type: #String) comment:
		'Binary expression operator'.

	(abstractStatement property: #label type: #String) comment:
		'Determines the statement label which consists of 1 to 5 digits, with at least one nonzero'.

	self defineProperties2k.
]

{ #category : 'definition' }
FASTFortran2kGenerator >> defineProperties2k [

	(derivedTypeDefinition property: #superType type: #String) comment:
		'I represent the name of the super type'.

	(derivedTypeComponent property: #rank type: #Number).
		
	(interface property: #isAbstractInterface type: #Boolean)
		comment: 'Im abstract ?'.
		
	(sourceCodeString property: #content type: #String)
		comment: 'The source code string to export'.
	(formattedCodeString property: #values type: #Object)
		comment: 'Values of the variables to format the string'.
	
	(typeBoundProcedure property: #alias type: #String)
		comment: 'I represent the alias name of the procedure'.
		
	(typeBoundProcedure property: #interface type: #String)
		comment: 'I represent the name of the interface'.
		
	(useRenamedStatement property: #alias type: #String)
		comment: 'I represent the alias of the used entity'.
		
]

{ #category : 'definition' }
FASTFortran2kGenerator >> defineRelations [

	super defineRelations.

	((arrayRange property: #upperBound) comment: 'An upper bound of an array dimension')
	<>- ((abstractExpression property: #parentArrayDimensionDeclarator) comment:
			 'Parent array dimension declarator').

	((arrayRange property: #lowerBound) comment: 'A lower bound of an array dimension')
	<>- ((abstractExpression property: #parentArrayDimensionDeclarator) comment:
			 'Parent array dimension declarator').

	((variableDeclarator property: #dimensions) comment: 'Possible dimensions in case this is an array declaration')
	<>-* ((arrayRange property: #parentVariableDeclarator)
			comment: 'The variable declarator I am part of').

	((arrayVariable property: #indices) comment: 'Indices used in the array access')
	<>-* ((abstractExpression property: #parentArrayExpression) comment: 'an ArrayVariable expression of which I am an indice').

	((commonStatement property: #groups) comment:
		 'List common groups in this common statement')
	<>-* ((commonGroup property: #parentCommonStatement) comment:
			 'Parent common statement I belong to').

	(dataGroup property: #dataConstants)
	<>-* (abstractExpression property: #parentDataStatement).

	(fieldAccess property: #pointer)
	<>- ((variable property: #pointerIn) comment: 'Parent FieldAccess in which receiver is a pointer').

	(fieldAccess property: #field)
	<>- ((variable property: #fieldIn) comment: 'Parent FieldAccess in which receiver is a field').

	(impliedDoExpression property: #variables)
	<>-* (tVariableEntity property: #parentImpliedExpression).
	
	
	((tWithDeclarations property: #declarations) comment:
		 'The elements I declare')
	<>-* ((tDeclaration property: #fortranDeclarationOwner) comment:
			 'The element that declares me').
	

	(tVariableGroup property: #variables)
	<>-* (variable property: #parentVariableGroup).

	((abstractIOStatement property: #ioParameters) comment: 'IO-Parameters of an IO-statement (READ, WRITE...)')
	<>-* (tIOParameter property: #parentIOStatement).

	tWithVariableGroup <>-* tVariableGroup.
	
	((tWithDeclarators property: #declarators) comment: 'variables declared')
	<>-* (variableDeclarator property: #parentDeclaration).

	((variableDeclarator property: #expression) comment:
		 'Expression assigned to the variable declared')
	<>- (abstractExpression property: #variableDeclaratorOwner) .

	((tDeclaredType property: #declaredType) comment: 'type')
	<>-
	((type property: #parentDeclaration) comment: 'Parent declaration').

	((tWithLoopControl property: #loopControl) comment: 'loop control')
	<>-
	((loopControlExpression property: #parentLoop) comment: 'Parent loop').

	((doStatement property: #statementBlock) comment:
		 'Statement block containing statements of the do body ')
	<>- ((statementBlock property: #parentDoStatement) comment:
			 'Parent do statement').

	(entryStatement property: #entryArguments)
	<>-* (tEntryArgument property: #entryStatement).

	((functionStatement property: #expression) comment:
		 'Expression thats being assigned upon declaration to the var')
	<>- ((abstractExpression property: #assignementExpressionOwner) comment:
			 'The AssignementExpression owner (if possible)').

	((goToComputed property: #selectorExpression) comment: 'The expression which value selects the label to go to')
	<>- (abstractExpression property: #parentGotoComputedStatement).

	((goToAssignedStatement property: #selectorExpression) comment: 'The expression which value selects the label to go to')
	<>- (abstractExpression property: #parentGotoAssignedStatement).

	((conditionalStatement property: #condition) comment: 'Condition')
	<>-
	((abstractExpression property: #parentConditionalStatement) comment: 'Parent conditional statement (if-block, if-logical, ...)').

	((ifLogicalStatement property: #statement) comment:
		 'Statement of the logical if')
	<>- ((abstractStatement property: #parentIfStatement) comment: 'Parent if statement').

	((ifBlockStatement property: #thenStatementBlock) comment:
		 'Statement block containing statements of then branch ')
	<>-
	((statementBlock property: #parentIfBlock) comment:
		 'Parent if block').

	((ifBlockStatement property: #elseStatementBlock) comment:
		 'Statement block containing statements of else branch ')
	<>-
	((statementBlock property: #parentIfBlock) comment:
		 'Parent if block').

	(ifArithmeticStatement property: #lessLabel)
	<>- (labelReference property: #parentIfArithmeticLessBranch).

	(ifArithmeticStatement property: #equalLabel)
	<>- (labelReference property: #parentIfArithmeticEqualBranch).

	(ifArithmeticStatement property: #greaterLabel)
	<>- (labelReference property: #parentIfArithmeticMoreBranch).

	(implicitStatement property: #typingRules)
	<>-* (implicitTypingRule property: #parentImplicitStatement).

	implicitTypingRule
	<>- (type property: #parentImplicitRule).

	(implicitTypingRule property: #ranges)
	<>-* (implicitRange property: #parentImplicitRule).

	((loopControlExpression property: #init) comment:
		 'initial assignment')
	<>- (assignmentExpression property: #parentLoopControlInitialization).

	((loopControlExpression property: #increment) comment:
		'Loop control increment value')
	<>- (abstractExpression property: #parentLoopControlIncrement).

	((loopControlExpression property: #limit) comment:
		'Loop control limit value')
	<>- (abstractExpression property: #parentLoopControlLimit).

	(programFile comment: 'Program Units in a program file')
	<>-* (programUnit comment: 'Parent program file').

	((type property: #size) comment: 'a data size in bytes')
	<>- (abstractExpression property: #parentTypeSize).

	((tWithFormat property: #format) comment: 'The description of the format')
	<>- ((tFormat property: #parentFormatedStatement) comment: 'A format description in a Format/Print/Read/Write statement').

	((tWithLabelReferences property: #labelReferences) comment:
		 'the label(s) referenced')
	<>-* ((labelReference property: #referencer) comment:
			 'A statement (like goto) referencing this label').

	((ioParameter property: #expression) comment: 
		'value of the parameter (keyword argument)')
	<>- ((tExpression property: #ioSpecifier) comment: 
		'name of the parameter (keyword argument)').
			
	self defineRelations2k.

]

{ #category : 'definition' }
FASTFortran2kGenerator >> defineRelations2k [

	(derivedTypeDefinition property: #fields) 
		<>-* (derivedTypeAbstractField property: #parentDerivedType).

	derivedTypeDefinition <>-* typeBoundProcedure.
	derivedTypeDefinition - comment.

	derivedTypeComponent <>-* derivedTypeComponentDimension.
	derivedTypeComponent - comment.

	(derivedTypeComponentAccess property: #instance)
	<>- ((variable property: #instanceIn) comment: 'Parent DerivedTypeComponentAccess in which receiver is a instance of derived type').

	(derivedTypeComponentAccess property: #field)
	<>- ((variable property: #fieldIn) comment: 'Parent DerivedTypeComponentAccess in which receiver is a field').
	
	importStatement  <>-* nameEntity.

	procedure <>-* internalProcedure.
	mainprogram <>-* internalProcedure.

	module <>-* procedure.

	publicStatement <>-* nameEntity.
	privateStatement <>-* nameEntity.
	useStatement <>-* useRenamedStatement.
	useOnlyStatement <>-* useNoRenamedStatement.

	(internalFunction property: #returnType)
	<>- (type property: #typedFunctions).

	interface <>-* interfaceProcedure.

	((tPointerAssignment property: #variable) comment:
		 'An assigned variable (lhs of assignment)')
	<>-
		((pointerVariable property: #parentAssignmentExpression) comment:
			 'Optional assignment to the variable').

	((tPointerAssignment property: #expression) comment:
		 'Assigned expression (rhs of assignment)')
	<>- ((ptVariable property: #assignedIn) comment:
			 'Optional assignment where this expression is used')
]

{ #category : 'definition' }
FASTFortran2kGenerator >> defineStatements [
	"A statement consists of zero or more key words, symbolic names, literal constants, statement labels, operators, and special characters."

	abstractStatement := self
		                   newClassNamed: #AbstractStatement
		                   comment: 'I am the super class of all Fortran statements'.

	abstractIOStatement := self
		newClassNamed: #AbstractIOStatement
		comment: 'I am the abstract superclass of all IO-statements (READ, WRITE, CLOSE, ENCODE...)'.

	acceptStatement := self
		                   newClassNamed: #AcceptStatement
		                   comment: 'I represent Fortran accept statement'.

	assignmentStatement := self
		                       newClassNamed: #AssignmentStatement
		                       comment:
		                       'I represent Fortran assignment made without ASSIGN statement'.

	automaticStatement := self
		                      newClassNamed: #AutomaticStatement
		                      comment:
		                      'I represent Fortran Automatic statement'.
	backspaceStatement := self
		                      newClassNamed: #BackspaceStatement
		                      comment:
		                      'I represent Fortran Backspace statement'.
	callStatement := self
		                 newClassNamed: #CallStatement
		                 comment: 'I represent Fortran Call statement'.
	closeStatement := self
		                  newClassNamed: #CloseStatement
		                  comment: 'I represent Fortran Close statement'.
	commonStatement := self
		                   newClassNamed: #CommonStatement
		                   comment: 'I represent Fortran Common statement'.
	continueStatement := self
		                     newClassNamed: #ContinueStatement
		                     comment:
		                     'I represent Fortran Continue statement'.
	dataStatement := self
		                 newClassNamed: #DataStatement
		                 comment: 'I represent a Fortran Data statement'.

	dataGroup := self
		                 newClassNamed: #DataGroup
		                 comment: 'I represent a Fortran Data group in a Data statement'.
	decodeStatement := self
		                   newClassNamed: #DecodeStatement
		                   comment: 'I represent Fortran Decode statement'.
	encodeStatement := self
		                   newClassNamed: #EncodeStatement
		                   comment: 'I represent Fortran Encode statement'.
	dimensionStatement := self
		                      newClassNamed: #DimensionStatement
		                      comment:
		                      'I represent FortranDimension statement'.
	doStatement := self
		               newClassNamed: #DoStatement
		               comment: 'I represent Fortran Do statement'.
	doWhileStatement := self
		                    newClassNamed: #DoWhileStatement
		                    comment:
		                    'I represent Fortran Do While statement'.
	elseStatement := self
		                 newClassNamed: #ElseStatement
		                 comment: 'I represent Fortran Else statement'.
	endFileStatement := self
		                    newClassNamed: #EndFileStatement
		                    comment:
		                    'I represent Fortran End File statement'.

	entryStatement := self
		                  newClassNamed: #EntryStatement
		                  comment: 'I represent Fortran Entry statement'.
	equivalenceGroup := self
		                        newClassNamed: #EquivalenceGroup
		                        comment:
		                        'I represent a group of variables in an Equivalence statement'.
	equivalenceStatement := self
		                        newClassNamed: #EquivalenceStatement
		                        comment:
		                        'I represent a Fortran Equivalence statement'.
	externalStatement := self
		                     newClassNamed: #ExternalStatement
		                     comment:
		                     'I represent Fortran External statement'.
	formatStatement := self
		                   newClassNamed: #FormatStatement
		                   comment: 'I represent Fortran Format statement'.

	functionStatement := self
		                     newClassNamed: #FunctionStatement
		                     comment:
		                     'I represent a function statement - a function-like declaration, made in a single statement'.
		
	functionTypeDeclarationStatement := self newClassNamed: #FunctionTypeDeclarationStatement  comment: 'I represent a return type declaration statement'.

	goToStatement := self
		                 newClassNamed: #GoToStatement
		                 comment: 'I represent Fortran Go To (unconditional) statement'.

	goToAssignedStatement := self
		                         newClassNamed: #GoToAssignedStatement
		                         comment:
		                         'I represent Fortran Go To( Assigned) statement'.
	goToComputed := self
		                newClassNamed: #GoToComputedStatement
		                comment:
		                'I represent Fortran Go To (Computed) statement'.

	ifArithmeticStatement := self
		                         newClassNamed: #IfArithmeticStatement
		                         comment:
		                         'I represent Fortran If (Arithmetic) statement'.
	ifBlockStatement := self
		                    newClassNamed: #IfBlockStatement
		                    comment:
		                    'I represent Fortran If (BLock) statement'.
	ifLogicalStatement := self
		                      newClassNamed: #IfLogicalStatement
		                      comment:
		                      'The logical IF statement executes one single statement, or does not execute it, depending on the value of a logical expression.'.
	implicitStatement := self
		                     newClassNamed: #ImplicitStatement
		                     comment:
		                     'I represent Fortran Implicit statement'.

	implicitTypingRule := self
		                     newClassNamed: #ImplicitTypingRule
		                     comment:
		                     'I represent a rule (ie. Type+letter range) in an Implicit statement'.

	implicitRange := self
		                     newClassNamed: #ImplicitRange
		                     comment:
		                     'I represent a range of characters in an Implicit statement'.

	includeStatement := self
		                    newClassNamed: #IncludeStatement
		                    comment: 'I represent Fortran Include statement'.
	inquireStatement := self
		                    newClassNamed: #InquireStatement
		                    comment: 'I represent Fortran Inquire statement'.
	intrinsicStatement := self
		                      newClassNamed: #IntrinsicStatement
		                      comment:
		                      'I represent Fortran Intrinsic statement'.
	mapStatement := self
		                newClassNamed: #MapStatement
		                comment: 'I represent Fortran Map statement'.
	nameListStatement := self
		                     newClassNamed: #NameListStatement
		                     comment:
		                     'I represent Fortran NameList statement'.
	openStatement := self
		                 newClassNamed: #OpenStatement
		                 comment: 'I represent Fortran Open statement'.
	optionsStatement := self
		                    newClassNamed: #OptionsStatement
		                    comment: 'I represent Fortran Options statement'.
	parameterStatement := self
		                      newClassNamed: #ParameterStatement
		                      comment:
		                      'I represent Fortran Parameter statement'.
	pauseStatement := self
		                  newClassNamed: #PauseStatement
		                  comment: 'I represent Fortran Pause statement'.
	pragmaStatement := self
		                   newClassNamed: #PragmaStatement
		                   comment: 'I represent Fortran Pragma statement'.
	printStatement := self
		                  newClassNamed: #PrintStatement
		                  comment: 'I represent Fortran Print statement'.

	readStatement := self
		                 newClassNamed: #ReadStatement
		                 comment: 'I represent Fortran Read statement'.

	returnStatement := self
		                   newClassNamed: #ReturnStatement
		                   comment: 'a Fortran Return Statement'.

	rewindStatement := self
		                   newClassNamed: #RewindStatement
		                   comment: 'I represent Fortran Rewind statement'.
	saveStatement := self
		                 newClassNamed: #SaveStatement
		                 comment: 'I represent Fortran Save statement'.

	staticStatement := self
		                   newClassNamed: #StaticStatement
		                   comment: 'I represent Fortran Static statement'.
	stopStatement := self
		                 newClassNamed: #StopStatement
		                 comment: 'I represent Fortran Stop statement'.
	unionStatement := self
		                  newClassNamed: #UnionStatement
		                  comment: 'I represent Fortran Union statement'.

	variableDeclarationStatement := self
		                   newClassNamed: #VariableDeclarationStatement
		                   comment:
		                   'I represent a type declaration for one or many scalar variables or arrays'.	

	virtualStatement := self
		                    newClassNamed: #VirtualStatement
		                    comment: 'I represent Fortran Virtual statement'.
	volatileStatement := self
		                     newClassNamed: #VolatileStatement
		                     comment: 'I represent Fortran Volatile statement'.
	writeStatement := self
		                  newClassNamed: #WriteStatement
		                  comment: 'I represent Fortran Write statement'.

	"NOT IN THE 77 STANDARD"
	exitStatement := self
		                 newClassNamed: #ExitStatement
		                 comment: 'I represent Fortran90 Exit statement'
]

{ #category : 'definition' }
FASTFortran2kGenerator >> defineTraits [

	super defineTraits.

	tEntity := self remoteTrait: #TEntity withPrefix: #FAST.

	tAssignment := self remoteTrait: #TAssignment withPrefix: #FAST.
	tBehaviouralEntity := self remoteTrait: #TBehaviouralEntity withPrefix: #FAST.
	tBinaryExpression := self remoteTrait: #TBinaryExpression withPrefix: #FAST. 
	tBooleanLiteral := self remoteTrait: #TBooleanLiteral withPrefix: #FAST.
	tCharacterLiteral := self remoteTrait: #TCharacterLiteral withPrefix: #FAST.
	tComment := self remoteTrait: #TComment withPrefix: #FAST.
	tDeclaration := self newTraitNamed: #TDeclaration comment: 'I am a declaration in fortran'.
	tDeclaredType := self newTraitNamed: #TDeclaredType comment: 'I am the declared type of a function or variable'.
	tExpression := self remoteTrait: #TExpression withPrefix: #FAST. 
	tNamedEntity := self remoteTrait: #TNamedEntity withPrefix: #FAST.
	tNumericalLiteral := self remoteTrait: #TNumericalLiteral withPrefix: #FAST.
	tStatement := self remoteTrait: #TStatement withPrefix: #FAST.
	tStatementBlock := self remoteTrait: #TStatementBlock withPrefix: #FAST.
	tReturnStatement := self remoteTrait: #TReturnStatement withPrefix: #FAST.
	tUnaryExpression := self remoteTrait: #TUnaryExpression withPrefix: #FAST. 
	tVariableEntity := self remoteTrait: #TVariableEntity withPrefix: #FAST.
	tWithArguments := self remoteTrait: #TWithArguments withPrefix: #FAST.
	tWithComments := self remoteTrait: #TWithComments withPrefix: #FAST.
	tWithParameters := self remoteTrait: #TWithParameters withPrefix: #FAST.

	tEntryArgument := self newTraitNamed: #TEntryArgument comment: 'I represent an argument in an entry statement: it can be a variable name, array name, formal procedure name, or an asterisk'.
	tFormat := self newTraitNamed: #TFormat comment: 'I represent a format description (eg. in Format or Print statement)'.
	tIOParameter := self newTraitNamed: #TIOParameter comment: 'I represent a parameter to an IO-statement (read or write)'.
	tVariableGroup := self newTraitNamed: #TVariableGroup comment: 'I represent an entity with several variables like in a DataStatement or an EquivalenceStatement'.
	tWithDeclarations := self newTraitNamed: #TWithDeclarations comment: 'I have declarations'.
	tWithDeclarators := self newTraitNamed: #TWithDeclarators comment: 'I represent a declaration with several variable declarators'.
	tWithFormat := self newTraitNamed: #TWithFormat comment: 'I represent a statement with a format (format, print)'.
	tWithLabelReferences := self newTraitNamed: #TWithLabelReferences comment: 'I represent a statement (various kind of goto) that can have label references'.
	tWithLoopControl := self newTraitNamed: #TWithLoopControl comment: 'I represent a loop control: initialization/limit/increment'.
	tWithVariableGroup := self newTraitNamed: #TWithVariableGroups comment: 'I represent a statement with variable groups like a DataStatement or an EquivalenceStatement'.
	
	self defineTraits2k.

]

{ #category : 'definition' }
FASTFortran2kGenerator >> defineTraits2k [

	tHasBindingAttribute := self
		                        newTraitNamed: #THasBindingAttribute
		                        comment:
		                        'I represent an attribute (pass/nopass or deferred/non_overidable or private/public) of a type-bound-procedure'.

	tPointerAssignment := builder
		                      newTraitNamed: #TPointerAssignment
		                      comment: 'self commentForTPointerAssignment'
]
