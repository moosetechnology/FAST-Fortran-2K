Class {
	#name : 'FASTFortranProcedureTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractTransformationVisitorTest',
	#category : 'FAST-Fortran2k-Visitors-Tests',
	#package : 'FAST-Fortran2k-Visitors-Tests'
}

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testCreateModule [

	| module |

	module := visitor createModule: 'someName_mod'.

	self assert: module class equals: FASTFortran2kModule.
	self assert: module name equals: 'someName_mod'.
	
	self assert: module parentProgramFile isNotNil.
	self assert: module parentProgramFile class equals: FASTFortran2kProgramFile.
	self assert: module parentProgramFile filename equals: 'someName_mod.f90'

]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testEnsureModuleOnce [

	| module |

	module := visitor ensureModule: 'someName_mod'.

	self assert: module class equals: FASTFortran2kModule.
	self assert: module name equals: 'someName_mod'.

]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testEnsureModuleTwice [

	| module |

	module := visitor ensureModule: 'someName_mod'.

	self assert: module class equals: FASTFortran2kModule.
	self assert: module name equals: 'someName_mod'.

	self assert: (visitor ensureModule: 'someName_mod') equals: module
]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testEsopeTwoSegmentsInTwoModules [

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

	self skip: '#TODO: remove this test or improving it to handle segment in programFile ? '.

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

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testFunctionEmpty [
	" demo_mod.f90

	module demo_mod
		implicit none
	contains
		integer function fct()
		end function fct
	end module demo_mod"
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
FASTFortranProcedureTransformationVisitorTest >> testProcedureWithCommandSegadj [
    "subroutine sub
    call segadj(aPtr,...) #FIXME: others arguments ? 
    end subroutine sub"

    | res stmt |

	 self procedureWithCommandSegadj.

    res := fastProcedures anyOne accept: visitor.
    
    self assert: res programUnit size equals: 1.

    res := res programUnit anyOne.
	 self assert: res class equals: FASTFortran2kModule.
	 self assert: res statementBlock statements size equals: 1.
	 self assert: res procedures size equals: 1.

	 res := res procedures anyOne.

    self assert: res class equals: FASTFortran2kSubroutine.
    self assert: res name equals: 'sub'.
    self assert: res statementBlock statements size equals: 1.

    stmt := res statementBlock statements anyOne.
    self assert: stmt class equals: FASTFortran2kCallStatement.
	 self assert: stmt name equals: 'segadj'.	
	 self assert: stmt arguments size equals: 1.
	 self assert: stmt arguments anyOne class equals: FASTFortran2kScalarVariable.
	 self assert: stmt arguments anyOne name equals: 'aPtr'.

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

    " someFile_mod.f90

	module someFile_mod
	    implicit none
	contains
		subroutine sub()
	 	   type(point) :: f
		end subroutine sub
	end module someFile_mod
    "

    | res stmt |
	self subroutineWithPointeurDeclaration.

    res := fastProcedures anyOne accept: visitor.
    
    self assert: res programUnit size equals: 1.

    res := res programUnit anyOne.
    self assert: res class equals: FASTFortran2kModule.
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
	" demo_mod.f90

	module demo_mod
		implicit none
	contains
		integer function fct()
		end function fct
	end module demo_mod"
	| res |
	self functionWithSegment.

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
FASTFortranProcedureTransformationVisitorTest >> testSubroutineEmpty [
	"
C	--------someFile_mod.f90----------------
module someFile_mod
	implicit none
contains
	subroutine sub()
	end subroutine sub
end module someFile_mod
C	--------end someFile_mod.f90----------------

	"

	| res |
			
	self subroutineEmpty.
		
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
	self assert: res class equals: FASTFortran2kSubroutine.
	self assert: res name equals: 'sub'.
	self assert: res statementBlock statements size equals: 0
]

{ #category : 'running' }
FASTFortranProcedureTransformationVisitorTest >> visitorClass [ 

	^FASTFortranProcedureTransformationVisitor
]
