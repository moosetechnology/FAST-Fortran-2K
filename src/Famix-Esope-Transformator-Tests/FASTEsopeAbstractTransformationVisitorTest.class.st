Class {
	#name : 'FASTEsopeAbstractTransformationVisitorTest',
	#superclass : 'FASTEsopeAbstractVisitorTest',
	#category : 'Famix-Esope-Transformator-Tests-Visitors',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Visitors'
}

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> functionWithSegment [
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
FASTEsopeAbstractTransformationVisitorTest >> newVisitor [

	| transformator |
	transformator := EsopeTransformationController new.

	^super newVisitor
		parentTransformator: transformator ;
		model2k: FASTFortran2kModel new ;
		yourself
]

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> procedureWithCommandSegadj [
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

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> programWithCommandSegini [
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

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> programWithDeclarationStatement [
	"  ---- demo.f ----
	program demo
	character*20 str
	end"

	self programEmpty.
	fastMainProgram statementBlock addStatement: (self declarationStatement: #str type: #(character 20) ).

]

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> programWithExternalFunctionCall [
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
			
	fastCallStatement := self
		assignementStatement: 'aVar'
		value: (self functionCall: 'fct' arguments: {}).

	self programEmpty.
	fastMainProgram statementBlock addStatement: fastCallStatement.

	fastCallStatement expression famix: (
		FamixF77Invocation new
			sender: fastMainProgram famix ;
			addCandidate: famixFunction ;
			yourself
		).

]

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> programWithExternalSubroutineInvocation [
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

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> programWithFunctionStatement [
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
	
	
	function famix: (famixEsopeModel newStatementFunction 
		name: function name;
		declaredType: (famixEsopeModel newTypeIntrinsic name: 'real');
		yourself
	).
	
	var famixParameter: (famixEsopeModel newParameter 
		name: 'x'; 
		declaredType: (famixEsopeModel newTypeIntrinsic name: 'real'); 
		yourself
	).
				
	self programEmpty.
	fastMainProgram statementBlock addStatement: function.

]

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> programWithFunctionStatementCalled [
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
	
	
	fastFunctionStatement famix: (famixEsopeModel newStatementFunction 
		name: fastFunctionStatement name;
		declaredType: (famixEsopeModel newTypeIntrinsic name: 'real');
		yourself
	).
	
	fastCallStatement := self
		assignementStatement: 'aVar'
		value: (self functionCall: 'fct' arguments: {}).

	self programEmpty.
	fastMainProgram statementBlock addStatement: fastFunctionStatement.
	fastMainProgram statementBlock addStatement: fastCallStatement.

	fastFunctionStatement famix parentEntity: fastMainProgram famix.

	fastCallStatement expression famix: (
		famixEsopeModel newInvocation
			sender: fastMainProgram famix ;
			addCandidate: fastFunctionStatement famix ;
			yourself
		).

	fastProgramFile addProgramUnit: fastMainProgram

]

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> programWithPointeurDeclaration [
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

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> programWithProcedureInvoked [
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

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> programWithSegment [
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
FASTEsopeAbstractTransformationVisitorTest >> setUp [ 

	super setUp.

	fastProgramFile := FASTFortranProgramFile new.
	famixProgramFile := FamixF77ProgramFile new filename: 'someFile.f'.

	fastProgramFile famix: famixProgramFile.

	
]

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> subroutineAndFunction [
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

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> subroutineAndFunctionWithCall [
	"---- demo.f ----
	function fct()
	end function

	subroutine sub
	aVar = fct()
	end"

	| fastCallStatement |
	self subroutineAndFunction.

	fastCallStatement := self
		assignementStatement: 'aVar'
		value: (self functionCall: 'fct' arguments: {}).

	fastProcedures second statementBlock addStatement: fastCallStatement.

	fastCallStatement expression famix: (
		FamixF77Invocation new
			sender: fastProcedures second famix ;
			addCandidate: fastProcedures first famix ;
			yourself
		).

]

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> subroutineWithExternalSubroutineInvocation [
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

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> subroutineWithFunctionStatement [
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

	function famix: (famixEsopeModel newStatementFunction 
		name: function name;
		declaredType: (famixEsopeModel newTypeIntrinsic name: 'real');
		yourself
	).
	
	var famixParameter: (famixEsopeModel newParameter 
		name: 'x'; 
		declaredType: (famixEsopeModel newTypeIntrinsic name: 'real'); 
		yourself
	).
				
	self subroutineEmpty.

	fastProcedures anyOne statementBlock addStatement: function.

]

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> subroutineWithFunctionStatementCalled [
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
	
	
	fastFunctionStatement famix: (famixEsopeModel newStatementFunction 
		name: fastFunctionStatement name;
		declaredType: (famixEsopeModel newTypeIntrinsic name: 'real');
		yourself
	).
	
	fastCallStatement := self
		assignementStatement: 'aVar'
		value: (self functionCall: 'fct' arguments: {}).


	self subroutineEmpty.
	fastSubroutine := fastProcedures anyOne.
	fastSubroutine statementBlock addStatement: fastFunctionStatement.
	fastSubroutine statementBlock addStatement: fastCallStatement.

	fastFunctionStatement famix parentEntity: fastSubroutine famix.

	fastCallStatement expression famix: (
		famixEsopeModel newInvocation
			sender: fastSubroutine famix ;
			addCandidate: fastFunctionStatement famix ;
			yourself
		).

]

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> subroutineWithPointeurDeclaration [
    " someFile.E

      subroutine sub
      pointeur f.foo
      end subroutine sub"

	| pointerDeclarator |

	pointerDeclarator := self pointerDeclaration.

	self subroutineEmpty.
	fastProcedures anyOne statementBlock addStatement: pointerDeclarator.

]

{ #category : 'entity-creation' }
FASTEsopeAbstractTransformationVisitorTest >> subroutineWithTwoSegment [
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
