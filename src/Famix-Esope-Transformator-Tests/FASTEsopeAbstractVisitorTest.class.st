Class {
	#name : 'FASTEsopeAbstractVisitorTest',
	#superclass : 'FASTFortranAbstractVisitorTest',
	#instVars : [
		'fastProgramFile',
		'famixProgramFile',
		'fastMainProgram',
		'fastProcedures',
		'famixEsopeModel'
	],
	#category : 'Famix-Esope-Transformator-Tests-Visitors',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Visitors'
}

{ #category : 'entity-creation' }
FASTEsopeAbstractVisitorTest >> esopeCommandClass: esopeCommandClass pointers: associations [
	| variables |
	
	variables := associations collect: [ :assoc | 
		FASTFortranScalarVariable new 
			name: assoc key;
			famixParameter: (famixEsopeModel newParameter 
            name: assoc key; 
            declaredType: (famixEsopeModel newSegment name: assoc value); 
            yourself 
        )	
	].

	^esopeCommandClass new
   		variables: variables;
        yourself.

]

{ #category : 'entity-creation' }
FASTEsopeAbstractVisitorTest >> functionEmpty [
	"---- demo.f ----
	integer function fct()
	end function fct"

	| famix |
	famix := famixEsopeModel newPUFunction
			name: 'fct' ; 
			declaredType: (famixEsopeModel newTypeIntrinsic name: 'integer') ;
			programFile: famixProgramFile.

	fastProcedures := { FASTFortranFunction new 
		name: 'fct' ;
		statementBlock: FASTFortranStatementBlock new ;
		famix: famix ;
		programFile: fastProgramFile }.
		
]

{ #category : 'running' }
FASTEsopeAbstractVisitorTest >> newVisitor [

	^self visitorClass new
]

{ #category : 'entity-creation' }
FASTEsopeAbstractVisitorTest >> pointerDeclaration [

	| fastPointer |
	fastPointer := (self variableDeclarator: #f)
		famixDeclaration: (famixEsopeModel newPointer 
            name: 'f'; 
            declaredType: (famixEsopeModel newSegment name: 'foo'); 
            yourself).

	^FASTEsopePointerDeclarationStatement new
        addPointerDeclarator: (FASTEsopePointerDeclarator new 
            pointedTypeName: 'foo' ;
            variableDeclarator: fastPointer ;
            yourself
        ) ;
        yourself.

]

{ #category : 'entity-creation' }
FASTEsopeAbstractVisitorTest >> programEmpty [
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

{ #category : 'running' }
FASTEsopeAbstractVisitorTest >> segment: aName attributes: aDeclarationStatements [

	^FASTEsopeSegment new 
		name: aName;
		statements: (aDeclarationStatements collect: [:assoc | 
			self declarationStatement: assoc key type: assoc value
		]);
		yourself
]

{ #category : 'entity-creation' }
FASTEsopeAbstractVisitorTest >> segmentCommand: aCommandClass with: aCollection [
	
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
FASTEsopeAbstractVisitorTest >> setUp [
	super setUp.

	visitor := self newVisitor.

	famixEsopeModel := FamixEsopeModel new.
]

{ #category : 'entity-creation' }
FASTEsopeAbstractVisitorTest >> statementFunctionWithExternalFunctionCall [
	"
     PROGRAM demo
     fct()  = toto()
     END"

	| fastStmtFunction famixStmtFunction famixExternalFunction fastCallExpression |

	famixExternalFunction := famixEsopeModel newPUFunction
		name: 'toto' ;
		declaredType: (famixEsopeModel newTypeIntrinsic name: 'real') ;
		programFile: (famixEsopeModel newProgramFile filename: 'externalFile.f') ;
		yourself.

	famixStmtFunction := famixEsopeModel newStatementFunction 
		name: 'fct';
		declaredType: (famixEsopeModel newTypeIntrinsic name: 'real') ;
		parentEntity: (famixEsopeModel newPUMain
			name: 'demo' ;
			programFile: famixProgramFile ) ;
		yourself.
	
	fastCallExpression := (self functionCall: 'toto' arguments: #())
		famix: (famixEsopeModel newInvocation
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

{ #category : 'entity-creation' }
FASTEsopeAbstractVisitorTest >> subroutineEmpty [
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

{ #category : 'running' }
FASTEsopeAbstractVisitorTest >> visitorClass [ 

	self subclassResponsibility 
]
