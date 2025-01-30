Class {
	#name : 'FASTFortranModelTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractVisitorTest',
	#instVars : [
		'fastProgramFile',
		'famixProgramFile'
	],
	#category : 'FAST-Fortran2k-Visitors-Tests',
	#package : 'FAST-Fortran2k-Visitors-Tests'
}

{ #category : 'running' }
FASTFortranModelTransformationVisitorTest >> fooSegment [

	^(FASTEsopeSegment new name: 'foo')
		statements: { 
			FASTFortranVariableDeclarationStatement new
				declaredType: (FASTFortranIntegerType new); 
				declarators: { 
					FASTFortranVariableDeclarator new
						name: 'bar'
				} 
		} ;
		yourself
]

{ #category : 'running' }
FASTFortranModelTransformationVisitorTest >> newVisitor [

	^FASTFortranModelTransformationVisitor new
]

{ #category : 'running' }
FASTFortranModelTransformationVisitorTest >> setUp [ 

	super setUp.

	
	fastProgramFile := FASTFortranProgramFile new.
	famixProgramFile := FamixF77ProgramFile new filename: 'someFile.f'.

	fastProgramFile famix: famixProgramFile.
	
]

{ #category : 'running' }
FASTFortranModelTransformationVisitorTest >> testArrayDeclaration [
	| stmt dst |
	stmt := self arrayDeclaration: 'v' dimensions: #( #('1' '10') ).
	
	dst := stmt accept: visitor.

	self
		assert: dst class
		equals: FASTFortran2kVariableDeclarationStatement.
]

{ #category : 'running' }
FASTFortranModelTransformationVisitorTest >> testAssignementStatementLiteralValue [
	| stmt res |
	stmt := self assignementStatement: #aVar value: (self logicalLiteral: '.true.').
	
	res := stmt accept: visitor.
	
	self assert: res class equals: FASTFortran2kAssignmentStatement.
	self assert: res variable class equals: FASTFortran2kScalarVariable.
	self assert: res expression class equals: FASTFortran2kBooleanLiteral.
	
	self assert: res variable name equals: 'aVar'.
	self assert: res expression primitiveValue equals: '.true.'.
]

{ #category : 'running' }
FASTFortranModelTransformationVisitorTest >> testComment [
	| cmt dst |
	cmt := self comment: 'This is a comment'.
	
	dst := cmt accept: visitor.
	
	self assert: dst class equals: FASTFortran2kComment.
	self assert: dst content equals: 'This is a comment'.
]

{ #category : 'running' }
FASTFortranModelTransformationVisitorTest >> testDoStatement [
	| stmt res loopControl |

	stmt := self doStatement: #(i 1 max 1) statements: #().
	
	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kDoStatement.
	
	loopControl := res loopControl.
	
	self assert: loopControl class equals: FASTFortran2kLoopControlExpression.
	self assert: loopControl init class equals: FASTFortran2kAssignmentExpression.
	self assert: loopControl init variable class equals: FASTFortran2kScalarVariable.
	self assert: loopControl init expression class equals: FASTFortran2kIntegerLiteral.
]

{ #category : 'running' }
FASTFortranModelTransformationVisitorTest >> testEsopeSegmentToDerivedTypeInModule [
	"
	segment foo
	integer bar
	end segment
	"

	| stmt res f2ksegment |
	
	stmt := self fooSegment.
	
	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kModule.
	self assert: res name equals: 'foo_m'.
	
	f2ksegment := res statementBlock statements detect: [ :e | e class = FASTFortran2kDerivedTypeDefinition ].
	
	self assert: f2ksegment name equals: 'foo'.
	
	self assert: f2ksegment derivedTypeComponents size equals: 1.
	
	stmt := f2ksegment derivedTypeComponents anyOne.
	self assert: stmt class equals: FASTFortran2kDerivedTypeComponent.
	self assert: stmt type class equals: FASTFortran2kIntegerType.
	self assert: stmt declarators size equals: 1.
	
	stmt := stmt declarators first.
	self assert: stmt class equals: FASTFortran2kVariableDeclarator.
	self assert: stmt name equals: 'bar'.
]

{ #category : 'running' }
FASTFortranModelTransformationVisitorTest >> testEsopeSegmentWithArrayFieldToDerivedTypeInModule [
	"
	segment foo
	integer bar(N)
	end segment
	"

	| stmt res f2ksegment |
	
	stmt := self fooSegment.
	stmt statements anyOne declarators anyOne
		dimensions: { FASTFortranArrayRange new upperBound: (self scalarVariable: #N) }.
	
	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kModule.
	self assert: res name equals: 'foo_m'.
	
	f2ksegment := res statementBlock statements detect: [ :e | e class = FASTFortran2kDerivedTypeDefinition ].
	
	self assert: f2ksegment name equals: 'foo'.
	
	self assert: f2ksegment derivedTypeComponents size equals: 2.
	
	stmt := f2ksegment derivedTypeComponents first.
	self assert: stmt class equals: FASTFortran2kDerivedTypeComponent.
	self assert: stmt type class equals: FASTFortran2kIntegerType.
	self assert: stmt declarators size equals: 1.
	self assert: stmt declarators anyOne class equals: FASTFortran2kVariableDeclarator.
	self assert: stmt declarators anyOne name equals: 'N'.
	
	stmt := f2ksegment derivedTypeComponents second.
	self assert: stmt class equals: FASTFortran2kDerivedTypeComponent.
	self assert: stmt type class equals: FASTFortran2kIntegerType.
	self assert: stmt declarators size equals: 1.
	
	stmt := stmt declarators first.
	self assert: stmt class equals: FASTFortran2kVariableDeclarator.
	self assert: stmt name equals: 'bar'.
]

{ #category : 'running' }
FASTFortranModelTransformationVisitorTest >> testMultipleProceduresMovedToModule [
	"
C	--------someFile.f----------------
	subroutine sub
	end
	real function f()
	end function
C  -----end someFile.f --------------

C	--------someFile_mod.f90----------------
module sub_mod
	implicit none
contains
	subroutine sub()
	end subroutine sub
	real function f()
	end function f
end sub_mod
C	--------end someFile_mod.f90----------------

	"

	| subroutine function res module |
	
	subroutine := FASTFortranSubroutine new
		name: 'sub' ;
		statementBlock: FASTFortranStatementBlock new ;
		famix: (FamixF77PUSubroutine new name: 'sub') ; 
			yourself.

	function := FASTFortranFunction new 
		name: 'f' ;
		statementBlock: FASTFortranStatementBlock new ;
		famix: (FamixF77PUFunction new
			name: 'f' ; 
			declaredType: (FamixF77TypeIntrinsic new name: 'real')) ;
		yourself.

	fastProgramFile
	 	addProgramUnit: subroutine ;
	 	addProgramUnit: function.
		
	res := fastProgramFile accept: visitor.
	
	self assert: res class equals: FASTFortran2kProgramFile.
	self assert: res programUnit size equals: 1.
	
	module := res programUnit anyOne.
	self assert: module class equals: FASTFortran2kModule.
	self assert: module name equals: 'someFile_mod'.
	self assert: module procedures size equals: 2.
	
	res := module procedures first.
	self assert: res class equals: FASTFortran2kSubroutine.
	self assert: res name equals: 'sub'.

	res := module procedures second.
	self assert: res class equals: FASTFortran2kFunction.
	self assert: res name equals: 'f'.

]

{ #category : 'running' }
FASTFortranModelTransformationVisitorTest >> testProcedureInProgFileMovedToModule [
	"
C	--------someFile.f----------------
	subroutine sub
	print*, 'hello'
	end
C  -----end someFile.f --------------

C	--------someFile_mod.f90----------------
module someFile_mod
	implicit none
contains
	subroutine sub()
	print *, 'hello'
	end subroutine sub
end module someFile_mod
C	--------end someFile_mod.f90----------------

	"

	| subroutine res |
	
	subroutine := FASTFortranSubroutine new 
			name: 'sub'; 
			statementBlock: (FASTFortranStatementBlock new
				statements: {
					FASTFortranPrintStatement new
						format: FASTFortranAsterisk new;
						arguments: { FASTFortranCharacterLiteral new primitiveValue: 'Hello' }; 
						yourself
				}
			); 
			yourself.

	fastProgramFile addProgramUnit: subroutine.

	subroutine famix: (FamixF77PUSubroutine new name: 'sub').
		
	res := fastProgramFile accept: visitor.
	
	self assert: res class equals: FASTFortran2kProgramFile.
	self assert: res programUnit size equals: 1.
	
	res := res programUnit first.
	self assert: res class equals: FASTFortran2kModule.
	self assert: res name equals: 'someFile_mod'.
	self assert: res procedures size equals: 1.
	
	res := res procedures first.
	self assert: res class equals: FASTFortran2kSubroutine.
	self assert: res name equals: 'sub'.
	self assert: res parameters size equals: 0.
	self assert: res statementBlock statements size equals: 1.
	self assert: res statementBlock statements first class equals: FASTFortran2kPrintStatement.
	

]

{ #category : 'running' }
FASTFortranModelTransformationVisitorTest >> testProgramAndProcedureMovedToProgranAndModule [
	"
	subroutine sub
	end
	program demo
	call sub()
	end

------------------------

module someFile_mod
	implicit none
contains
	subroutine sub()
	end subroutine sub
end module someFile_mod

program demo
	use :: someFile_mod
	implicit none
	call sub()
end program demo

"

	| sourceFileDst subroutine programMain subCallStatement stmt entity |

	subroutine := (self subroutine: 'sub')
			famix: (FamixF77PUSubroutine new name: 'sub'; programFile: famixProgramFile);
			yourself.

	subCallStatement := self callStatement: 'sub' arguments: #().
	
	programMain := FASTFortranProgramMain new 
		name: 'demo';
		statementBlock: (self statementBlock: {subCallStatement});
		famix: (FamixF77PUMain new name: 'demo'; programFile: famixProgramFile);
		yourself.

	subCallStatement  famix: (FamixF77Invocation new 
		sender: programMain famix;
		addCandidate: subroutine famix;
		yourself
	).
	
	fastProgramFile programUnit: { subroutine . programMain }.

	sourceFileDst := fastProgramFile accept: visitor.
	
	self assert: sourceFileDst class equals: FASTFortran2kProgramFile.
	self assert: sourceFileDst programUnit size equals: 2.
	
	entity := sourceFileDst programUnit first.
	self assert: entity class equals: FASTFortran2kModule.
	self assert: entity name equals: 'someFile_mod'.
	self assert: entity procedures size equals: 1.
	
	entity := entity procedures first.
	self assert: entity class equals: FASTFortran2kSubroutine.
	self assert: entity name equals: 'sub'.
	
	entity := sourceFileDst programUnit second.
	self assert: entity class equals: FASTFortran2kProgramMain.
	self assert: entity name equals: 'demo'.
	self assert: entity statementBlock statements size equals: 3.
	
	stmt := entity statementBlock statements first.
	self assert: stmt class equals: FASTFortran2kUseStatement.
	self assert: stmt name equals: 'someFile_mod'.
	
	stmt := entity statementBlock statements second.
	self assert: stmt class equals: FASTFortran2kImplicitStatement.
	
	stmt := entity statementBlock statements third.
	self assert: stmt class equals: FASTFortran2kCallStatement.
	
]

{ #category : 'tests-programUnit' }
FASTFortranModelTransformationVisitorTest >> testProgramEmpty [
	| src dst entity |

	src := FASTFortranProgramMain new 
		name: 'demo'; 
		statementBlock: FASTFortranStatementBlock new; 
		yourself.
		
	dst := src accept: visitor.
	
	self assert: dst class equals: FASTFortran2kProgramMain.
	self assert: dst name equals: 'demo'.
	self assert: dst statementBlock statements size equals: 1.
	
	entity := dst statementBlock statements first.
	self assert: entity class equals: FASTFortran2kImplicitStatement.
	
]

{ #category : 'running' }
FASTFortranModelTransformationVisitorTest >> testProgramMainWithCppInclude [
	"
+------ incFile.obj --------------------------------+    
|      integer N                                    |
+---------------------------------------------------+ 

+------ mainFile.E ---------------------------------+
|      program main                                 |
|#include ""incFile.obj""                           |
|      end                                          |
+---------------------------------------------------+
                     |
                     v
						cpp -E 
                     |
                     v
+------ mainFile.E ---------------------------------+
|      program main                                 |
|      integer N                                    |
|      end                                          |
+---------------------------------------------------+

translated in
	"

	| incFile mainFile fakeIncObj varDeclarationN programMain cppInclude famixIncludedFile res |
	
	self skip: #TODO.

	varDeclarationN := FASTFortranVariableDeclarationStatement new
		declaredType: (FASTFortranIntegerType new);
		addDeclarator: (FASTFortranVariableDeclarator new name: 'N');
		yourself.
	
	famixIncludedFile := FamixF77IncludedFile new 
			name: '_$incFile_obj';
			addLocalVariable: (FamixF77Variable new name: 'N'; declaredType: (FamixF77TypeIntrinsic new name: 'integer'));
			yourself.
	
	fakeIncObj := FASTFortranSubroutine new 
		name: '_$incFile_obj';
		statementBlock: (FASTFortranStatementBlock  new addStatement: varDeclarationN; yourself);
		famix: famixIncludedFile;
		yourself.
	
	cppInclude := FASTFortran2kIncludeStatement new filename: 'inc.obj'.

	programMain := FASTFortranProgramMain new 
		name: 'main';
		statementBlock: (FASTFortranStatementBlock  new 
			addStatement: cppInclude;
			yourself
		);
		yourself.

	programMain famix: (FamixF77PUMain new 
		name: 'main';
		addInclude: (FamixF77Include new 
			filename: '';
			included: famixIncludedFile;
			yourself
		);
		yourself).

	incFile := FASTFortranProgramFile new 
		addProgramUnit: fakeIncObj;
		famix: (FamixF77ProgramFile new name: 'inc.obj.E');
		yourself.

	mainFile := FASTFortranProgramFile new 
		addProgramUnit: programMain;
		famix: (FamixF77ProgramFile new name: 'progFile.f');
		yourself.
	

	res := mainFile accept: visitor.
	
	self assert: res programUnit size equals: 1.
	res := res programUnit anyOne.
	self assert: res class equals: FASTFortran2kProgramMain.
	self assert: res name equals: 'main'.
	self assert: res statementBlock size equals: 2.
	self assert: res statementBlock first class equals: FASTFortran2kUseStatement.
	self assert: res statementBlock first name equals: 'inc_obj_mod'.
	self assert: res statementBlock second class equals: FASTFortran2kImplicitStatement.

]

{ #category : 'tests-statement' }
FASTFortranModelTransformationVisitorTest >> testProgramMainWithFunctionStatement [
	"
     PROGRAM demo
     fct(x)  = x + 2
     END

program demo
	implicit none
contains
    real function fct(x)
	 real, intent(in) :: x
    fct = x + 2
    end function fct
end program demo
		
	"
	| src dst var fctStatement entity |
	
	var := self scalarVariable: #x.
	
	fctStatement := FASTFortranFunctionStatement new
						name: 'fct';
						parameters: { var };
						expression: (self binary: '+' left: #x right: 2);
						yourself.
	
	
	fctStatement famix: (FamixF77StatementFunction new 
		name: fctStatement name;
		declaredType: (FamixF77TypeIntrinsic new name: 'real');
		yourself
	).
	
	var famixParameter: (FamixF77Parameter new 
		name: 'x'; 
		declaredType: (FamixF77TypeIntrinsic new name: 'real'); 
		yourself
	).
				

	src := FASTFortranProgramMain new 
		name: 'demo'; 
		statementBlock: (
			FASTFortranStatementBlock new
				statements: {fctStatement}
		); 
		yourself.

		
	dst := src accept: visitor.
	
	self assert: dst class equals: FASTFortran2kProgramMain.
	self assert: dst name equals: 'demo'.
	self assert: dst internalProcedures size equals: 1.
	
	entity := dst internalProcedures first.
	self assert: entity class equals: FASTFortran2kInternalFunction.
	self assert: entity name equals: 'fct'.
	self assert: entity returnType class equals: FASTFortran2kRealType.
	self assert: entity statementBlock statements size equals: 2.
	self assert: entity parameters size equals: 1.
	
	entity := entity parameters first.
	self assert: entity class equals: FASTFortran2kScalarVariable.
	self assert: entity name equals: 'x'.

]

{ #category : 'tests-statement' }
FASTFortranModelTransformationVisitorTest >> testProgramMainWithFunctionStatementCalled [
	"
     PROGRAM demo
     fct()  = 5
     aVar = fct()
     END

-----------------------------

program demo
	implicit none
	aVar = fct()
contains
    real function fct()
    fct = 5
    end function fct
end program demo
		
	"
	| fastMain res fastFunctionStatement entity fastCallStatement |
	
	fastFunctionStatement := FASTFortranFunctionStatement new
						name: 'fct';
						parameters: {};
						expression: (self integerLiteral: 5);
						yourself.
	
	
	fastFunctionStatement famix: (FamixF77StatementFunction new 
		name: fastFunctionStatement name;
		declaredType: (FamixF77TypeIntrinsic new name: 'real');
		yourself
	).
	
	fastCallStatement := self assignementStatement: 'aVar' value: (self functionCall: 'fct' arguments: {}).

	fastMain := FASTFortranProgramMain new 
		name: 'demo';
		famix: (FamixF77PUMain new programFile: famixProgramFile) ;
		statementBlock: (self statementBlock: {
			fastFunctionStatement .
			fastCallStatement } ) ;
		yourself.

	fastFunctionStatement famix parentEntity: fastMain famix.

	fastCallStatement expression famix: (
		FamixF77Invocation new
			sender: fastMain famix ;
			addCandidate: fastFunctionStatement famix ;
			yourself
		).

	fastProgramFile addProgramUnit: fastMain.

	res := fastProgramFile accept: visitor.

	self assert: res programUnit size equals: 1.
	res := res programUnit anyOne.
	
	self assert: res class equals: FASTFortran2kProgramMain.
	self assert: res name equals: 'demo'.
	self assert: res statementBlock statements size equals: 2.
	self assert: res statementBlock statements first class equals: FASTFortran2kImplicitStatement.
	self assert: res statementBlock statements second class equals: FASTFortran2kAssignmentStatement.

	self assert: res internalProcedures size equals: 1.
	
	entity := res internalProcedures first.
	self assert: entity class equals: FASTFortran2kInternalFunction.
	self assert: entity name equals: 'fct'.
	self assert: entity returnType class equals: FASTFortran2kRealType.
	self assert: entity statementBlock statements size equals: 1.
	self assert: entity parameters size equals: 0.
	
]

{ #category : 'tests-statement' }
FASTFortranModelTransformationVisitorTest >> testProgramWithExternalFunctionCall [
	"
	function 'fct' defined in another externalFile.f'
     PROGRAM demo
     x = fct()
     END

-----------------------------

program demo
	use :: externalFile_mod
	implicit none
	aVar = fct()
end program demo
		
	"
	| fastMain res fastCallStatement stmt famixFunction |
	
	famixFunction := FamixF77PUFunction new
		name: 'fct' ;
		programFile: (FamixF77ProgramFile new filename: 'externalFile.f') ;
		yourself.
			
	fastCallStatement := self assignementStatement: 'aVar' value: (self functionCall: 'fct' arguments: {}).

	fastMain := FASTFortranProgramMain new 
		name: 'demo'; 
		statementBlock: (self statementBlock: { fastCallStatement } );
			famix: (FamixF77PUMain new
				name: 'demo' ;
				programFile: famixProgramFile);
		yourself.

	fastCallStatement expression famix: (
		FamixF77Invocation new
			sender: fastMain famix ;
			addCandidate: famixFunction ;
			yourself
		).
		
	fastProgramFile addProgramUnit: fastMain.

	res := fastProgramFile accept: visitor.
	
	self assert: res programUnit size equals: 1.
	res := res programUnit anyOne.
	self assert: res class equals: FASTFortran2kProgramMain.
	self assert: res statementBlock statements size equals: 3.

	stmt := res statementBlock statements first.
	self assert: stmt class equals: FASTFortran2kUseStatement.
	self assert: stmt name equals: 'externalFile_mod'.
	
	stmt := res statementBlock statements second.
	self assert: stmt class equals: FASTFortran2kImplicitStatement.
	
	stmt := res statementBlock statements third.
	self assert: stmt class equals: FASTFortran2kAssignmentStatement.

]

{ #category : 'running' }
FASTFortranModelTransformationVisitorTest >> testProgramWithExternalSubroutineInvocation [
	"
	subrotine 'sub' defined in another externalFile.f'

C	--------someFile.f----------------
	program demo
	call sub
	end
C  -----end someFile.f --------------

C	--------someFile.f90----------------
program demo
	use :: externalFile_mod
	implicit none
	call sub()
end program demo
C	--------end someFile.f90----------------
	"

	| famixSubroutine fastMain fastCallStatement res  stmt |

	famixSubroutine := FamixF77PUSubroutine new
		name: 'sub' ;
		programFile: (FamixF77ProgramFile new filename: 'externalFile.f');
		yourself.
			
	fastCallStatement := self callStatement: 'sub' arguments: #().
	
	fastMain :=  FASTFortranProgramMain new 
			name: 'demo'; 
			statementBlock: (self statementBlock: { fastCallStatement } );
			famix: (FamixF77PUMain new
				name: 'demo' ;
				programFile: famixProgramFile);
			yourself.
	
	fastCallStatement famix: (
		FamixF77Invocation new
			sender: fastMain famix ;
			addCandidate: famixSubroutine ;
			yourself
		).
		
	fastProgramFile addProgramUnit: fastMain.

	res := fastProgramFile accept: visitor.

	self assert: res programUnit size equals: 1.
	res := res programUnit anyOne.
	self assert: res class equals: FASTFortran2kProgramMain.
	self assert: res statementBlock statements size equals: 3.
	
	stmt := res statementBlock statements first.
	self assert: stmt class equals: FASTFortran2kUseStatement.
	self assert: stmt name equals: 'externalFile_mod'.
	
	stmt := res statementBlock statements second.
	self assert: stmt class equals: FASTFortran2kImplicitStatement.
	
	stmt := res statementBlock statements third.
	self assert: stmt class equals: FASTFortran2kCallStatement.

]
