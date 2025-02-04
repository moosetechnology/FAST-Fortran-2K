Class {
	#name : 'FASTFortranProcedureTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractTransformationVisitorTest',
	#category : 'FAST-Fortran2k-Visitors-Tests',
	#package : 'FAST-Fortran2k-Visitors-Tests'
}

{ #category : 'running' }
FASTFortranProcedureTransformationVisitorTest >> newVisitor [

	^FASTFortranProcedureTransformationVisitor new
		parentVisitor: FASTFortranTransformationVisitor new
]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testFunctionEmpty [
	"---- demo_mod.f90
module demo_mod
	implicit none
contains
	integer function fct()
	end function fct
end module demo_mod
"
	| res |
	self functionEmpty.

	res := fastProcedures anyOne accept: visitor.

	self assert: res class equals: FASTFortran2kProgramFile.
	self assert: res filename equals: 'someFile_mod.f90'.
	self assert: res programUnit size equals: 1.

	res := res programUnit anyOne.
	self assert: res class equals: FASTFortran2kModule.
	self assert: res name equals: 'someFile_mod'.
	self assert: res statementBlock statements size equals: 1.
	self assert: res statementBlock statements anyOne class equals: FASTFortran2kImplicitStatement.
	self assert: res procedures size equals: 1.
	
	res := res procedures anyOne.
	self assert: res class equals: FASTFortran2kFunction.
	self assert: res name equals: 'fct'.
	self assert: res statementBlock statements size equals: 0
]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testMultipleProcedures [
	"--------someFile_mod.f90----------------
module someFile_mod
	implicit none
contains
	real function fct()
	end function fct
	
	subroutine sub()
	end subroutine sub
end someFile_mod	"

	| res module |

	self subroutineAndFunction.
	fastProcedures do: [ :pu | res := pu accept: visitor ].
	
	self assert: res class equals: FASTFortran2kProgramFile.
	self assert: res programUnit size equals: 1.
	
	module := res programUnit anyOne.
	self assert: module class equals: FASTFortran2kModule.
	self assert: module name equals: 'someFile_mod'.
	self assert: module procedures size equals: 2.
	
	res := module procedures first.
	self assert: res class equals: FASTFortran2kFunction.
	self assert: res name equals: 'fct'.

	res := module procedures second.
	self assert: res class equals: FASTFortran2kSubroutine.
	self assert: res name equals: 'sub'.
]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testMultipleProceduresWithCall [
	"--------someFile_mod.f90----------------
module sub_mod
	implicit none
contains
	integer function fct()
	end function fct()

	subroutine sub()
	aVar = fct()
	end subroutine sub
end sub_mod"

	| res module |
	
	self subroutineAndFunctionWithCall.
	fastProcedures do: [ :pu | res := pu accept: visitor ].
	
	self assert: res class equals: FASTFortran2kProgramFile.
	self assert: res programUnit size equals: 1.
	
	module := res programUnit anyOne.
	self assert: module class equals: FASTFortran2kModule.
	self assert: module procedures size equals: 2.

	self assert: module statementBlock statements size equals: 1.
	self assert: module statementBlock statements anyOne class equals: FASTFortran2kImplicitStatement.

]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testProcedureCallingProcedureOtherModule [

	self fail: #TODO
]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testProcedureCallingProcedureSameModule [

	self fail: #TODO
]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testProcedureInProgFileMovedToModule [
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

{ #category : 'tests-statement' }
FASTFortranProcedureTransformationVisitorTest >> testProcedureWithFunctionStatement [
	"
	module someFile_mod
		implicit none
		contains
			subroutine sub
			contains
   				real function fct(x)
	 			real, intent(in) :: x
    			fct = x + 2
    		end function fct
		end subroutine sub
	end module"

	| res entity |
	
	self subroutineWithFunctionStatement.

	res := fastProcedures anyOne accept: visitor.

	self assert: res class equals: FASTFortran2kProgramFile.
	self assert: res programUnit size equals: 1.

	res := res programUnit anyOne.

	self assert: res class equals: FASTFortran2kModule.
	self assert: res procedures size equals: 1.
	
	entity := res procedures anyOne.
	self assert: entity class equals: FASTFortran2kSubroutine.
	self assert: entity name equals: 'sub'.
	self assert: entity internalProcedures size equals: 1.

	entity := entity internalProcedures anyOne.
	self assert: entity class equals: FASTFortran2kInternalFunction.
	self assert: entity name equals: 'fct'.
]

{ #category : 'tests-statement' }
FASTFortranProcedureTransformationVisitorTest >> testProcedureWithFunctionStatementCalled [
	"module someFile_mod
		implicit none
		contains
			subroutine sub
			aVar = fct(5)
			contains
   				real function fct(x)
	 			real, intent(in) :: x
    			fct = x + 2
    		end function fct
		end subroutine sub
	end module""
		
	"
	| res  entity |
	self subroutineWithFunctionStatementCalled.

	res := fastProcedures anyOne accept: visitor.

	self assert: res class equals: FASTFortran2kProgramFile.
	self assert: res programUnit size equals: 1.

	res := res programUnit anyOne.

	self assert: res class equals: FASTFortran2kModule.
	self assert: res procedures size equals: 1.

	res := res procedures anyOne.
	
	self assert: res class equals: FASTFortran2kSubroutine.
	self assert: res name equals: 'sub'.
	self assert: res statementBlock statements size equals: 1.
	self assert: res statementBlock statements first class equals: FASTFortran2kAssignmentStatement.

	self assert: res internalProcedures size equals: 1.
	
	entity := res internalProcedures first.
	self assert: entity class equals: FASTFortran2kInternalFunction.
	self assert: entity name equals: 'fct'.
	
]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testProcedureWithPointeurDeclaration [

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

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testProcedureWithSegment [
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
