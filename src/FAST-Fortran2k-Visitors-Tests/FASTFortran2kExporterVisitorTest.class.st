Class {
	#name : 'FASTFortran2kExporterVisitorTest',
	#superclass : 'TestCase',
	#instVars : [
		'visitor'
	],
	#category : 'FAST-Fortran2k-Visitors-Tests',
	#package : 'FAST-Fortran2k-Visitors-Tests'
}

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> assertExport: anEntity equals: expectedString [

	anEntity accept: visitor.
	self assert: visitor outputStream contents equals: expectedString
]

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> characterType: dimension [
	^FASTFortran2kCharacterType new
		size: (self typeSize: dimension) ;
		yourself
]

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> declarationStatement: typeDescription variables: aCollection [
	"Bulk declaration of several variables"

	^FASTFortran2kVariableDeclarationStatement new
		declaredType: (self makeType: typeDescription) ;
		declarators: (self variableDeclarators: aCollection)  ;
		yourself
]

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> integerLiteral: value [
	^FASTFortran2kIntegerLiteral new
		primitiveValue: value ;
		yourself
]

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> integerType: dimension [
	^FASTFortran2kIntegerType new
		size: (self typeSize: dimension) ;
		yourself
]

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> logicalType: dimension [
	^FASTFortran2kLogicalType new
]

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> makeType: typeDescription [
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
FASTFortran2kExporterVisitorTest >> newVisitor [

	^FASTFortran2kExporterVisitor new
]

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> realType: dimension [
	^FASTFortran2kRealType new
		size: (self typeSize: dimension) ;
		yourself
]

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> segmentBookDefinition [

	^ FASTFortran2kDerivedTypeDefinition new
		  name: 'book';
		  fields: {
				  (FASTFortran2kDerivedTypeComponent new
					   declaredType: (FASTFortran2kCharacterType new size:
								    (FASTFortran2kIntegerLiteral new primitiveValue: 40));
					   declarators:
						   { (FASTFortran2kVariableDeclarator new name: 'btitle') };
					   yourself).
				  (FASTFortran2kDerivedTypeComponent new
					   declaredType: FASTFortran2kIntegerType new;
					   declarators:
						   { (FASTFortran2kVariableDeclarator new name: 'bpages') };
					   yourself).
				  (FASTFortran2kDerivedTypeComponent new
					   declaredType: FASTFortran2kRealType new;
					   declarators:
						   { (FASTFortran2kVariableDeclarator new name: 'budc') };
					   yourself) };
		  yourself
]

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> segmentBoxedBookDefinition [

	^ FASTFortran2kDerivedTypeDefinition new
		  name: 'boxed_book';
		  superType: 'segment';
		  fields: {
				  (FASTFortran2kDerivedTypeComponent new
					   type: (FASTFortran2kUserDefinedType new name: 'book');
					   declarators: { (FASTFortran2kVariableDeclarator new name: 'this') };
"						isPointer: true;"
"						isPrivate: true;"
					   yourself
					)
			};
		  yourself
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> setBacktraceLines: aPoint to: aFASTStatementEntity [

	| famixEntity |
	famixEntity := Mock new.
	famixEntity stub startLine willReturn: aPoint x.
	famixEntity stub endLine willReturn: aPoint y.
	aFASTStatementEntity backTrace: famixEntity
]

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> setUp [
	super setUp.

	visitor := self newVisitor
]

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> stubFile [

	| stubFile |
	stubFile := Mock named: 'fortranSource.f'.
	stubFile stub asFileReference willReturn: stubFile.
	stubFile stub readStream willReturn: stubFile.
	stubFile stub contents willReturn: ''.

	^stubFile
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
		statementBlock: (FASTFortranStatementBlock new statements:
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

{ #category : 'testing - program-units' }
FASTFortran2kExporterVisitorTest >> testProgram [
	"
program demo
	implicit none
	type(point_t) :: p
end program demo
"

	| stmt |
	stmt := FASTFortran2kProgramMain new
		name: 'demo';
		statementBlock:
			(FASTFortran2kStatementBlock new
				statements: {
					FASTFortran2kImplicitStatement new
					.
					(FASTFortran2kDerivedTypeDeclaration new
						declaredType: (FASTFortran2kUserDefinedType new name: 'point_t') ;
						declarators: { FASTFortran2kVariableDeclarator new name: 'p' } ;
						yourself) } ) ;
		backTrace: self stubFile ;
		yourself.

	self
		assertExport: stmt
		equals:
'program demo
  implicit none
  type (point_t) :: p
end program demo
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
FASTFortran2kExporterVisitorTest >> testTypeBookDefinition [

	| stmt |
	stmt := self segmentBookDefinition.

	self
		assertExport: stmt
		equals: 
'type :: book
  character(len=40) :: btitle
  integer :: bpages
  real :: budc
end type book
'
]

{ #category : 'testing - type-definitions' }
FASTFortran2kExporterVisitorTest >> testTypeBoxedBookDefinition [

	| stmt |
	self skip: 'TODO'.

	stmt := self segmentBoxedBookDefinition.

	self
		assertExport: stmt
		equals:
'type, extends(segment) :: boxed_book
  type(book), pointer, private :: this
end type boxed_book
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testTypeDeclarationStatement [

	| stmt |
	stmt := FASTFortran2kDerivedTypeDeclaration new
		 declaredType: (FASTFortran2kUserDefinedType new name: 'point_t') ;
		 declarators: { (FASTFortran2kVariableDeclarator new name: 'p1') } ;
		 yourself.

	self
		assertExport: stmt
		equals:
'type (point_t) :: p1
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testTypeDeclarationsStatement [

	| stmt |
	stmt := FASTFortran2kDerivedTypeDeclaration new
		declaredType: (FASTFortran2kUserDefinedType new name: 'point_t');
		declarators: {
			(FASTFortran2kVariableDeclarator new name: 'p1')
			.
			(FASTFortran2kVariableDeclarator new name: 'p2') };
		yourself.

	self
		assertExport: stmt
		equals:
'type (point_t) :: p1, p2
'
]

{ #category : 'testing - type-definitions' }
FASTFortran2kExporterVisitorTest >> testTypeDefinition [

	| stmt |
	stmt := FASTFortran2kDerivedTypeDefinition new
		name: 'point_t';
		fields: {
			(FASTFortran2kDerivedTypeComponent new
				declaredType: (FASTFortran2kCharacterType new size: FASTFortran2kAsterisk new) ;
				declarators: { (FASTFortran2kVariableDeclarator new name: 'label') } ;
				yourself)
			.
			(FASTFortran2kDerivedTypeComponent new
				declaredType: FASTFortran2kRealType new;
				declarators: {
					(FASTFortran2kVariableDeclarator new name: 'x').
					(FASTFortran2kVariableDeclarator new name: 'y') };
				yourself) };
		yourself.

	self
		assertExport: stmt
		equals:
'type :: point_t
  character(len=*) :: label
  real :: x, y
end type point_t
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testUseStatementIntrinsicSimple [
	| stmt |

	self skip: 'TODO'.

	stmt := FASTFortran2kUseStatement new 
		name: 'module_name'; 
		"isIntrinsic: true;"
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
		name: 'module_name';
		useNoRenamedStatements: { FASTFortran2kUseNoRenamedStatement new name: 'int64' } ;
		useRenamedStatements: { FASTFortran2kUseRenamedStatement new name: 'int32' ; alias: 'i4' } ;
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
		        useNoRenamedStatements:
			        { (FASTFortran2kUseNoRenamedStatement new
				         name: 'int64';
				         yourself) };
		        useRenamedStatements: {
				        (FASTFortran2kUseRenamedStatement new
					         name: 'int32';
					         alias: 'i4';
					         yourself).
				        (FASTFortran2kUseRenamedStatement new
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
		        useNoRenamedStatements: {
				        (FASTFortran2kUseNoRenamedStatement new
					         name: 'int64';
					         yourself).
				        (FASTFortran2kUseNoRenamedStatement new
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

	self skip: 'TODO'.

	stmt := FASTFortran2kUseStatement new name: 'module_name'.

	self assertExport: stmt equals: 'use :: module_name
'
]

{ #category : 'testing - statements' }
FASTFortran2kExporterVisitorTest >> testUseStatementWithRenaming [
	| stmt |

	self skip: 'TODO'.

	stmt := FASTFortran2kUseStatement new 
		name: 'module_name'; 
		useRenamedStatements:  { 
			FASTFortran2kUseRenamedStatement new name: 'output_unit'; alias: 'output'; yourself 
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

	self skip: 'TODO'.

	stmt := FASTFortran2kUseStatement new
		name: 'module_name';
		useRenamedStatements: {
			FASTFortran2kUseRenamedStatement new name: 'output_unit' ; alias: 'output'
			.
			FASTFortran2kUseRenamedStatement new name: 'input_unit' ; alias: 'input'
		} ;
		yourself.

	self
		assertExport: stmt
		equals:
'use :: module_name, output => output_unit, input => input_unit
'
]

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> typeSize: dimension [
	dimension isNumber ifTrue: [ ^self integerLiteral: dimension asString ].
	dimension = '*' ifTrue: [ ^FASTFortran2kAsterisk new ].
	^nil
]

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> variableDeclarator: aName [
	^FASTFortran2kVariableDeclarator new
		name: aName ;
		yourself
]

{ #category : 'running' }
FASTFortran2kExporterVisitorTest >> variableDeclarators: aCollectionOfString [
	^aCollectionOfString collect: [ :aString | self variableDeclarator: aString ]
]
