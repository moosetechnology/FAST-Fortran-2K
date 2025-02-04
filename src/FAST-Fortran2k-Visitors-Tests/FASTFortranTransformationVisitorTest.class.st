Class {
	#name : 'FASTFortranTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractTransformationVisitorTest',
	#category : 'FAST-Fortran2k-Visitors-Tests',
	#package : 'FAST-Fortran2k-Visitors-Tests'
}

{ #category : 'running' }
FASTFortranTransformationVisitorTest >> newVisitor [

	^FASTFortranTransformationVisitor new
]

{ #category : 'running' }
FASTFortranTransformationVisitorTest >> testArrayDeclaration [
	| stmt dst |
	stmt := self arrayDeclaration: 'v' dimensions: #( #('1' '10') ).
	
	dst := stmt accept: visitor.

	self
		assert: dst class
		equals: FASTFortran2kVariableDeclarationStatement.
]

{ #category : 'running' }
FASTFortranTransformationVisitorTest >> testAssignementStatementLiteralValue [
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
FASTFortranTransformationVisitorTest >> testComment [
	| cmt dst |
	cmt := self comment: 'This is a comment'.
	
	dst := cmt accept: visitor.
	
	self assert: dst class equals: FASTFortran2kComment.
	self assert: dst content equals: 'This is a comment'.
]

{ #category : 'running' }
FASTFortranTransformationVisitorTest >> testDoStatement [
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
FASTFortranTransformationVisitorTest >> testEsopeSegmentToDerivedTypeInModule [
	"
	segment foo
	integer bar
	end segment
	"

	| stmt res f2ksegment |
	
	stmt := self segment: 'foo' attributes: { #bar -> #integer }.
	
	res := stmt accept: FASTFortranSegmentTransformationVisitor new.

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
FASTFortranTransformationVisitorTest >> testEsopeSegmentWithArrayFieldToDerivedTypeInModule [
	"
	segment foo
	integer bar(N)
	end segment
	"

	| stmt res f2ksegment |
	
	stmt := self segment: 'foo' attributes: { #bar -> #integer }.
	stmt statements anyOne declarators anyOne
		dimensions: { FASTFortranArrayRange new upperBound: (self scalarVariable: #N) }.
	
	res := stmt accept: FASTFortranSegmentTransformationVisitor new.

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
FASTFortranTransformationVisitorTest >> testEsopeTwoSegmentsInTwoModules [

		"
--- someFile.seg ----
   subroutine _$fakesubroutine
	segment foo
	end segment

	segment bar
	end segment
	end


---- foo_mod.f90 -----
module foo_mod
	...
   type :: foo
   		...
   end type foo
	...
end module foo_mod


---- bar_mod.f90 -----
module bar_mod
	...
   type :: bar
   		...
   end type bar
	...
end module bar_mod
	"

	| stmt res f2ksegment segment_foo segment_bar fastFakesubroutine |

	segment_foo := self segment: 'foo' attributes: #().
	segment_bar := self segment: 'bar' attributes: #().

	fastFakesubroutine := self subroutine: '_$fakesubroutine'.
	fastFakesubroutine statementBlock: (self statementBlock: {segment_foo . segment_bar }).
	
	fastProgramFile addProgramUnit: fastFakesubroutine.

	res := fastProgramFile accept: visitor.

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

{ #category : 'tests-programUnit' }
FASTFortranTransformationVisitorTest >> testFunctionEmpty [
"
---- demo.f ----
	integer function fct()
	end

---- demo_mod.f90
module demo_mod
	implicit none
contains
	integer function fct()
	end function fct
end module demo_mod
"
	| res |

	FASTFortranFunction new 
		name: 'fct' ;
		declaredType: (self integerType: nil);
		statementBlock: FASTFortranStatementBlock new ; 
		parentProgramFile: fastProgramFile.
		
	res := fastProgramFile accept: visitor.

	self assert: res size equals: 1.

	res := res anyOne.
	self assert: res class equals: FASTFortran2kProgramFile.
	self assert: res filename equals: 'demo_mod.f90'.
	self assert: res programUnit size equals: 1.

	res := res programUnit anyOne.
	self assert: res class equals: FASTFortran2kModule.
	self assert: res name equals: 'demo_mod'.
	self assert: res statementBlock statements size equals: 1.
	self assert: res statementBlock statements anyOne class equals: FASTFortran2kImplicitStatement.
	self assert: res procedures size equals: 1.
	
	res := res procedures anyOne.
	self assert: res class equals: FASTFortranFunction.
	self assert: res name equals: 'fct'.
	self assert: res statementBlock statements size equals: 1
]

{ #category : 'running' }
FASTFortranTransformationVisitorTest >> testMultipleProceduresMovedToModule [
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
FASTFortranTransformationVisitorTest >> testMultipleProceduresWithoutUse [
	"
C	--------someFile.f----------------
	subroutine sub1
	end
	subroutine sub2
	call sub1()
	end
C  -----end someFile.f --------------

C	--------someFile_mod.f90----------------
module sub_mod
	implicit none
contains
	subroutine sub1()
	end subroutine sub1
	subroutine sub2()
	call sub1()
	end subroutine sub2
end sub_mod
C	--------end someFile_mod.f90----------------

	"

	| subroutine1 subroutine2 res module fastCallStatement |
	
	subroutine1 := FASTFortranSubroutine new
		name: 'sub1' ;
		statementBlock: FASTFortranStatementBlock new ;
		famix: (FamixF77PUSubroutine new name: 'sub1') ; 
			yourself.

	fastCallStatement := self callStatement: 'sub1' arguments: #().

	subroutine2 := FASTFortranSubroutine new
		name: 'sub2' ;
		statementBlock: (self statementBlock: { fastCallStatement } ) ;
		famix: (FamixF77PUSubroutine new name: 'sub2') ; 
			yourself.

	fastCallStatement famix: (
		FamixF77Invocation new
			sender: subroutine2 famix ;
			addCandidate: subroutine1 famix ;
			yourself
		).

	fastProgramFile
	 	addProgramUnit: subroutine1 ;
	 	addProgramUnit: subroutine2.
		
	res := fastProgramFile accept: visitor.
	
	self assert: res class equals: FASTFortran2kProgramFile.
	self assert: res programUnit size equals: 1.
	
	module := res programUnit anyOne.
	self assert: module class equals: FASTFortran2kModule.
	self assert: module procedures size equals: 2.

	self assert: module statementBlock statements size equals: 1.
	self assert: module statementBlock statements anyOne class equals: FASTFortran2kImplicitStatement.

]

{ #category : 'running' }
FASTFortranTransformationVisitorTest >> testProcedureCallingProcedureOtherModule [

	self fail: #TODO
]

{ #category : 'running' }
FASTFortranTransformationVisitorTest >> testProcedureCallingProcedureSameModule [

	self fail: #TODO
]

{ #category : 'running' }
FASTFortranTransformationVisitorTest >> testProcedureInProgFileMovedToModule [
	"
C	--------someFile.f----------------
	subroutine sub
	end
C  -----end someFile.f --------------

C	--------someFile_mod.f90----------------
module someFile_mod
	implicit none
contains
	subroutine sub()
	end subroutine sub
end module someFile_mod
C	--------end someFile_mod.f90----------------

	"

	| subroutine res |
	
	subroutine := FASTFortranSubroutine new 
			name: 'sub'; 
			statementBlock: (self statementBlock: #()) ; 
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
]

{ #category : 'running' }
FASTFortranTransformationVisitorTest >> testProcedureWithFunctionStatementCalled [

	self fail: #TODO
]

{ #category : 'tests-statement' }
FASTFortranTransformationVisitorTest >> testProcedureWithPointeurDeclaration [

    "
+------ someFile.E ---------------------------------+
|      subroutine sub                               |
|      pointeur f.foo
|      end                                          |
+---------------------------------------------------+

--- someFile_mod.f90 --------
module someFile_mod
    use :: foo_mod
    implicit none
contains
	subroutine sub()
	    type(point) :: f
	end subroutine sub
end module someFile_mod
    "

    | pointerDeclarator fastSubroutine res stmt |

	self skip: #TODO.

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

    fastSubroutine := FASTFortranSubroutine new 
        name: 'sub';
        statementBlock: (self statementBlock: {pointerDeclarator});
        yourself.


    fastSubroutine famix: (FamixF77PUSubroutine new name: 'sub'; programFile: famixProgramFile).

    fastProgramFile addProgramUnit: fastSubroutine.

    res := fastProgramFile accept: visitor.
    
    self assert: res programUnit size equals: 1.
    res := res programUnit anyOne.
    self assert: res class equals: FASTFortran2kModule.
    self assert: res name equals: 'someFile_mod'.
    self assert: res statementBlock statements size equals: 2.

    self skip: #TODO. "correct the adding 'use' in the module for this test"
	 stmt := res statementBlock statements first.
    self assert: stmt class equals: FASTFortran2kUseStatement.
    self assert: stmt name equals: 'foo_mod'.
    
    stmt := res statementBlock statements second.
    self assert: stmt class equals: FASTFortran2kImplicitStatement.

	 self assert: res procedures size equals: 1.
	 self assert: res procedures anyOne class equals: FASTFortran2kSubroutine.
	
	 stmt := 	res procedures anyOne statementBlock.
	 self assert: stmt statements size equals: 1.
	 self assert: stmt statements anyOne class equals: FASTFortran2kDerivedTypeDeclaration.
	 self assert: stmt statements anyOne type class equals: FASTFortran2kUserDefinedType.
	 self assert: stmt statements anyOne type name equals: 'foo'.	
	 self assert: stmt statements anyOne declarators size equals: 1.
	 self assert: stmt statements anyOne declarators anyOne class equals: FASTFortran2kVariableDeclarator.
	 self assert: stmt statements anyOne declarators anyOne name equals: 'f'.

   
    
]

{ #category : 'tests-programUnit' }
FASTFortranTransformationVisitorTest >> testProcedureWithSegment [
"
---- demo.f ----
	subroutine sub
	segment foo
	end segment
	end

---- demo_mod.f90
module demo_mod
	implicit none
contains
	subroutine sub()
	end subroutine sub
end module demo_mod

--- segment_foo_mod.f90
module segment_foo_mod
	...
	type :: segment_foo
		...
	end type segment_foo
	...
end module segment_foo_mod
"
	| module res entity segment_foo |
	
	segment_foo := self segment: 'foo' attributes: #().
	segment_foo famix: (FamixEsopeSegment new name: 'foo'; attributes: #()).

	FASTFortranFunction new 
		name: 'fct' ;
		declaredType: (self integerType: nil);
		statementBlock: (self statementBlock: {segment_foo }) ; 
		parentProgramFile: fastProgramFile.
		
	res := fastProgramFile accept: visitor.

	self assert: res size equals: 2.

	module := res first.
	self assert: module class equals: FASTFortran2kProgramFile.
	self assert: module filename equals: 'demo_mod.f90'.
	self assert: module programUnit size equals: 1.

	entity := module programUnit anyOne.
	self assert: entity class equals: FASTFortran2kModule.
	self assert: entity name equals: 'demo_mod'.
	self assert: entity statementBlock statements size equals: 1.
	self assert: entity statementBlock statements anyOne class equals: FASTFortran2kImplicitStatement.
	self assert: entity procedures size equals: 1.
	
	entity := entity procedures anyOne.
	self assert: entity class equals: FASTFortranFunction.
	self assert: entity name equals: 'fct'.
	self assert: entity statementBlock statements size equals: 1.
	
	module := res second.
	self assert: module class equals: FASTFortran2kProgramFile.
	self assert: module filename equals: 'foo_mod.f90'.
	
]

{ #category : 'tests-programUnit' }
FASTFortranTransformationVisitorTest >> testSubroutineEmpty [
"
---- demo.f ----
	subroutine sub
	end

---- demo_mod.f90
module demo_mod
	implicit none
contains
	subroutine sub()
	end subroutine sub
end module demo_mod
"
	| res |

	FASTFortranSubroutine new 
		name: 'sub' ; 
		statementBlock: FASTFortranStatementBlock new ; 
		parentProgramFile: fastProgramFile.
		
	res := fastProgramFile accept: visitor.

	self assert: res size equals: 1.

	res := res anyOne.
	self assert: res class equals: FASTFortran2kProgramFile.
	self assert: res filename equals: 'demo_mod.f90'.
	self assert: res programUnit size equals: 1.

	res := res programUnit anyOne.
	self assert: res class equals: FASTFortran2kModule.
	self assert: res name equals: 'demo_mod'.
	self assert: res statementBlock statements size equals: 1.
	self assert: res statementBlock statements anyOne class equals: FASTFortran2kImplicitStatement.
	self assert: res procedures size equals: 1.
	
	res := res procedures anyOne.
	self assert: res class equals: FASTFortran2kSubroutine.
	self assert: res name equals: 'sub'.
	self assert: res statementBlock statements size equals: 1
]
