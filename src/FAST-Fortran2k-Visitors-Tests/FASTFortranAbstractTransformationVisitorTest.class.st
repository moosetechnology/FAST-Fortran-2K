Class {
	#name : 'FASTFortranAbstractTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractVisitorTest',
	#instVars : [
		'fastProgramFile',
		'famixProgramFile',
		'procedure',
		'mainProgram'
	],
	#category : 'FAST-Fortran2k-Visitors-Tests',
	#package : 'FAST-Fortran2k-Visitors-Tests'
}

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> programEmpty [
	"
     PROGRAM demo
     END"

	mainProgram := FASTFortranProgramMain new 
		name: 'demo' ; 
		statementBlock: FASTFortranStatementBlock new ; 
		parentProgramFile: fastProgramFile ;
		yourself.

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> programWithDeclarationStatement [
	"  ---- demo.f ----
	program demo
	character*20 str
	end"

	self programEmpty.
	mainProgram 	statementBlock addStatement: (self declarationStatement: #str type: #(character 20) ).

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
	mainProgram 	statementBlock addStatement: fastCallStatement.

	fastCallStatement expression famix: (
		FamixF77Invocation new
			sender: mainProgram famix ;
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
	mainProgram 	statementBlock addStatement: fastCallStatement.
	
	fastCallStatement famix: (
		FamixF77Invocation new
			sender: mainProgram famix ;
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
	mainProgram 	statementBlock addStatement: function.

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
	mainProgram statementBlock addStatement: fastFunctionStatement.
	mainProgram statementBlock addStatement: fastCallStatement.

	fastFunctionStatement famix parentEntity: mainProgram famix.

	fastCallStatement expression famix: (
		FamixF77Invocation new
			sender: mainProgram famix ;
			addCandidate: fastFunctionStatement famix ;
			yourself
		).

	fastProgramFile addProgramUnit: mainProgram

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
	mainProgram statementBlock addStatement: pointerDeclarator.

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
	procedure := (self subroutine: 'sub')
			famix: (FamixF77PUSubroutine new name: 'sub'; programFile: famixProgramFile);
			yourself.

	subCallStatement := self callStatement: 'sub' arguments: #().
	
	self programEmpty.
	mainProgram statementBlock addStatement: subCallStatement.

	subCallStatement  famix: (FamixF77Invocation new 
		sender: mainProgram famix;
		addCandidate: procedure famix;
		yourself
	).

	fastProgramFile programUnit: { procedure . mainProgram }.

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
	mainProgram statementBlock addStatement: segment_foo.
		
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
