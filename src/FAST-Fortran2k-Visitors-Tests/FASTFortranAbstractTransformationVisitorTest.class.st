Class {
	#name : 'FASTFortranAbstractTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractVisitorTest',
	#instVars : [
		'fastProgramFile',
		'famixProgramFile',
		'fastMainProgram',
		'fastProcedures'
	],
	#category : 'FAST-Fortran2k-Visitors-Tests',
	#package : 'FAST-Fortran2k-Visitors-Tests'
}

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> functionEmpty [
	"---- demo.f ----
	integer function fct()
	end function fct"

	| famix |
	famix := FamixF77PUFunction new
			name: 'fct' ; 
			declaredType: (FamixF77TypeIntrinsic new name: 'integer') ;
			programFile: famixProgramFile.

	fastProcedures := { FASTFortranFunction new 
		name: 'fct' ;
		statementBlock: FASTFortranStatementBlock new ;
		famix: famix ;
		parentProgramFile: fastProgramFile }.
		
]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> functionWithSegment [
	"  ---- demo.f ----
	integer fct()
	  segment foo
	  end segment
	end function fct"

	| segment_foo |

	segment_foo := self segment: 'foo' attributes: #().
	segment_foo famix: (FamixEsopeSegment new name: 'foo'; attributes: #()).

	self functionEmpty.
	fastProcedures anyOne statementBlock addStatement: segment_foo.
		
]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> programEmpty [
	"
     PROGRAM demo
     END"

	fastMainProgram := FASTFortranProgramMain new 
		name: 'demo' ; 
		statementBlock: FASTFortranStatementBlock new ; 
		parentProgramFile: fastProgramFile ;
		yourself.

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> programWithCommandSegini [
    "
+------ someFile.E ---------------------------------+
|      program main                                 |
|      segini p
|      end                                          |
+---------------------------------------------------+
"

	| segCommand |
	segCommand := FASTEsopeSegini new
   		addVariable: (FASTFortranScalarVariable new 
			name: 'p';
			famixParameter: (FamixF77Parameter new 
            name: 'p'; 
            declaredType: (FamixEsopeSegment new name: 'foo'); 
            yourself 
        ));
        yourself.

	self programEmpty.
	fastMainProgram statementBlock addStatement: segCommand.

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> programWithDeclarationStatement [
	"  ---- demo.f ----
	program demo
	character*20 str
	end"

	self programEmpty.
	fastMainProgram 	statementBlock addStatement: (self declarationStatement: #str type: #(character 20) ).

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> programWithExternalFunctionCall [
	"
	function 'fct' defined in another externalFile.f'

     PROGRAM demo
     x = fct()
     END
"

	| famixFunction fastCallStatement |
	famixFunction := FamixF77PUFunction new
		name: 'fct' ;
		programFile: (FamixF77ProgramFile new filename: 'externalFile.f') ;
		yourself.
			
	fastCallStatement := self assignementStatement: 'aVar' value: (self functionCall: 'fct' arguments: {}).

	self programEmpty.
	fastMainProgram 	statementBlock addStatement: fastCallStatement.

	fastCallStatement expression famix: (
		FamixF77Invocation new
			sender: fastMainProgram famix ;
			addCandidate: famixFunction ;
			yourself
		).

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> programWithExternalSubroutineInvocation [
	"
	subrotine 'sub' defined in another externalFile.f'

C	--------someFile.f----------------
	program demo
	call sub
	end
C  -----end someFile.f --------------"

	| famixSubroutine fastCallStatement |
	famixSubroutine := FamixF77PUSubroutine new
		name: 'sub' ;
		programFile: (FamixF77ProgramFile new filename: 'externalFile.f');
		yourself.
			
	fastCallStatement := self callStatement: 'sub' arguments: #().
	
	self programEmpty.
	fastMainProgram 	statementBlock addStatement: fastCallStatement.
	
	fastCallStatement famix: (
		FamixF77Invocation new
			sender: fastMainProgram famix ;
			addCandidate: famixSubroutine ;
			yourself
		).

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> programWithFunctionStatement [
	"
     PROGRAM demo
     fct(x)  = x + 2
     END"

	| var function |
	var := self scalarVariable: #x.
	
	function := FASTFortranFunctionStatement new
						name: 'fct';
						parameters: { var };
						expression: (self binary: '+' left: #x right: 2);
						yourself.
	
	
	function famix: (FamixF77StatementFunction new 
		name: function name;
		declaredType: (FamixF77TypeIntrinsic new name: 'real');
		yourself
	).
	
	var famixParameter: (FamixF77Parameter new 
		name: 'x'; 
		declaredType: (FamixF77TypeIntrinsic new name: 'real'); 
		yourself
	).
				
	self programEmpty.
	fastMainProgram 	statementBlock addStatement: function.

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> programWithFunctionStatementCalled [
	"
     PROGRAM demo
     fct()  = 5
     aVar = fct()
     END"

	| fastFunctionStatement fastCallStatement |
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

	self programEmpty.
	fastMainProgram statementBlock addStatement: fastFunctionStatement.
	fastMainProgram statementBlock addStatement: fastCallStatement.

	fastFunctionStatement famix parentEntity: fastMainProgram famix.

	fastCallStatement expression famix: (
		FamixF77Invocation new
			sender: fastMainProgram famix ;
			addCandidate: fastFunctionStatement famix ;
			yourself
		).

	fastProgramFile addProgramUnit: fastMainProgram

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> programWithPointeurDeclaration [
    "
+------ someFile.E ---------------------------------+
|      program main                                 |
|      pointeur f.foo
|      end                                          |
+---------------------------------------------------+
"

	| pointerDeclarator |
	pointerDeclarator := FASTEsopePointerDeclarationStatement new
        addPointerDeclarator: (FASTEsopePointerDeclarator new 
            pointedTypeName: 'foo';
            variableDeclarator: (self variableDeclarator: #f);
            yourself
        );
        famix: (FamixEsopePointer new 
            name: 'f'; 
            declaredType: (FamixEsopeSegment new name: 'foo'); 
            yourself 
        );
        yourself.

	self programEmpty.
	fastMainProgram statementBlock addStatement: pointerDeclarator.

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> programWithProcedureInvoked [
	"
	subroutine sub
	end

	program demo
	call sub()
	end"


	| subCallStatement |
	fastProcedures := (self subroutine: 'sub')
			famix: (FamixF77PUSubroutine new name: 'sub'; programFile: famixProgramFile);
			yourself.

	subCallStatement := self callStatement: 'sub' arguments: #().
	
	self programEmpty.
	fastMainProgram statementBlock addStatement: subCallStatement.

	subCallStatement  famix: (FamixF77Invocation new 
		sender: fastMainProgram famix;
		addCandidate: fastProcedures famix;
		yourself
	).

	fastProgramFile programUnit: { fastProcedures . fastMainProgram }.

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> programWithSegment [
	"  ---- demo.f ----
	program demo
	  segment foo
	  end segment
	end"

	| segment_foo |

	segment_foo := self segment: 'foo' attributes: #().
	segment_foo famix: (FamixEsopeSegment new name: 'foo'; attributes: #()).

	self programEmpty.
	fastMainProgram statementBlock addStatement: segment_foo.
		
]

{ #category : 'running' }
FASTFortranAbstractTransformationVisitorTest >> segment: aName attributes: aDeclarationStatements [

	^FASTEsopeSegment new 
		name: aName;
		statements: (aDeclarationStatements collect: [:assoc | 
			self declarationStatement: assoc key type: assoc value
		]);
		yourself
]

{ #category : 'running' }
FASTFortranAbstractTransformationVisitorTest >> setUp [ 

	super setUp.

	
	fastProgramFile := FASTFortranProgramFile new.
	famixProgramFile := FamixF77ProgramFile new filename: 'someFile.f'.

	fastProgramFile famix: famixProgramFile.
	
]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> subroutineAndFunction [
	"---- demo.f ----
	subroutine sub
	aVar = fct()
	end"

	| fastFunction fastSubroutine |

	self functionEmpty.
	fastFunction := fastProcedures anyOne.
	
	self subroutineEmpty.
	fastSubroutine := fastProcedures anyOne.

	fastProcedures := { fastFunction . fastSubroutine }
]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> subroutineAndFunctionWithCall [
	"---- demo.f ----
	subroutine sub
	aVar = fct()
	end"

	| fastCallStatement |
	self subroutineAndFunction.

	fastCallStatement := self assignementStatement: 'aVar' value: (self functionCall: 'fct' arguments: {}).

	fastProcedures second statementBlock addStatement: fastCallStatement.

	fastCallStatement expression famix: (
		FamixF77Invocation new
			sender: fastProcedures second famix ;
			addCandidate: fastProcedures first famix ;
			yourself
		).

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> subroutineEmpty [
	"---- demo.f ----
	subroutine sub
	end"

	| famix |
	famix := FamixF77PUSubroutine new
			name: 'sub' ; 
			programFile: famixProgramFile.

	fastProcedures := { FASTFortranSubroutine new 
		name: 'sub' ;
		statementBlock: FASTFortranStatementBlock new ;
		famix: famix ;
		parentProgramFile: fastProgramFile }
		
]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> subroutineWithFunctionStatement [
	"
     subroutine sub
     fct(x)  = x + 2
     END"

	| var function |
	var := self scalarVariable: #x.
	
	function := FASTFortranFunctionStatement new
						name: 'fct';
						parameters: { var };
						expression: (self binary: '+' left: #x right: 2);
						yourself.

	function famix: (FamixF77StatementFunction new 
		name: function name;
		declaredType: (FamixF77TypeIntrinsic new name: 'real');
		yourself
	).
	
	var famixParameter: (FamixF77Parameter new 
		name: 'x'; 
		declaredType: (FamixF77TypeIntrinsic new name: 'real'); 
		yourself
	).
				
	self subroutineEmpty.

	fastProcedures anyOne statementBlock addStatement: function.

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> subroutineWithFunctionStatementCalled [
	"
     PROGRAM demo
     fct()  = 5
     aVar = fct()
     END"

	| fastFunctionStatement fastCallStatement fastSubroutine |
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

	self subroutineEmpty.
	fastSubroutine := fastProcedures anyOne.
	fastSubroutine statementBlock addStatement: fastFunctionStatement.
	fastSubroutine statementBlock addStatement: fastCallStatement.

	fastFunctionStatement famix parentEntity: fastSubroutine famix.

	fastCallStatement expression famix: (
		FamixF77Invocation new
			sender: fastSubroutine famix ;
			addCandidate: fastFunctionStatement famix ;
			yourself
		).

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> subroutineWithPointeurDeclaration [
    " someFile.E

      subroutine sub
      pointeur f.foo
      end subroutine sub"

	| pointerDeclarator |
	pointerDeclarator := FASTEsopePointerDeclarationStatement new
        addPointerDeclarator: (FASTEsopePointerDeclarator new 
            pointedTypeName: 'foo';
            variableDeclarator: (self variableDeclarator: #f);
            yourself
        );
        famix: (FamixEsopePointer new 
            name: 'f'; 
            declaredType: (FamixEsopeSegment new name: 'foo'); 
            yourself 
        );
        yourself.

	self subroutineEmpty.
	fastProcedures anyOne statementBlock addStatement: pointerDeclarator.

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> subroutineWithTwoSegment [
	"  ---- demo.f ----
	integer fct()
	  segment foo
	  end segment
	end function fct"

	| segment_foo segment_bar |

	segment_foo := self segment: 'foo' attributes: #().
	segment_foo famix: (FamixEsopeSegment new name: 'foo'; attributes: #()).

	segment_bar := self segment: 'bar' attributes: #().
	segment_bar famix: (FamixEsopeSegment new name: 'bar'; attributes: #()).

	self subroutineEmpty.
	fastProcedures anyOne statementBlock: (self statementBlock: {segment_foo . segment_bar }).
		
]
