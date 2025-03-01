Class {
	#name : 'FASTFortranAbstractTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractVisitorTest',
	#instVars : [
		'fastProgramFile',
		'famixProgramFile',
		'fastMainProgram',
		'fastProcedures'
	],
	#category : 'Famix-Esope-Transformator-Tests',
	#package : 'Famix-Esope-Transformator-Tests'
}

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> esopeCommandClass: esopeCommandClass pointers: associations [
	| variables |
	
	variables := associations collect: [ :assoc | 
		FASTFortranScalarVariable new 
			name: assoc key;
			famixParameter: (FamixF77Parameter new 
            name: assoc key; 
            declaredType: (FamixEsopeSegment new name: assoc value); 
            yourself 
        )	
	].

	^esopeCommandClass new
   		variables: variables;
        yourself.

]

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
		programFile: fastProgramFile }.
		
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

{ #category : 'running' }
FASTFortranAbstractTransformationVisitorTest >> newVisitor [

	| transformator |
	transformator := FamixEsopeToFortran2k new.

	^ self visitorClass new 
		parentTransformator: transformator ;
		model2k: FASTFortran2kModel new ;
		yourself
]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> pointerDeclaration [

	| fastPointer |
	fastPointer := (self variableDeclarator: #f)
		famixDeclaration: (FamixEsopePointer new 
            name: 'f'; 
            declaredType: (FamixEsopeSegment new name: 'foo'); 
            yourself).

	^FASTEsopePointerDeclarationStatement new
        addPointerDeclarator: (FASTEsopePointerDeclarator new 
            pointedTypeName: 'foo' ;
            variableDeclarator: fastPointer ;
            yourself
        ) ;
        yourself.

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> procedureWithCommandSegadj [
	"
	subroutine sub
	segadj aPtr
	end
	"
	| esopeCommand |
	esopeCommand := self esopeCommandClass: FASTEsopeSegadj pointers: { #aPtr -> #aSegment }.
	
	self subroutineEmpty.
	fastProcedures anyOne statementBlock addStatement: esopeCommand.
]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> programEmpty [
	"
     PROGRAM demo
     END"

	fastMainProgram := FASTFortranProgramMain new 
		name: 'demo' ; 
		statementBlock: FASTFortranStatementBlock new ; 
		programFile: fastProgramFile ;
		famix: (FamixF77PUMain new
			name: 'demo' ;
			programFile: famixProgramFile) ;
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

	| esopeCommand |
	esopeCommand := self esopeCommandClass: FASTEsopeSegini pointers: { #aPtr -> #aSegment }.

	self programEmpty.
	fastMainProgram statementBlock addStatement: esopeCommand.

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> programWithDeclarationStatement [
	"  ---- demo.f ----
	program demo
	character*20 str
	end"

	self programEmpty.
	fastMainProgram statementBlock addStatement: (self declarationStatement: #str type: #(character 20) ).

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
	fastMainProgram statementBlock addStatement: fastCallStatement.

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
	fastMainProgram statementBlock addStatement: function.

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

	pointerDeclarator := self pointerDeclaration.

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

	fastProgramFile programUnits: { fastProcedures . fastMainProgram }.

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

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> segact: aCollection [
	
	^self segmentCommand: FASTEsopeSegact with: aCollection
]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> segdes: aCollection [
	
	^self segmentCommand: FASTEsopeSegdes with: aCollection
]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> segini: aCollection [
	
	^self segmentCommand: FASTEsopeSegini with: aCollection
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

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> segmentCommand: aCommandClass with: aCollection [
	
	| segmentCommand  |
	aCollection ifEmpty: [ ^nil ].

	segmentCommand := aCommandClass new.
	aCollection do: [ :varName | | var |
		var := self scalarVariable: varName.
		var famixVariable: (FamixF77Variable new name: varName).
		var segCommand: segmentCommand.
		segmentCommand addVariable: var.
	].

	^segmentCommand
]

{ #category : 'running' }
FASTFortranAbstractTransformationVisitorTest >> setUp [ 

	super setUp.

	
	fastProgramFile := FASTFortranProgramFile new.
	famixProgramFile := FamixF77ProgramFile new filename: 'someFile.f'.

	fastProgramFile famix: famixProgramFile.

	
]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> statementFunctionWithExternalFunctionCall [
	"
     PROGRAM demo
     fct()  = toto()
     END"

	| fastStmtFunction famixStmtFunction famixExternalFunction fastCallExpression |

	famixExternalFunction := FamixF77PUFunction new
		name: 'toto' ;
		declaredType: (FamixF77TypeIntrinsic new name: 'real') ;
		programFile: (FamixF77ProgramFile new filename: 'externalFile.f') ;
		yourself.

	famixStmtFunction := FamixF77StatementFunction new 
		name: 'fct';
		declaredType: (FamixF77TypeIntrinsic new name: 'real') ;
		parentEntity: (FamixF77PUMain new
			name: 'demo' ;
			programFile: famixProgramFile ) ;
		yourself.
	
	fastCallExpression := (self functionCall: 'toto' arguments: #())
		famix: (FamixF77Invocation new
			sender: famixStmtFunction ;
			candidates: { famixExternalFunction } ).

	fastStmtFunction := FASTFortranFunctionStatement new
						name: 'fct';
						parameters: #();
						expression: fastCallExpression ;
						famix: famixStmtFunction ;
						yourself.

	self programEmpty.
	fastMainProgram statementBlock addStatement: fastStmtFunction.

]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> subroutineAndFunction [
	"---- demo.f ----
	function fct()
	end function

	subroutine sub
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
	function fct()
	end function

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
		programFile: fastProgramFile }
		
]

{ #category : 'setup' }
FASTFortranAbstractTransformationVisitorTest >> subroutineWithExternalSubroutineInvocation [
	"
	subrotine 'sub2' defined in another externalFile.f'

C	--------someFile.f----------------
	subroutine sub
	call sub2
	end
C  -----end someFile.f --------------"

	| famixSubrtnCalled fastCallStatement |
	famixSubrtnCalled := FamixF77PUSubroutine new
		name: 'sub2' ;
		programFile: (FamixF77ProgramFile new filename: 'externalFile.f');
		yourself.
	
	self subroutineEmpty.
		
	fastCallStatement := (self callStatement: 'sub2' arguments: #())
		famix: (
			FamixF77Invocation new
				sender: fastProcedures anyOne famix ;
				addCandidate: famixSubrtnCalled ;
				yourself
			).

	fastProcedures anyOne statementBlock addStatement: fastCallStatement.
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

	pointerDeclarator := self pointerDeclaration.

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

{ #category : 'running' }
FASTFortranAbstractTransformationVisitorTest >> visitorClass [ 

	self subclassResponsibility 
]
