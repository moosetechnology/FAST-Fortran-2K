Class {
	#name : 'FASTFortranSegmentTransformationVisitor',
	#superclass : 'FASTFortranBehavioralTransformationVisitor',
	#instVars : [
		'tmpStream'
	],
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'visiting - helpers' }
FASTFortranSegmentTransformationVisitor >> computeAllocateSegmentAttributes: aFASTFortranSegment [

	^ '
'
]

{ #category : 'entity creation' }
FASTFortranSegmentTransformationVisitor >> computeDimensionalExpressions: aFASTFortranSegment [

	| visitor parameters |
	parameters := Set new.
	visitor := FASTEsopeSegmentDimensionsVisitor new.
	parameters addAll:
		(aFASTFortranSegment statements flatCollect: [ :declaration |
			 declaration accept: visitor ]).
	^ parameters
]

{ #category : 'visiting - helpers' }
FASTFortranSegmentTransformationVisitor >> computeLocalParamsDims: segmentDimensions [

	| nbDims aStream |
	aStream := WriteStream on: ''.
	nbDims := (segmentDimensions collect: [ :routineParam | routineParam size ]) max.
	1 to: nbDims 
		do: [ :each | aStream << ('integer :: ooo_dim{1}' format: {each}); lf ].

	^ aStream contents.
]

{ #category : 'entity creation' }
FASTFortranSegmentTransformationVisitor >> computeProcedureInitialisationAndAllocation: aFASTFortranSegment [

	| aStream dimensions |
	aStream := WriteStream on: ''.

	dimensions := self computeDimensionalExpressions: aFASTFortranSegment.

	aStream
		<< '			allocate(this)';
		cr.

	dimensions do: [ :parameter |
		aStream
			<< '			this % ';
			<< parameter;
			<< ' = ';
			<< parameter;
			cr ].
	aStream cr.

	aFASTFortranSegment statements do: [ :declaration |
		| typeName |
		typeName := (declaration declaredType accept: FASTFortranExporterVisitor new)
			            outputStream contents.
		declaration declarators do: [ :declarator |
			| dims |
			dims := OrderedCollection new.


			aStream cr
				<< '			!-- this % ';
				<< declarator name;
				cr.

			1 to: declarator dimensions size do: [ :index |
				dims add: 'ooo_dim' , index asString.
				aStream
					<< '			ooo_dim';
					<< index asString;
					<< ' = ';
					<< declarator name;
					<< '_dim';
					<< index asString;
					<< '(';
					<< dimensions asCommaString;
					<< ')';
					cr ].
			aStream
				<< '			allocate(this % ';
				<< declarator name;
				<< '(';
				<< dims asCommaString;
				<< ')';
				cr.
			aStream
				<< '			this % ';
				<< declarator name;
				<< ' = ';
				<< 'segment_';
				<< typeName;
				<< '_default_value';
				cr ] ].

	^ FASTFortran2kSourceCodeString new content: aStream contents
]

{ #category : 'entity creation' }
FASTFortranSegmentTransformationVisitor >> computeProcedureLocalVariablesDimensions: aFASTFortranSegment [

	| maxDim aStream dimensions |
	dimensions := aFASTFortranSegment statements 
		flatCollect: [ :declaration |
			declaration declarators 
				collect: [ :declarator | declarator dimensions size ] 
		].

	maxDim := dimensions 
		ifNotEmpty: [ dimensions max ] 
		ifEmpty:    [ 0 ].

	aStream := WriteStream on: ''.

	1 to: maxDim do: [ :each |
		aStream
			<< '		integer :: ooo_dim';
			<< each asString;
			cr ].
	^ FASTFortran2kSourceCodeString new content: aStream contents
]

{ #category : 'entity creation' }
FASTFortranSegmentTransformationVisitor >> computeProcedureParameters: aFASTFortranSegment [

	| parameters |
	parameters := OrderedCollection new.
	parameters add: (FASTFortran2kScalarVariable new name: 'this').
	parameters addAll:
		((self computeDimensionalExpressions: aFASTFortranSegment) collect: [
			 :parameter | FASTFortran2kScalarVariable new name: parameter ]).

	^ parameters
]

{ #category : 'entity creation' }
FASTFortranSegmentTransformationVisitor >> computeProcedureParametersDeclaration: aFASTFortranSegment [

	| aStream parameters |
	parameters := self computeDimensionalExpressions: aFASTFortranSegment.

	aStream := WriteStream on: ''.

	parameters do: [ :parameterName |
		(aStream << '		integer, intent(in) :: ')
			<< parameterName;
			cr ].

	^ FASTFortran2kFormattedCodeString new
		  content: aStream contents;
		  values: (Dictionary with: #segmentName -> aFASTFortranSegment)
]

{ #category : 'visiting - helpers' }
FASTFortranSegmentTransformationVisitor >> computeRoutineParams: segmentDimensions [

	|  dimensions |

	dimensions := segmentDimensions flattened.
	dimensions ifEmpty: [ ^ '' ].

	^ String 
		streamContents: [ :aStream |
			aStream << ', '. 
			dimensions 
				do: [ :dimension | aStream << dimension ]
				separatedBy: [  aStream << ', ' ] 
		 ]
]

{ #category : 'visiting - helpers' }
FASTFortranSegmentTransformationVisitor >> computeRoutineParamsDeclarations: routineParams [
	| aStream |
	aStream := WriteStream on: ''.
	routineParams 
		do: [ :routineParam |
		   routineParam 
				do: [ :name | 
					aStream << 'integer, intent(in) :: ' << name ; lf 
				] 
		].
	^aStream contents.
]

{ #category : 'visiting - helpers' }
FASTFortranSegmentTransformationVisitor >> computeSegmentsDimensions: aFASTFortranSegment [

	| visitor |
	visitor := FASTEsopeSegmentDimensionsVisitor new.

	^ aFASTFortranSegment statements 
		collect: [ :declarationStatement |
		  (declarationStatement accept: visitor) flattened 
		]
]

{ #category : 'helpers' }
FASTFortranSegmentTransformationVisitor >> ensureEmptyStream [

	tmpStream := WriteStream with: ''
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeBoxedTypeDefinition: segmentName [

	^ self model newFormattedCodeString
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
		  values: (Dictionary with: #segmentName -> segmentName)
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeContainsStatement: segmentName [

	^ self model newFormattedCodeString
		  content: '
contains
	 ! ## primary aspects
    ! begin: the fields dimensions from the parameters
    ! end: the fields dimensions from the parameters

';
		  values: (Dictionary with: #segmentName -> segmentName)
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeInterfaces: segmentName [

	^ self model newFormattedCodeString
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
		  values: (Dictionary with: #segmentName -> segmentName)
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProcedureAssignPointerToPointer: segmentName [

	^ self model newFormattedCodeString
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
		  values: (Dictionary with: #segmentName -> segmentName)
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProcedureBoxed: segmentName [

	^ self model newFormattedCodeString
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
		  values: (Dictionary with: #segmentName -> segmentName)
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProcedureIgnore: segmentName [

	^ self model newFormattedCodeString
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
		  values: (Dictionary with: #segmentName -> segmentName)
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProcedureSegadj: aFASTFortranSegment [

	| segxxx parameterNames |
	self ensureEmptyStream.
	parameterNames := ''.

	tmpStream << '	
	subroutine {segmentName}_segmov(this {segmentParameterNames})
	! ## Copy data from "this" segment to an existing "that" segment
	! ## "that" must have same dimensions than "this"
		type({segmentName}, pointer, intent(in) :: this
		type({segmentName}, pointer, intent(inout) :: that
'.
	self flag: #FIXME. "process all the parameters here"
	tmpStream << '
	end subroutine {segmentName}_segadj(this)
'.

	segxxx := self model newFormattedCodeString
		          content: tmpStream contents;
		          values: {
				          (#segmentName -> aFASTFortranSegment name).
				          (#segmentParameterNames -> parameterNames) }
				          asDictionary.

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProcedureSegcop: aFASTFortranSegment [

	| segxxx |
	self ensureEmptyStream.

	tmpStream << '	
	subroutine {segmentName}_segcop(this, that)
	! ## Copy "this" segment to a new "that" segment
		type({segmentName}, pointer, intent(in) :: this
		type({segmentName}, pointer, intent(inout) :: that
'.
	self flag: #FIXME. "process all the parameters here"
	tmpStream << '	
		call check_pre_condition(associated(this), ''{segmentName}_segcop'', ''associated(this)'')
	end subroutine {segmentName}_segcop(this)
'.

	segxxx := self model newFormattedCodeString
		          content: tmpStream contents;
		          values:
			          (Dictionary with:
					           #segmentName -> aFASTFortranSegment name).

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProcedureSegini2: aFASTFortranSegment [
	"
	subroutine {segmentName}_segini(this {routineParams})
		! ## Initialize a new ""this"" segment with default values
		! ## using the given parameters
		type({segmentName}, pointer, intent(inout) :: this
		{routineParamsDeclarations}
	
		{localParamsDims}
	
		allocate(this)
		{allocateSegmentAttributes}

		call check_post_condition(associated(this), ''{segmentName}_segini'', ''associated(this)'')
	end subroutine {segmentName}_segini
"

	^ FASTFortran2kSubroutine new
		  name: aFASTFortranSegment name, '_segini';
		  comments: { (FASTFortran2kComment new content: '
		 ## Initialize a new "this" segment with default values
		 ## using the given parameters
') };
		  parameters: (self computeProcedureParameters: aFASTFortranSegment);
		  statementBlock:
			  (FASTFortran2kStatementBlock new 
					statements: {
					   FASTFortran2kFormattedCodeString new content: '
			type({segmentName}), pointer, intent(inout) :: this
'; values: (Dictionary with: #segmentName -> aFASTFortranSegment name).
						self computeProcedureParametersDeclaration: aFASTFortranSegment.
						self computeProcedureLocalVariablesDimensions: aFASTFortranSegment.
						self computeProcedureInitialisationAndAllocation: aFASTFortranSegment.
						FASTFortran2kFormattedCodeString new
						content: 'call check_post_condition(associated(this), ''{segmentName}_segini'', ''associated(this)'')';
						values: (Dictionary with: #segmentName -> aFASTFortranSegment name).
					}
				);
		  yourself
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProcedureSegini: aFASTFortranSegment [

	| segxxx routineParams routineParamsDeclarations localParamsDims allocateSegmentAttributes segmentDimensions |
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

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProcedureSeglik: aFASTFortranSegment [

	| segxxx parameterNames |
	self ensureEmptyStream.
	parameterNames := ''.

	tmpStream << '	
	function {segmentName}_seglik(this, that) result(have_same_parameters)
	! ## Do "this" and "that" segments have the same dimensions
	! ## "that" must have same dimensions than "this"
		type({segmentName}, pointer, intent(in) :: this
		type({segmentName}, pointer, intent(in) :: that
		logical :: have_same_parameters
		
		have_same_parameters = .false.
		
		if ( .not. associated(this) ) return
		if ( .not. associated(that) ) return
		
		if ( associated(this, that) ) then
			have_same_parameters = .true.
		else
			have_same_parameters = .true.
'.
	self flag: #FIXME. "process all the parameters here"
	tmpStream << '
		end if
	end function {segmentName}_seglik(this)
'.

	segxxx := self model newFormattedCodeString
		          content: tmpStream contents;
		          values: {
				          (#segmentName -> aFASTFortranSegment name).
				          (#segmentParameterNames -> parameterNames) }
				          asDictionary.

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProcedureSegload: aFASTFortranSegment [

	| segxxx parameterNames |
	self ensureEmptyStream.
	parameterNames := ''.

	tmpStream << '	
	subroutine {segmentName}_seg_load(this, file_number)
	! ## Get the given "this" segment from the file referenced by "file_number"
		type({segmentName}, pointer, intent(inout) :: this
		integer, intent(in) :: file_number

'.
	self flag: #FIXME. "process all the parameters here"
	tmpStream << '
		end if
	end subroutine {segmentName}_seg_load(this)
'.

	segxxx := self model newFormattedCodeString
		          content: tmpStream contents;
		          values:
			          (Dictionary with:
					           #segmentName -> aFASTFortranSegment name).

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProcedureSegloc: segmentName [

	^ self model newFormattedCodeString
		  content: '
    function {segmentName}_segloc(this) result(this_loc)
        ! ## Return a location of the "this" pointer
        ! ## just to trace pointers during debug,
        ! ## should not be use for other purpose !!!
        
        use, intrinsic :: iso_fortran_env, only : int64
        use, intrinsic :: iso_c_binding, only : c_loc
        
        type({segmentName}), pointer, intent(in) :: this
        integer(int64) :: this_loc

        this_loc = transfer(c_loc(this), this_loc)
    end function {segmentName}_segloc
';
		  values: (Dictionary with: #segmentName -> segmentName)
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProcedureSegmentType: segmentName [

	^ self model newFormattedCodeString
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
		  values: (Dictionary with: #segmentName -> segmentName)
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProcedureSegmov: aFASTFortranSegment [

	| segxxx |
	self ensureEmptyStream.

	tmpStream << '	
	subroutine {segmentName}_segmov(this, that)
	! ## Copy data from "this" segment to an existing "that" segment
	! ## "that" must have same dimensions than "this"
		type({segmentName}, pointer, intent(in) :: this
		type({segmentName}, pointer, intent(inout) :: that
'.
	self flag: #FIXME. "process all the parameters here"
	tmpStream << '
	end subroutine {segmentName}_segmov(this)
'.

	segxxx := self model newFormattedCodeString
		          content: tmpStream contents;
		          values:
			          (Dictionary with:
					           #segmentName -> aFASTFortranSegment name).

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProcedureSegpar: aFASTFortranSegment [

	| segxxx parameterNames |
	self ensureEmptyStream.
	parameterNames := ''.

	tmpStream << '	
	subroutine {segmentName}_segpar(this {segmentParameterNames})
	! ## Return the parameters of the given "this" segment
	! ## "that" must have same dimensions than "this"
		type({segmentName}, pointer, intent(in) :: this

'.
	self flag: #FIXME. "process all the parameters here"
	tmpStream << '
		end if
	end subroutine {segmentName}_segpar(this)
'.

	segxxx := self model newFormattedCodeString
		          content: tmpStream contents;
		          values: {
				          (#segmentName -> aFASTFortranSegment name).
				          (#segmentParameterNames -> parameterNames) }
				          asDictionary.

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProcedureSegprt: aFASTFortranSegment [

	| segxxx parameterNames |
	self ensureEmptyStream.
	parameterNames := ''.

	tmpStream << '	
	subroutine {segmentName}_segprt(this)
	! ## Print the given "this" segment
		type({segmentName}, pointer, intent(in) :: this

'.
	self flag: #FIXME. "process all the parameters here"
	tmpStream << '
		end if
	end subroutine {segmentName}_segprt(this)
'.

	segxxx := self model newFormattedCodeString
		          content: tmpStream contents;
		          values:
			          (Dictionary with:
					           #segmentName -> aFASTFortranSegment name).

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProcedureSegstore: aFASTFortranSegment [

	| segxxx parameterNames |
	self ensureEmptyStream.
	parameterNames := ''.

	tmpStream << '	
	subroutine {segmentName}_seg_store(this, file_number)
	! ## Put the given "this" segment on the file referenced by "file_number"
		type({segmentName}, pointer, intent(in) :: this
		integer, intent(in) :: file_number
'.
	self flag: #FIXME. "process all the parameters here"
	tmpStream << '
		end if
	end subroutine {segmentName}_seg_store(this)
'.

	segxxx := self model newFormattedCodeString
		          content: tmpStream contents;
		          values:
			          (Dictionary with:
					           #segmentName -> aFASTFortranSegment name).

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProcedureSegsup: aFASTFortranSegment [

	| segxxx parameterNames |
	self ensureEmptyStream.
	parameterNames := ''.

	tmpStream << '	
	subroutine {segmentName}_segsup(this)
	! ## Delete ("supprimer" in French) the given "this" segment
		type({segmentName}, pointer, intent(inout) :: this
'.
	self flag: #FIXME. "process all the parameters here"
	tmpStream << '
		end if
	end subroutine {segmentName}_segsup(this)
'.

	segxxx := self model newFormattedCodeString
		          content: tmpStream contents;
		          values:
			          (Dictionary with:
					           #segmentName -> aFASTFortranSegment name).

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProceduresDimensions: aFASTFortranSegment [

	| parameters procedures |
	parameters := self computeDimensionalExpressions: aFASTFortranSegment.

	procedures := OrderedCollection new.

	aFASTFortranSegment statements do: [ :declaration | 
		declaration declarators do: [ :declarator | | index | 
			index := 1.
			declarator dimensions do: [ :dimension |
			| procedure procedureName aStream  dimExpresion |
			
			aStream := WriteStream on: ''.
			procedureName := declarator name , '_dim' , index asString.
			dimExpresion := dimension accept: FASTFortranArrayRangeVisitor new.
			aStream cr << '			'; << declarator name; << '_dim'; << index asString; << ' = '; << dimExpresion; cr;
						<<   '			call check_post_condition('; << procedureName ; <<' >= 0, ''bar::'; << procedureName ; <<''', '''; << procedureName; << ' >= 0'')'; cr. 
			self flag: #FIXME. "call ignore(jdim, 'jdim', 'bar::idata_dim1')"
			procedure := FASTFortran2kFunction new
				returnType: FASTFortran2kIntegerType new;
				name: procedureName;
				parameters: (parameters collect: [ :parameter |
					FASTFortran2kScalarVariable new name: parameter ]);
				statementBlock: (FASTFortran2kStatementBlock new 
					statements: { 
						self computeProcedureParametersDeclaration: aFASTFortranSegment.
						FASTFortran2kSourceCodeString new content: aStream contents.
					}
				).
		
			procedures add: procedure.
			index := index + 1.
		] ]].

	^procedures 
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeProgramUnit: programUnits [

	| progUnits procedures |
	progUnits := OrderedCollection new.

	procedures := (programUnits select: [ :pu |
		               pu class superclass = FASTFortranProcedure ])
		              collect: [ :pu | pu accept: self ].
	procedures ifNotEmpty: [
		progUnits add: (FASTFortran2kModule new
				 name: 'temp_mod';
				 procedures: procedures;
				 mooseModel: model;
				 yourself) ].

	progUnits add:
		((programUnits select: [ :pu | pu class = FASTFortranProgramMain ])
			 collect: [ :pu | pu accept: self ]).
	^ progUnits
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeSegmentModuleProlog [

	^ self model newSourceCodeString content: '
	use ignore_m
	use contract_m
	use segment_m
	use str_m

	implicit none
	private
'
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeSegmentTypeName: segmentName [

	^ FASTFortran2kFormattedCodeString new
		  content: '

    public {segmentName}_type_name
    character(len=segment_type_len), parameter :: {segmentName}_type_name = ''{segmentName}''
';
		  values: (Dictionary with: #segmentName -> segmentName)
]

{ #category : 'helpers - segment' }
FASTFortranSegmentTransformationVisitor >> makeTypeDefinition: aFASTFortranSegment [

	| segment visitor |
	segment := self model newDerivedTypeDefinition
		           name: aFASTFortranSegment name.

	visitor := FASTEsopeSegmentVisitor new.

	aFASTFortranSegment statements do: [ :declarationStatement |
		segment derivedTypeComponents:
			(declarationStatement accept: visitor) ].

	^segment
]

{ #category : 'visiting' }
FASTFortranSegmentTransformationVisitor >> visitFASTEsopeSegment: aFASTEsopeSegmentNode [

	| module segmentName |
	segmentName := aFASTEsopeSegmentNode name.

	module := self model newModule name: segmentName , '_mod'.
	module addProcedure: (self makeProcedureSegini2: aFASTEsopeSegmentNode).
	module procedures addAll:
		(self makeProceduresDimensions: aFASTEsopeSegmentNode).

	module statementBlock:
		(FASTFortran2kStatementBlock new statements: {
				 self makeSegmentModuleProlog.
				 (self makeTypeDefinition: aFASTEsopeSegmentNode).
				 (self makeSegmentTypeName: segmentName).
				 (self makeBoxedTypeDefinition: segmentName).
				 (self makeInterfaces: segmentName).
				 (self makeContainsStatement: segmentName).
				 (self makeProcedureIgnore: segmentName).
				 (self makeProcedureAssignPointerToPointer: segmentName).
				 (self makeProcedureSegmentType: segmentName).
				 (self makeProcedureSegini: aFASTEsopeSegmentNode).
				 (self makeProcedureSegcop: aFASTEsopeSegmentNode).
				 (self makeProcedureSegmov: aFASTEsopeSegmentNode).
				 (self makeProcedureSegadj: aFASTEsopeSegmentNode).
				 (self makeProcedureSegsup: aFASTEsopeSegmentNode).
				 (self makeProcedureSegprt: aFASTEsopeSegmentNode).
				 (self makeProcedureSegstore: aFASTEsopeSegmentNode).
				 (self makeProcedureSegload: aFASTEsopeSegmentNode).
				 (self makeProcedureSegpar: aFASTEsopeSegmentNode).
				 (self makeProcedureSeglik: aFASTEsopeSegmentNode).
				 (self makeProcedureSegloc: segmentName).
				 (self makeProcedureBoxed: segmentName) }).
	^ module
]

{ #category : 'visiting' }
FASTFortranSegmentTransformationVisitor >> visitSegmentAttributes: attributes [

	| generatedCode |
	self ensureEmptyStream.
	attributes do: [ :each |
		| parameters |

		self flag: #FIXME. "handle parameters in each declaractors dimensions"
		parameters := each declarators collect: #dimensions.

		parameters ifNotEmpty: [
			parameters do: [  :parameter | 
 		tmpStream
			<<
			'integer, private :: ',  parameter name, ' = 0'
			].
			]
		].
	generatedCode := tmpStream contents.
	self ensureEmptyStream.
	^ generatedCode
]
