Class {
	#name : 'FASTFortranMainTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractTransformationVisitorTest',
	#category : 'Famix-Esope-Transformator-Tests-Visitors',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Visitors'
}

{ #category : 'tests' }
FASTFortranMainTransformationVisitorTest >> testMainProgramWithSegment [
"

---- demo.f90
	program demo
	end

--- segment_foo_mod.f90
module segment_foo_mod
	...
	type :: segment_foo
		...
	end type segment_foo
	...
end module segment_foo_mod
"
	| res entity |
	self programWithSegment.

	res := fastMainProgram accept: visitor.

	self assert: res class equals: FASTFortran2kProgramFile.
	self assert: res filename equals: 'someFile.f90'.
	self assert: res programUnits size equals: 1.

	entity := res programUnits anyOne.
	self assert: entity class equals: FASTFortran2kProgramMain.
	self assert: entity name equals: 'demo'.
	self assert: entity statementBlock statements size equals: 1.    "IMPLICIT NONE statement"

]

{ #category : 'tests' }
FASTFortranMainTransformationVisitorTest >> testProgramEmpty [
	| res entity |

	self programEmpty.

	res := fastMainProgram accept: visitor.

	self assert: res class equals: FASTFortran2kProgramFile.
	self assert: res programUnits size equals: 1.

	res := res programUnits anyOne.

	self assert: res class equals: FASTFortran2kProgramMain.
	self assert: res name equals: 'demo'.
	self assert: res statementBlock statements size equals: 1.
	
	entity := res statementBlock statements first.
	self assert: entity class equals: FASTFortran2kImplicitStatement.
	
]

{ #category : 'tests' }
FASTFortranMainTransformationVisitorTest >> testProgramMainWithFunctionStatement [
	"
program demo
	implicit none
contains
    real function fct(x)
	 real, intent(in) :: x
    fct = x + 2
    end function fct
end program demo
		
	"
	| res entity |
	
	self programWithFunctionStatement.

	res := fastMainProgram accept: visitor.

	self assert: res class equals: FASTFortran2kProgramFile.
	self assert: res programUnits size equals: 1.

	res := res programUnits anyOne.

	self assert: res class equals: FASTFortran2kProgramMain.
	self assert: res name equals: 'demo'.
	self assert: res internalProcedures size equals: 1.
	
	entity := res internalProcedures first.
	self assert: entity class equals: FASTFortran2kInternalFunction.
	self assert: entity name equals: 'fct'.
	self assert: entity declaredType class equals: FASTFortran2kRealType.
	self assert: entity statementBlock statements size equals: 2.
	self assert: entity parameters size equals: 1.
	
	entity := entity parameters first.
	self assert: entity class equals: FASTFortran2kScalarVariable.
	self assert: entity name equals: 'x'.

]

{ #category : 'tests' }
FASTFortranMainTransformationVisitorTest >> testProgramMainWithFunctionStatementCalled [
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
	| res  entity |
	self programWithFunctionStatementCalled.

	res := fastMainProgram accept: visitor.

	self assert: res class equals: FASTFortran2kProgramFile.
	self assert: res programUnits size equals: 1.

	res := res programUnits anyOne.
	
	self assert: res class equals: FASTFortran2kProgramMain.
	self assert: res name equals: 'demo'.
	self assert: res statementBlock statements size equals: 2.
	self assert: res statementBlock statements first class equals: FASTFortran2kImplicitStatement.
	self assert: res statementBlock statements second class equals: FASTFortran2kAssignmentStatement.

	self assert: res internalProcedures size equals: 1.
	
	entity := res internalProcedures first.
	self assert: entity class equals: FASTFortran2kInternalFunction.
	self assert: entity name equals: 'fct'.
	self assert: entity declaredType class equals: FASTFortran2kRealType.
	self assert: entity statementBlock statements size equals: 1.
	self assert: entity parameters size equals: 0.
	
]

{ #category : 'tests' }
FASTFortranMainTransformationVisitorTest >> testProgramWithAssignementStatement [
	| res entity |

	self programEmpty.
	fastMainProgram statementBlock
		addStatement: (self assignementStatement: 'x' value: 5).
		
	res := fastMainProgram accept: visitor.
	
	res := res programUnits anyOne.
	self assert: res class equals: FASTFortran2kProgramMain.
	self assert: res statementBlock statements size equals: 2.
	
	entity := res statementBlock statements first.
	self assert: entity class equals: FASTFortran2kImplicitStatement.
	
	entity := res statementBlock statements second.
	self assert: entity class equals: FASTFortran2kAssignmentStatement.

	
]

{ #category : 'tests' }
FASTFortranMainTransformationVisitorTest >> testProgramWithCommandSegini [
    "program demo
    implicit none
    call segini(aPtr,...) #FIXME: others arguments ? 
    end program demo"

    | res stmt |

	self programWithCommandSegini.

    res := fastMainProgram accept: visitor.
    
    self assert: res programUnits size equals: 1.

    res := res programUnits anyOne.

    self assert: res class equals: FASTFortran2kProgramMain.
    self assert: res name equals: 'demo'.
    self assert: res statementBlock statements size equals: 2.
    
    stmt := res statementBlock statements first.
    self assert: stmt class equals: FASTFortran2kImplicitStatement.

    stmt := res statementBlock statements second.
    self assert: stmt class equals: FASTFortran2kCallStatement.
	 self assert: stmt name equals: 'segini'.	
	 self assert: stmt arguments size equals: 1.
	 self assert: stmt arguments anyOne class equals: FASTFortran2kScalarVariable.
	 self assert: stmt arguments anyOne name equals: 'aPtr'.

]

{ #category : 'tests' }
FASTFortranMainTransformationVisitorTest >> testProgramWithDeclarationStatement [
	| res entity |
	self programWithDeclarationStatement.

	res := fastMainProgram accept: visitor.

	res := res programUnits anyOne.
	self assert: res class equals: FASTFortran2kProgramMain.
	self assert: res statementBlock statements size equals: 2.
	
	entity := res statementBlock statements first.
	self assert: entity class equals: FASTFortran2kImplicitStatement.
	
	entity := res statementBlock statements second.
	self assert: entity class equals: FASTFortran2kVariableDeclarationStatement.

	
]

{ #category : 'tests' }
FASTFortranMainTransformationVisitorTest >> testProgramWithExternalFunctionCall [
	"program demo
	implicit none
	aVar = fct()
end program demo
		
	"
	| res stmt |
	self programWithExternalFunctionCall.

	res := fastMainProgram accept: visitor.
	
	self assert: res programUnits size equals: 1.
	res := res programUnits anyOne.
	self assert: res class equals: FASTFortran2kProgramMain.

	self assert: res statementBlock statements size equals: 2.

	stmt := res statementBlock statements first.
	self assert: stmt class equals: FASTFortran2kImplicitStatement.
	
	stmt := res statementBlock statements second.
	self assert: stmt class equals: FASTFortran2kAssignmentStatement.

]

{ #category : 'tests' }
FASTFortranMainTransformationVisitorTest >> testProgramWithExternalSubroutineInvocation [
	"
C	--------someFile.f90----------------
program demo
	implicit none
	call sub()
end program demo
C	--------end someFile.f90----------------
	"

	| res  stmt |
	self programWithExternalSubroutineInvocation.

	res := fastMainProgram accept: visitor.

	self assert: res programUnits size equals: 1.
	res := res programUnits anyOne.
	self assert: res class equals: FASTFortran2kProgramMain.
	self assert: res statementBlock statements size equals: 2.
	
	stmt := res statementBlock statements first.
	self assert: stmt class equals: FASTFortran2kImplicitStatement.
	
	stmt := res statementBlock statements second.
	self assert: stmt class equals: FASTFortran2kCallStatement.

]

{ #category : 'tests' }
FASTFortranMainTransformationVisitorTest >> testProgramWithImplicitStatement [
	| res entity |

	self programEmpty.

	fastMainProgram statementBlock addStatement: (FASTFortranImplicitStatement new typingRules: #() ).

	res := fastMainProgram accept: visitor.
	
	res := res programUnits anyOne.
	self assert: res class equals: FASTFortran2kProgramMain.
	self assert: res statementBlock statements size equals: 1.
	
	entity := res statementBlock statements first.
	self assert: entity class equals: FASTFortran2kImplicitStatement.
	
]

{ #category : 'tests' }
FASTFortranMainTransformationVisitorTest >> testProgramWithPointeurDeclaration [
    "program demo
    implicit none
    type(point) :: f
    end program demo"

    | res stmt |

	self programWithPointeurDeclaration.

    res := fastMainProgram accept: visitor.
    
    self assert: res programUnits size equals: 1.

    res := res programUnits anyOne.

    self assert: res class equals: FASTFortran2kProgramMain.
    self assert: res name equals: 'demo'.
    self assert: res statementBlock statements size equals: 2.
    
    stmt := res statementBlock statements first.
    self assert: stmt class equals: FASTFortran2kImplicitStatement.

    stmt := res statementBlock statements second.
    self assert: stmt class equals: FASTFortran2kVariableDeclarationStatement.
	 self assert: stmt declaredType class equals: FASTFortran2kUserDefinedType.
	 self assert: stmt declaredType name equals: 'foo'.	
	 self assert: stmt declarators size equals: 1.
	 self assert: stmt declarators anyOne class equals: FASTFortran2kVariableDeclarator.
	 self assert: stmt declarators anyOne name equals: 'f'.

]

{ #category : 'tests' }
FASTFortranMainTransformationVisitorTest >> testProgramWithProcedure [
	"
program demo
	implicit none
	call sub()
end program demo

"

	| res stmt entity |
	self programWithProcedureInvoked.

	res := fastMainProgram accept: visitor.
	
	self assert: res class equals: FASTFortran2kProgramFile.
	self assert: res programUnits size equals: 1.
	
	entity := res programUnits anyOne.

	self assert: entity class equals: FASTFortran2kProgramMain.
	self assert: entity name equals: 'demo'.
	self assert: entity statementBlock statements size equals: 2.
	
	stmt := entity statementBlock statements first.
	self assert: stmt class equals: FASTFortran2kImplicitStatement.
	
	stmt := entity statementBlock statements second.
	self assert: stmt class equals: FASTFortran2kCallStatement.
	
]

{ #category : 'running' }
FASTFortranMainTransformationVisitorTest >> visitorClass [ 

	^FASTFortranMainTransformationVisitor
]
