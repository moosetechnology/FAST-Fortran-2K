Class {
	#name : 'FASTFortranProcedureTransformationVisitorTest',
	#superclass : 'FASTEsopeAbstractTransformationVisitorTest',
	#category : 'Famix-Esope-Transformator-Tests-Visitors',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Visitors'
}

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testCreateModule [

	| module |

	module := visitor createModule: (FamixF77PUSubroutine new programFile: (FamixF77ProgramFile new filename: '/not/normalized/someName.E')).

	self assert: module class equals: FASTFortran2kModule.
	self assert: module name equals: 'someName_mod'.
	
	self assert: module programFile isNotNil.
	self assert: module programFile class equals: FASTFortran2kProgramFile.
	self assert: module programFile filename equals: '/not/normalized/someName_mod.f90'

]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testEnsureModuleOnce [

	| module famix |

	famix := (FamixF77PUSubroutine new programFile: (FamixF77ProgramFile new filename: '/not/normalized/someName.E')).
	module := visitor ensureModule: famix.

	self assert: module class equals: FASTFortran2kModule.
	self assert: module name equals: 'someName_mod'.

]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testEnsureModuleTwice [

	| module famix |

	famix := (FamixF77PUSubroutine new programFile: (FamixF77ProgramFile new filename: '/not/normalized/someName.E')).
	module := visitor ensureModule: famix.

	self assert: module class equals: FASTFortran2kModule.
	self assert: module name equals: 'someName_mod'.

	self assert: (visitor ensureModule: famix) equals: module
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
	self assert: res programUnits size equals: 1.

	res := res programUnits anyOne.
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
FASTFortranProcedureTransformationVisitorTest >> testMissedParameterDeclaration [

	| famixParamF77 res fast |
	famixParamF77 := famixEsopeModel newParameter
		declaredType: (famixEsopeModel newTypeIntrinsic name: #integer) ;
		propertyNamed: #intent put: 'intent(inOut)' ;
		yourself.
	fast := FASTFortranScalarVariable new
		name: 'param' ;
		famixParameter: famixParamF77.

	res := visitor missedParameterDeclaration: fast.

	self assert: res class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: res declarators size equals: 1.
	self assertCollection: res modifiers equals: { 'intent(inOut)' }
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
	self assert: res programUnits size equals: 1.
	
	module := res programUnits anyOne.
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
	self assert: res programUnits size equals: 1.

	module := res programUnits anyOne.
	self assert: module class equals: FASTFortran2kModule.
	self assert: module procedures size equals: 2.

	self assert: module statementBlock statements size equals: 1.
	self assert: module statementBlock statements anyOne class equals: FASTFortran2kImplicitStatement.

]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testParameterDeclaredOneMissing [

	| res famix fast2k fast2ksubrtn |
	self subroutineEmpty.
	famix := famixEsopeModel newParameter name: 'forgotten' ; declaredType: (famixEsopeModel newTypeIntrinsic name: #integer).
	fastProcedures anyOne
		addParameter: (FASTFortranScalarVariable new name: 'param' ; famixParameter: famixEsopeModel newParameter) ;
		addParameter: (FASTFortranScalarVariable new name: 'forgotten' ; famixParameter: famix).
	fastProcedures anyOne statementBlock addStatement: (self declarationStatement: 'param' type: #integer).
		
	res := fastProcedures anyOne accept: visitor.

	self assert: visitor parametersToDeclare size equals: 1.

	fast2ksubrtn := res programUnits anyOne procedures anyOne.
	self assert: fast2ksubrtn statementBlock statements size equals: 4.

	fast2k := fast2ksubrtn statementBlock statements first.
	self assert: fast2k class equals: FASTFortran2kComment.

	fast2k := fast2ksubrtn statementBlock statements second.
	self assert: fast2k modifiers anyOne equals: 'intent(in)'.
	self assert: fast2k declarators anyOne name equals: 'forgotten'.

	fast2k := fast2ksubrtn statementBlock statements third.
	self assert: fast2k class equals: FASTFortran2kEmptyStatement.

	fast2k := fast2ksubrtn statementBlock statements fourth.
	self assert: fast2k modifiers anyOne equals: 'intent(in)'.
	self assert: fast2k declarators anyOne name equals: 'param'

]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testParameterDeclaredOnePointerMissing [

	| res famix fast2k fast2ksubrtn |
	self subroutineEmpty.
	famix := famixEsopeModel newParameter name: 'forgotten' ; declaredType: (famixEsopeModel newSegment name: #seg).
	fastProcedures anyOne
		addParameter: (FASTFortranScalarVariable new name: 'param' ; famixParameter: famixEsopeModel newParameter) ;
		addParameter: (FASTFortranScalarVariable new name: 'forgotten' ; famixParameter: famix).
	fastProcedures anyOne statementBlock addStatement: (self declarationStatement: 'param' type: #integer).
		
	res := fastProcedures anyOne accept: visitor.

	self assert: visitor parametersToDeclare size equals: 1.

	fast2ksubrtn := res programUnits anyOne procedures anyOne.
	self assert: fast2ksubrtn statementBlock statements size equals: 4.

	fast2k := fast2ksubrtn statementBlock statements first.
	self assert: fast2k class equals: FASTFortran2kComment.

	fast2k := fast2ksubrtn statementBlock statements second.
	self assert: fast2k modifiers anyOne equals: 'intent(in)'.
	self assert: fast2k declarators anyOne name equals: 'forgotten'.

	fast2k := fast2ksubrtn statementBlock statements third.
	self assert: fast2k class equals: FASTFortran2kEmptyStatement.

	fast2k := fast2ksubrtn statementBlock statements fourth.
	self assert: fast2k modifiers anyOne equals: 'intent(in)'.
	self assert: fast2k declarators anyOne name equals: 'param'

]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testParametersDeclaredNonMissing [

	| res famix fast2k |
	self subroutineEmpty.
	famix := FamixF77Parameter new.
	fastProcedures anyOne
		addParameter: (FASTFortranScalarVariable new name: 'param' ; famixParameter: famix).
	fastProcedures anyOne statementBlock addStatement: (self declarationStatement: 'param' type: #integer).
		
	res := fastProcedures anyOne accept: visitor.

	self assert: visitor parametersToDeclare isEmpty.

	fast2k := res programUnits anyOne procedures anyOne.
	self assert: fast2k statementBlock statements size equals: 1.

	fast2k := fast2k statementBlock statements first.
	self assert: fast2k modifiers anyOne equals: 'intent(in)'.
	self assert: fast2k declarators anyOne name equals: 'param'.

]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testParametersIntentFromAllRead [

	| famixParamF77 procedure2k |
	famixParamF77 := FamixF77Parameter new.
	FamixF77Access new variable: famixParamF77.
	FamixF77Access new variable: famixParamF77 ; isWrite: false.

	procedure2k := FASTFortran2kSubroutine new parameters: { 
		FASTFortran2kScalarVariable new name: 'param'
	}.

	visitor
		parametersIntent: procedure2k
		from: {
			FASTFortranScalarVariable new name: 'param' ; famixParameter: famixParamF77
		}.

	self assert: (famixParamF77 propertyNamed: #intent) equals: 'intent(in)'
]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testParametersIntentFromAllWrite [

	| famixParamF77 procedure2k |
	famixParamF77 := FamixF77Parameter new.
	FamixF77Access new variable: famixParamF77 ; isWrite: true.
	FamixF77Access new variable: famixParamF77 ; isWrite: true.

	procedure2k := FASTFortran2kSubroutine new parameters: { 
		FASTFortran2kScalarVariable new name: 'param'
	}.

	visitor
		parametersIntent: procedure2k
		from: {
			FASTFortranScalarVariable new name: 'param' ; famixParameter: famixParamF77
		}.

	self assert: (famixParamF77 propertyNamed: #intent) equals: 'intent(out)'
]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testParametersIntentFromNoAccesses [

	| famixParamF77 procedure2k |
	famixParamF77 := FamixF77Parameter new.

	procedure2k := FASTFortran2kSubroutine new parameters: { 
		FASTFortran2kScalarVariable new name: 'param'
	}.

	visitor
		parametersIntent: procedure2k
		from: {
			FASTFortranScalarVariable new name: 'param' ; famixParameter: famixParamF77
		}.

	self assert: (famixParamF77 propertyNamed: #intent) equals: 'intent(in)'
]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testParametersIntentFromReadAndWrite [

	| famixParamF77 procedure2k |
	famixParamF77 := FamixF77Parameter new.
	FamixF77Access new variable: famixParamF77 ; isWrite: false.
	FamixF77Access new variable: famixParamF77 ; isWrite: true.

	procedure2k := FASTFortran2kSubroutine new parameters: { 
		FASTFortran2kScalarVariable new name: 'param'
	}.

	visitor
		parametersIntent: procedure2k
		from: {
			FASTFortranScalarVariable new
				name: 'param' ;
				famixParameter: famixParamF77
		}.

	self assert: (famixParamF77 propertyNamed: #intent) equals: 'intent(inOut)'
]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testParametersPointerDeclaredNonMissing [

	| res famixParamF77 fast2k |
	self functionEmpty.
	famixParamF77 := famixEsopeModel newParameter
		name: 'param' ; 
		declaredType: (famixEsopeModel newSegment name: #seg) ;
		propertyNamed: #intent put: 'intent(in)' ;
		yourself.
	fastProcedures anyOne
		addParameter: (FASTFortranScalarVariable new 
			name: 'param' ; 
			famixParameter: famixParamF77).
	fastProcedures anyOne statementBlock
		addStatement: (FASTEsopePointerDeclarationStatement new
			addPointerDeclarator: (
				FASTEsopePointerDeclarator new
					pointedTypeName: 'seg' ;
					variableDeclarator: (FASTFortranVariableDeclarator new
						name: 'param' ;
						famixDeclaration: famixParamF77)
			) ;
			yourself
		).
		
	res := fastProcedures anyOne accept: visitor.

	self assert: visitor parametersToDeclare isEmpty.

	fast2k := res programUnits anyOne procedures anyOne.
	self assert: fast2k statementBlock statements size equals: 1.

	fast2k := fast2k statementBlock statements first.
	self assert: fast2k declarators anyOne name equals: 'param'.
	self assertCollection: fast2k modifiers hasSameElements: #(pointer 'intent(in)')

]

{ #category : 'tests' }
FASTFortranProcedureTransformationVisitorTest >> testProcedureWithCommandSegadj [
    "subroutine sub
    call segadj(aPtr,...) #FIXME: others arguments ? 
    end subroutine sub"

    | res stmt |

	 self procedureWithCommandSegadj.

    res := fastProcedures anyOne accept: visitor.
    
    self assert: res programUnits size equals: 1.

    res := res programUnits anyOne.
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

{ #category : 'tests' }
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
	self assert: res programUnits size equals: 1.

	res := res programUnits anyOne.

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

{ #category : 'tests' }
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
	self assert: res programUnits size equals: 1.

	res := res programUnits anyOne.

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
    
    self assert: res programUnits size equals: 1.

    res := res programUnits anyOne.
    self assert: res class equals: FASTFortran2kModule.
	 self assert: res procedures size equals: 1.
	 self assert: res procedures anyOne class equals: FASTFortran2kSubroutine.
	
	 stmt := 	res procedures anyOne statementBlock.

	 self assert: stmt statements size equals: 1.
	 self assert: stmt statements anyOne class equals: FASTFortran2kVariableDeclarationStatement.
	 self assert: stmt statements anyOne declaredType class equals: FASTFortran2kUserDefinedType.
	 self assert: stmt statements anyOne declaredType name equals: 'foo'.	
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
	self assert: res programUnits size equals: 1.

	res := res programUnits anyOne.
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
	self assert: res programUnits size equals: 1.

	res := res programUnits anyOne.
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
