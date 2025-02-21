Class {
	#name : 'FASTFortranDerivedTypeFactory',
	#superclass : 'Object',
	#instVars : [
		'name',
		'fields',
		'parameters',
		'model'
	],
	#category : 'Famix-Esope-Transformator-Segment',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Segment'
}

{ #category : 'api' }
FASTFortranDerivedTypeFactory >> createModule [

	| module |
	module := model newModule name: name , '_mod'.

	module statementBlock:
		(FASTFortran2kStatementBlock new statements: {
				 self makeSegmentModuleProlog.
				 self makeTypeDefinition .
				 self makeSegmentTypeName .

				 self makeBoxedTypeDefinition .
				 self makeInterfaces .
				 self makeContainsStatement .
				 self makeProcedureIgnore .
				 self makeProcedureAssignPointerToPointer .
				 self makeProcedureSegmentType .

				 self makeProcedureSegini .
				 self makeProcedureSegcop .
				 self makeProcedureSegmov .
				 self makeProcedureSegadj .
				 self makeProcedureSegsup .
				 self makeProcedureSegprt .
				 self makeProcedureSegstore .
				 self makeProcedureSegload .
				 self makeProcedureSegpar .
				 self makeProcedureSeglik .
				 self makeProcedureSegloc .

				 self makeProcedureBoxed  }).
	^ module
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> fields: fastFortranDeclarations [

	fields := fastFortranDeclarations flatCollect: [ :fastVariableDeclaration |
		fastVariableDeclaration declarators collect: [ :fastVariableDeclarator |
			FASTFortranDerivedTypeFieldFactory new
				derivedTypeFactory: self ;
				type: fastVariableDeclaration declaredType ;
				fieldDeclarator: fastVariableDeclarator

		]
	]
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeBoxedTypeDefinition [

	^model newFormattedCodeString
		  content: '
    public boxed_{segmentName}
    type, extends(segment) :: boxed_{segmentName}
        type({segmentName}), pointer, private :: this => null()
    contains
        procedure :: segsup => boxed_{segmentName}_segsup
        procedure :: segcop => boxed_{segmentName}_segcop
        procedure :: segmov => boxed_{segmentName}_segmov
        procedure :: segprt => boxed_{segmentName}_segprt
        procedure :: seg_store => boxed_{segmentName}_seg_store
        procedure :: seg_type => boxed_{segmentName}_seg_type
        final :: boxed_{segmentName}_finalize
    end type boxed_{segmentName} 
';
		  values: (Dictionary with: #segmentName -> name)
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeContainsStatement [

	^model newFormattedCodeString
		  content: '
contains
	 ! ## primary aspects
    ! begin: the fields dimensions from the parameters
    ! end: the fields dimensions from the parameters

';
		  values: (Dictionary with: #segmentName -> name)
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeInterfaces [

	^model newFormattedCodeString
		  content: '
	 public assignment (=)
    interface assignment (=)
        module procedure {segmentName}_assign_pointer_to_pointer
    end interface

    public seg_type
    interface seg_type
        module procedure {segmentName}_seg_type
        module procedure boxed_{segmentName}_seg_type
    end interface

    public segini
    interface segini
        module procedure {segmentName}_segini
    end interface

    public segcop
    interface segcop
        module procedure {segmentName}_segcop
        module procedure boxed_{segmentName}_segcop
    end interface

    public segmov
    interface segmov
        module procedure {segmentName}_segmov
        module procedure boxed_{segmentName}_segmov
    end interface

    public segadj
    interface segadj
        module procedure {segmentName}_segadj
    end interface

    public segsup
    interface segsup
        module procedure {segmentName}_segsup
        module procedure boxed_{segmentName}_segsup
    end interface

    public segprt
    interface segprt
        module procedure {segmentName}_segprt
        module procedure boxed_{segmentName}_segprt
    end interface

    public seg_store
    interface seg_store
        module procedure {segmentName}_seg_store
        module procedure boxed_{segmentName}_seg_store
    end interface

    public seg_load
    interface seg_load
        module procedure {segmentName}_seg_load
    end interface

    public segpar
    interface segpar
        module procedure {segmentName}_segpar
    end interface

    public seglik
    interface seglik
        module procedure {segmentName}_seglik
    end interface

    public segloc
    interface segloc
        module procedure {segmentName}_segloc
    end interface

    public ajpnt
    interface  ajpnt
        module procedure {segmentName}_ajpnt
    end interface

    public getpnt
    interface  getpnt
        module procedure {segmentName}_getpnt
    end interface

    public {segmentName}_mypnt
    public {segmentName}_load
';
		  values: (Dictionary with: #segmentName -> name)
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeProcedureAssignPointerToPointer [

	^model newFormattedCodeString
		  content: '
    subroutine {segmentName}_assign_pointer_to_pointer(this, that)
        ! >> Just to detect at compile-time "this = that" bad usage, 
        ! >> instead of "this => that" good usage
        type({segmentName}), pointer, intent(out) :: this
        type({segmentName}), pointer, intent(in) :: that
        
        if ( ignore_do_trace ) then
            call ignore_{segmentName}(this, ''this'', ''{segmentName}_assign_pointer_to_pointer'')
            call ignore_{segmentName}(that, ''that'', ''{segmentName}_assign_pointer_to_pointer'')
        end if
        
        call check_post_condition(.false. , ''{segmentName}_assign_pointer_to_pointer'', ''should not be called'')
    end subroutine {segmentName}_assign_pointer_to_pointer
';
		  values: (Dictionary with: #segmentName -> name)
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeProcedureIgnore [

	^model newFormattedCodeString
		  content: '
    subroutine ignore_{segmentName}(variable, variable_name, routine)
        use, intrinsic :: iso_fortran_env, only : int64
        use, intrinsic :: iso_c_binding, only : c_loc

        type({segmentName}), pointer, intent(in) :: variable
        character(len=*), intent(in) :: variable_name
        character(len=*), intent(in) :: routine

        integer(int64) :: variable_loc
                
        if ( ignore_do_trace ) then
            call ignore_type(''{segmentName}'', variable_name, routine)
            
            if ( ignore_get_false(0) ) then
                variable_loc = transfer(c_loc(variable), variable_loc)
                write(*,*) ''ignore: variable_loc ='', variable_loc
            end if 
        end if
    end subroutine ignore_{segmentName}
';
		  values: (Dictionary with: #segmentName -> name)
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeProcedureSegini [

	| segxxx routineParams routineParamsDeclarations localParamsDims allocateSegmentAttributes segmentDimensions aFASTFortranSegment tmpStream |
	self ensureEmptyStream.
	
	segmentDimensions := self computeSegmentsDimensions: aFASTFortranSegment.
	routineParams := self computeRoutineParams: segmentDimensions.
	routineParamsDeclarations := self computeRoutineParamsDeclarations: segmentDimensions.
	localParamsDims := self computeLocalParamsDims: segmentDimensions.

	allocateSegmentAttributes := self computeAllocateSegmentAttributes: aFASTFortranSegment.

	tmpStream << '
	subroutine {segmentName}_segini(this {routineParams})
		! ## Initialize a new "this" segment with default values
		! ## using the given parameters
		type({segmentName}, pointer, intent(inout) :: this
		{routineParamsDeclarations}
	
		{localParamsDims}
	
		allocate(this)
		{allocateSegmentAttributes}

		call check_post_condition(associated(this), ''{segmentName}_segini'', ''associated(this)'')
	end subroutine {segmentName}_segini
'.

	segxxx := self model newFormattedCodeString
		          content: tmpStream contents;
		          values: { 
						#segmentName -> aFASTFortranSegment name. 
						#routineParams -> routineParams. 
						#routineParamsDeclarations -> routineParamsDeclarations. 
						#localParamsDims -> localParamsDims. 
						#allocateSegmentAttributes -> allocateSegmentAttributes. 
					} asDictionary.
						

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeProcedureSegmentType [

	^model newFormattedCodeString
		  content: '
    subroutine {segmentName}_seg_type(this, type_name)
        ! ## Return the name of the segment type
        type({segmentName}), pointer, intent(in) :: this
        character(len=segment_type_len), intent(out) :: type_name

        type_name = {segmentName}_type_name

        if ( ignore_do_trace ) then
            call ignore_{segmentName}(this, ''this'', ''{segmentName}_seg_type'')
        end if
    end subroutine {segmentName}_seg_type
';
		  values: (Dictionary with: #segmentName -> name)
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeSegmentModuleProlog [

	^model newSourceCodeString content: '
	use ignore_m
	use contract_m
	use segment_m
	use str_m

	implicit none
	private
'
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeSegmentTypeName [

	^model newFormattedCodeString
		  content: '

    public {segmentName}_type_name
    character(len=segment_type_len), parameter :: {segmentName}_type_name = ''{segmentName}''
';
		  values: (Dictionary with: #segmentName -> name)
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeTypeDefinition [

	| segment |
	segment := self model newDerivedTypeDefinition
		           name: name.

	fields do: [ :fieldFactory | segment addField: fieldFactory createComponentDeclaration ]

]

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> model: anObject [

	model := anObject
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> name: anObject [

	name := anObject
]
