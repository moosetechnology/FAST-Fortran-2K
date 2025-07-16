Class {
	#name : 'FASTFortran2kExporterVisitorTest',
	#superclass : 'FASTFortran2kAbstractVisitorTest',
	#category : 'FAST-Fortran2k-Visitors-Tests',
	#package : 'FAST-Fortran2k-Visitors-Tests'
}

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> assertExport: anEntity equals: expectedString [

	anEntity accept: visitor.
	self assert: visitor outputStream contents equals: expectedString withPlatformLineEndings
]

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> newVisitor [

	^FASTFortran2kProgramFileExporterVisitor new
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testAssignmentStatement [

	| stmt |

	stmt := FASTFortran2kAssignmentStatement new
		variable: (FASTFortran2kScalarVariable new name: 'x') ;
		expression: (FASTFortran2kIntegerLiteral new primitiveValue: '1') ;
		yourself.

	self assertExport: stmt equals: 'x = 1
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testAssignmentStatementPointer [

	| stmt |

	stmt := FASTFortran2kPointerAssignmentStatement new
		variable: (self scalarVariable: 'x') ;
		expression: (self scalarVariable: 'y') ;
		yourself.

	self assertExport: stmt equals: 'x => y
'
]

{ #category : 'testing - type-definitions' }
FASTFortran2kExporterVisitorTest >> testCloseStatement [
	| stmt |
	stmt := FASTFortran2kCloseStatement new
		ioParameters: {
			self integerLiteral: '3' .
			self ioParameter: #file value: 'projectA/data.test'.
			self ioParameter: #err value: 99
		}.

	self
		assertExport: stmt
		equals: 
'close (3, file=''projectA/data.test'', err=99)
'.
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testCommentStatement [

	| stmt |

	stmt := FASTFortran2kComment new content: 'a comment'.

	self assertExport: stmt equals: '! a comment
'
]

{ #category : 'testing - expressions' }
FASTFortran2kExporterVisitorTest >> testDerivedTypeComponentAccess [
	| expr |

	expr := FASTFortran2kDerivedTypeComponentAccess new
		instance: (FASTFortran2kScalarVariable new name: 'ptr') ;
		field: (FASTFortran2kScalarVariable new name: 'att') ;
		yourself.

	self assertExport: expr equals: 'ptr % att'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testEmptyLineBetween2Statements [

	| stmt |

	stmt := FASTFortran2kStatementBlock new.
	stmt addStatement: (self declarationStatement: #integer variables: #(x) ).
	stmt addStatement: (self declarationStatement: #integer variables: #(y) ).
	stmt statements first
		startPos: 1 ; endPos: 10.
	stmt statements second
		startPos: 15 ; endPos: 25.
	visitor linesDescription: { 12 -> false . 14 -> true . 30 -> false }.
	self
		assertExport: stmt
		equals:
'  integer :: x

  integer :: y
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testImplicitNoneStatement [
	"
program demo
	implicit none
end program demo
"

	| stmt |
	stmt := FASTFortran2kProgramMain new
		name: 'demo';
		statementBlock: (FASTFortran2kStatementBlock new statements:
			{ FASTFortran2kImplicitStatement new });
		backTrace: self stubFile ;
		yourself.

	self
		assertExport: stmt
		equals:
'program demo
  implicit none
end program demo

'
]

{ #category : 'testing - type-definitions' }
FASTFortran2kExporterVisitorTest >> testIntegerType [

	self
		assertExport: FASTFortran2kIntegerType new
		equals: 'integer'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testLogicalIfStatementWithWrite [
	| stmt |
	stmt := FASTFortran2kIfLogicalStatement new
		condition: (self scalarVariable: 'bool') ;
		statement: (self writeStatement: #( 'message' )) ;
		yourself.

	self
		assertExport: stmt
		equals: 
'if (bool) write (*, *) ''message''
'
]

{ #category : 'testing - type-definitions' }
FASTFortran2kExporterVisitorTest >> testOpenStatement [
	| stmt |
	stmt := FASTFortran2kOpenStatement new
		ioParameters: {
			self integerLiteral: '3' .
			self ioParameter: #file value: 'projectA/data.test'.
			self ioParameter: #err value: 99
		}.

	self
		assertExport: stmt
		equals: 
'open (3, file=''projectA/data.test'', err=99)
'.
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testOperatorsPrecedenceNoParentheses [
	
	| expr |
	expr := self binary: '+' left: #v right: 5.

	self assertExport: expr equals: 'v + 5'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testOperatorsPrecedenceSubHasHigherPrecedence [
	
	| expr |
	expr := self binary: '+' left: #i right: 5.
	expr rightOperand: (self binary: '*' left: #j right: 5).

	self assertExport: expr
		equals: 'i + j * 5'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testOperatorsPrecedenceSubHasLowerPrecedence [	

	| expr |
	expr := self binary: '*' left: #i right: 5.
	expr rightOperand: (self binary: '+' left: #j right: 5).

	self assertExport: expr
		equals: 'i * (j + 5)'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testOperatorsPrecedenceSubUnary [
	
	| expr |
	expr := self binary: '.and.' left: #logical1 right: (self unary: '.not.' operand: #logical2).

	self
		assertExport: expr
		equals: 'logical1 .and. .not. logical2'
]

{ #category : 'testing - program-units' }
FASTFortran2kExporterVisitorTest >> testPointerDeclarationStatement [
	"
program demo
	implicit none
	type(point_t) :: p
end program demo
"

	| stmt |
	stmt := FASTFortran2kVariableDeclarationStatement new
		declaredType: (FASTFortran2kUserDefinedType new name: 'point_t') ;
		declarators: { FASTFortran2kVariableDeclarator new name: 'p' } ;
		modifiers: #( pointer ) ;
		yourself.

	self
		assertExport: stmt
		equals:
'type(point_t), pointer :: p
'
]

{ #category : 'testing - program-units' }
FASTFortran2kExporterVisitorTest >> testProgramEmpty [
	"
program demo
end program demo
"

	| stmt |
	stmt := FASTFortran2kProgramMain new
		name: 'demo';
		backTrace: self stubFile ;
		yourself.

	self assertExport: stmt equals: 'program demo
end program demo

'
]

{ #category : 'testing - type-definitions' }
FASTFortran2kExporterVisitorTest >> testReadStatementWellFormatted [
	| stmt |

	stmt := self
		readStatement: #(V)
		ioParams: {
			1 .
			self assignementExpression: #rec value: 3 .
			self assignementExpression: #iostat value: #N .
			self assignementExpression: #err value: 8
		}.

	self
		assertExport: stmt
		equals: 'read (1, rec = 3, iostat = N, err = 8) V
'
]

{ #category : 'testing - type-definitions' }
FASTFortran2kExporterVisitorTest >> testSpecialIntrinsicType [

	self
		assertExport: (FASTFortran2kSpecialIntrinsicType new name: 'int64')
		equals: 'integer(int64)'
]

{ #category : 'testing - type-definitions' }
FASTFortran2kExporterVisitorTest >> testTypeBookDefinition [

	| stmt |
	stmt := self segmentBookDefinition.

	self
		assertExport: stmt
		equals: 
'public book
type :: book
  character(len=40) :: btitle
  integer :: bpages
  real :: budc
end type book
'
]

{ #category : 'testing - type-definitions' }
FASTFortran2kExporterVisitorTest >> testTypeBoxedBookDefinition [

	| stmt |

	stmt := self segmentBoxedBookDefinition.

	self
		assertExport: stmt
		equals:
'public boxed_book
type, extends(segment) :: boxed_book
  type(book), pointer, private :: this
end type boxed_book
'
]

{ #category : 'testing - type-definitions' }
FASTFortran2kExporterVisitorTest >> testTypeDefinition [

	| stmt |
	stmt := FASTFortran2kDerivedTypeDefinition new
		name: 'point_t';
		statements: {
			(FASTFortran2kVariableDeclarationStatement new
						addDeclarator: (FASTFortran2kVariableDeclarator new name: 'label') ;
				declaredType: (FASTFortran2kCharacterType new size: FASTFortran2kAsterisk new) ;
				yourself)
			.
			(FASTFortran2kVariableDeclarationStatement new
				addDeclarator: (FASTFortran2kVariableDeclarator new name: 'x') ;
				declaredType: FASTFortran2kRealType new;
				yourself) };
		yourself.

	self
		assertExport: stmt
		equals:
'public point_t
type :: point_t
  character(len=*) :: label
  real :: x
end type point_t
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testUseStatementIntrinsicSimple [
	| stmt |

	stmt := FASTFortran2kUseStatement new 
		name: 'module_name'; 
		modifiers: #( intrinsic );
		yourself.

	self
		assertExport: stmt
		equals: 
'use, intrinsic :: module_name
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testUseStatementOnlyWithRenaming [

	| stmt |
	stmt := FASTFortran2kUseOnlyStatement new
		name: 'module_name' ;
		useNoRenames: { FASTFortran2kUseNoRename new name: 'int64' } ;
		useRenames: { FASTFortran2kUseRename new name: 'int32' ; alias: 'i4'; yourself } ;
		yourself.

	self
		assertExport: stmt
		equals:
'use :: module_name, only: int64, i4 => int32
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testUseStatementOnlyWithRenamings [

	| stmt |
	stmt := FASTFortran2kUseOnlyStatement new
		        name: 'module_name';
		        useNoRenames: 
			        { (FASTFortran2kUseNoRename new
				         name: 'int64';
				         yourself) };
		        useRenames: {
				        (FASTFortran2kUseRename new
					         name: 'int32';
					         alias: 'i4';
					         yourself).
				        (FASTFortran2kUseRename new
					         name: 'real32';
					         alias: 'r4';
					         yourself) };
		        yourself.

	self
		assertExport: stmt
		equals: 'use :: module_name, only: int64, i4 => int32, r4 => real32
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testUseStatementOnlyWithoutRenaming [

	| stmt |
	stmt := FASTFortran2kUseOnlyStatement new
		        name: 'module_name';
		        useNoRenames: {
				        (FASTFortran2kUseNoRename new
					         name: 'int64';
					         yourself).
				        (FASTFortran2kUseNoRename new
					         name: 'int32';
					         yourself) };
		        yourself.

	self
		assertExport: stmt
		equals: 'use :: module_name, only: int64, int32
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testUseStatementSimple [

	| stmt |

	stmt := FASTFortran2kUseStatement new name: 'module_name'.

	self assertExport: stmt equals: 'use :: module_name
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testUseStatementWithRenaming [
	| stmt |

	stmt := FASTFortran2kUseStatement new 
		name: 'module_name'; 
		useRenames: { 
			FASTFortran2kUseRename new name: 'output_unit'; alias: 'output'; yourself 
		}; 
		yourself.

	self
		assertExport: stmt
		equals: 
'use :: module_name, output => output_unit
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testUseStatementWithRenamings [

	| stmt |

	stmt := FASTFortran2kUseStatement new
		name: 'module_name';
		useRenames: {
			FASTFortran2kUseRename new name: 'output_unit' ; alias: 'output' .
			FASTFortran2kUseRename new name: 'input_unit' ; alias: 'input'
		} ;
		yourself.

	self
		assertExport: stmt
		equals:
'use :: module_name, output => output_unit, input => input_unit
'
]

{ #category : 'testing - type-definitions' }
FASTFortran2kExporterVisitorTest >> testUserDefinedType [

	self
		assertExport: (FASTFortran2kUserDefinedType new name: 'someType')
		equals: 'type(someType)'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testVariableDeclarationStatementArray1Dim [

	| stmt declarator |

	declarator := (self variableDeclarator: 'str')
		dimensions: {
			FASTFortran2kArrayRange new upperBound: (self integerLiteral: '5')
		}.
	stmt := FASTFortran2kVariableDeclarationStatement new
		declaredType: (self characterType: 30) ;
		declarators: { declarator } ;
		yourself.

	self
		assertExport: stmt
		equals:
'character(len=30) :: str(5)
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testVariableDeclarationStatementArray2DimsNoBounds [

	| stmt declarator |
	declarator := (self variableDeclarator: 'str')
		dimensions: {
			FASTFortran2kArrayRange new .
			FASTFortran2kArrayRange new
		}.
	stmt := FASTFortran2kVariableDeclarationStatement new
		declaredType: (self characterType: 30) ;
		declarators: { declarator } ;
		yourself.

	self
		assertExport: stmt
		equals:
'character(len=30) :: str(:, :)
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testVariableDeclarationStatementPointer [

	| stmt |
	stmt := FASTFortran2kVariableDeclarationStatement new
		declaredType: (FASTFortran2kUserDefinedType new name: 'point_t') ;
		declarators: { (FASTFortran2kVariableDeclarator new name: 'p1') } ;
		modifiers: #( pointer ) ;
		yourself.

	self
		assertExport: stmt
		equals:
'type(point_t), pointer :: p1
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testVariableDeclarationStatementPointerTwoVars [

	| stmt |
	stmt := FASTFortran2kVariableDeclarationStatement new
		declaredType: (FASTFortran2kUserDefinedType new name: 'point_t') ;
		declarators: {
			(FASTFortran2kVariableDeclarator new name: 'p1')
			.
			(FASTFortran2kVariableDeclarator new name: 'p2') } ;
		modifiers: #( pointer ) ;
		yourself.

	self
		assertExport: stmt
		equals:
'type(point_t), pointer :: p1, p2
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testWriteStatement [
	| stmt |
	stmt := self writeStatement: #( 'message' ).

	self
		assertExport: stmt
		equals: 
'write (*, *) ''message''
'
]
