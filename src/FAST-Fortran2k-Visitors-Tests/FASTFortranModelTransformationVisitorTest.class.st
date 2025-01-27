Class {
	#name : 'FASTFortranModelTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractVisitorTest',
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

{ #category : 'tests-statement' }
FASTFortranModelTransformationVisitorTest >> testFctStatement [
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
                     |
                     v
+------ incFile.obj.E ------------------------------+
|      subroutine _$incFile_obj                     |
|      integer N                                    |
|      end                                          |
+---------------------------------------------------+

+------ mainFile.E ---------------------------------+
|      program main                                 |
|#include ""incFile.obj""                           |
|      end                                          |
+---------------------------------------------------+
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
