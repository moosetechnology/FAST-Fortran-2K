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
FASTFortranDerivedTypeFactory >> makeProcedureBoxed [

	^model newFormattedCodeString
		  content: '
    ! ## boxed aspects


    subroutine boxed_{segmentName}_seg_type(this_segment, type_name)
        class(boxed_{segmentName}), intent(in) :: this_segment
        character(len=segment_type_len), intent(out) :: type_name

        call {segmentName}_seg_type(this_segment%this, type_name)
    end subroutine boxed_{segmentName}_seg_type


    subroutine boxed_{segmentName}_segsup(this_segment)
        class(boxed_{segmentName}), intent(inout) :: this_segment

        call {segmentName}_segsup(this_segment%this)
    end subroutine boxed_{segmentName}_segsup


    subroutine boxed_{segmentName}_finalize(this_segment)
        type(boxed_{segmentName}), intent(inout) :: this_segment

        call {segmentName}_segsup(this_segment%this)
    end subroutine boxed_{segmentName}_finalize


    subroutine boxed_{segmentName}_segprt(this_segment)
        class(boxed_{segmentName}), intent(in) :: this_segment

        call {segmentName}_segprt(this_segment%this)
    end subroutine boxed_{segmentName}_segprt


    subroutine boxed_{segmentName}_seg_store(this_segment, file_number)
        class(boxed_{segmentName}), intent(in) :: this_segment
        integer, intent(in) :: file_number

        call {segmentName}_seg_store(this_segment%this, file_number)
    end subroutine boxed_{segmentName}_seg_store


    subroutine {segmentName}_load(this_segment, file_number)
        class(segment), pointer, intent(inout) :: this_segment
        integer, intent(in) :: file_number

        type({segmentName}), pointer :: this_{segmentName}
        type(boxed_{segmentName}), pointer :: this_boxed_{segmentName}

        call {segmentName}_seg_load(this_{segmentName}, file_number)

        call new_boxed_{segmentName}(this_boxed_{segmentName}, this_{segmentName})
        
        this_segment => this_boxed_{segmentName}
        call check_post_condition(associated(this_segment), ''{segmentName}_load'', ''associated(this_segment)'')
    end subroutine {segmentName}_load


    subroutine boxed_{segmentName}_segcop(this_segment, that_segment)
        ! >> The first and second be declared the same way !
        ! >> - The first (a.k.a. "passed" for dispatch) argument cannot be a pointer
        ! >>   and must be of the declared type
        ! >> - The second argument, polymorphic, must match the abstract interface
        class(boxed_{segmentName}), intent(in) :: this_segment
        class(segment), pointer, intent(inout) :: that_segment

        type(boxed_{segmentName}), pointer :: that_boxed_{segmentName}
        type({segmentName}), pointer :: that_{segmentName}

        call check_pre_condition(.not. associated(that_segment), ''boxed_{segmentName}_segcop'', ''.not. associated(that_segment)'')

        call {segmentName}_segcop(this_segment%this, that_{segmentName})
        call new_boxed_{segmentName}(that_boxed_{segmentName}, that_{segmentName})

        that_segment => that_boxed_{segmentName}
        call check_post_condition(associated(that_segment), ''boxed_{segmentName}_segcop'', ''associated(that_segment)'')
    end subroutine boxed_{segmentName}_segcop


    subroutine boxed_{segmentName}_segmov(this_segment, that_segment)
        ! >> The first and second be declared the same way !
        ! >> - The first (a.k.a. "passed" for dispatch) argument cannot be a pointer
        ! >>   and must be of the declared type
        ! >> - The second argument, polymorphic, must match the abstract interface
        class(boxed_{segmentName}), intent(in) :: this_segment
        class(segment), pointer, intent(inout) :: that_segment

        type(boxed_{segmentName}), pointer :: that_boxed_{segmentName}

        call check_pre_condition(associated(that_segment), ''boxed_{segmentName}_segmov'', ''associated(that_segment)'')

        select type (that_segment)

            type is (boxed_{segmentName})
                that_boxed_{segmentName} => that_segment

            class default
                that_boxed_{segmentName} => null()
                call check_pre_condition(.false., ''boxed_{segmentName}_segmov'', ''type of that_segment is (boxed_{segmentName})'')
        end select

        call {segmentName}_segmov(this_segment%this, that_boxed_{segmentName}%this)
    end subroutine boxed_{segmentName}_segmov


    subroutine {segmentName}_ajpnt(this, that_{segmentName}, segment_type_name, wanted_position, position)
        type(str), pointer, intent(inout) :: this
        type({segmentName}), pointer, intent(in)  :: that_{segmentName}
        character(len=*), intent(in) :: segment_type_name
        integer, intent(in) :: wanted_position
        integer, intent(inout) :: position

        character(len=segment_type_len) :: segment_type_name_expected
        type(boxed_{segmentName}), pointer :: that_boxed_{segmentName}
        class(segment), pointer :: that_segment

        call check_pre_condition(associated(this), ''{segmentName}_ajpnt'', ''associated(this)'')
        call check_pre_condition(associated(that_{segmentName}), ''{segmentName}_ajpnt'', ''associated(that_{segmentName})'')
        call {segmentName}_seg_type(that_{segmentName}, segment_type_name_expected)
        call check_pre_condition(segment_type_name == segment_type_name_expected, ''{segmentName}_ajpnt'', &
            ''segment_type_name == segment_type_name_expected'')

        call new_boxed_{segmentName}(that_boxed_{segmentName}, that_{segmentName})
        
        that_segment => that_boxed_{segmentName}
        
        call ajpnt(this, that_segment, segment_type_name, wanted_position, position)
    end subroutine {segmentName}_ajpnt


    function {segmentName}_mypnt(this, position) result(that_{segmentName})
        type({segmentName}), pointer :: that_{segmentName}
        type(str), pointer, intent(in) :: this
        integer, intent(in) :: position
        
        call {segmentName}_getpnt(this, that_{segmentName}, position)
    end function {segmentName}_mypnt


    subroutine {segmentName}_getpnt(this, that_{segmentName}, position)
        type(str), pointer, intent(in) :: this
        type({segmentName}), pointer, intent(inout)  :: that_{segmentName}
        integer, intent(in) :: position

        class(segment), pointer :: that_segment
        type(boxed_{segmentName}), pointer :: that_boxed_{segmentName}

        call check_pre_condition(associated(this), ''{segmentName}_getpnt'', ''associated(this)'')

        that_{segmentName} => null()

        call getpnt(this, that_segment, position)

        if ( associated(that_segment) ) then
            select type (that_segment)

                type is (boxed_{segmentName})
                    that_boxed_{segmentName} => that_segment
                    that_{segmentName} => that_boxed_{segmentName}%this

                class default
                    that_{segmentName} => null()
                    call check_pre_condition(.false., ''{segmentName}_getpnt'', ''type of that_segment is (boxed_{segmentName})'')
            end select
        end if
    end subroutine {segmentName}_getpnt


    subroutine new_boxed_{segmentName}(this_boxed_{segmentName}, this_{segmentName})
        type(boxed_{segmentName}), pointer, intent(inout) :: this_boxed_{segmentName}
        type({segmentName}), pointer, intent(in) :: this_{segmentName}

        allocate(this_boxed_{segmentName})
        this_boxed_{segmentName}%this => this_{segmentName}
    end subroutine new_boxed_{segmentName}
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
