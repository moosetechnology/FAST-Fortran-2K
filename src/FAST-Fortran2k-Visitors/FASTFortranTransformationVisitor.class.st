Class {
	#name : 'FASTFortranTransformationVisitor',
	#superclass : 'FASTFortranAbstractTransformationVisitor',
	#instVars : [
		'tmpStream',
		'useNeeded'
	],
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'helpers' }
FASTFortranTransformationVisitor >> addUseIn: aFASTFortran2kEntity to: moduleName [

	self flag: #FIXME. "how to handle the order of uses statements"
	aFASTFortran2kEntity statementBlock statements 
		addFirst: (
		FASTFortran2kUseStatement new 
			name: moduleName ;
			mooseModel: model;
			yourself
		)
	

]

{ #category : 'helpers' }
FASTFortranTransformationVisitor >> addUsesIn: programUnit [
	"programUnit is a FASTFortran2k ProgramUnit.
	 Checking if it needs some 'use' instructions"

	useNeeded do: [ :assoc || source target |
		source := assoc key.    "a FASTFortran2k ProgramUnit or a DerivedTypeDefinition"
		target := assoc value.  "a FamixF77 ProgramFile or Segment"

		(source inSameFileAs: programUnit)
			ifTrue: [
				(source needsUseFor: target)
					ifTrue: [ self addUseIn: programUnit to: target migratedModuleName ]
			]
	]
]

{ #category : 'visiting - helpers' }
FASTFortranTransformationVisitor >> computeAllocateSegmentAttributes: aFASTFortranSegment [

	^ '
'
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> computeDimensionalExpressions: aFASTFortranSegment [

	| visitor parameters |
	parameters := Set new.
	visitor := FASTEsopeSegmentDimensionsVisitor new.
	parameters addAll:
		(aFASTFortranSegment statements flatCollect: [ :declaration |
			 declaration accept: visitor ]).
	^ parameters
]

{ #category : 'visiting - helpers' }
FASTFortranTransformationVisitor >> computeLocalParamsDims: segmentDimensions [

	| nbDims aStream |
	aStream := WriteStream on: ''.
	nbDims := (segmentDimensions collect: [ :routineParam | routineParam size ]) max.
	1 to: nbDims 
		do: [ :each | aStream << ('integer :: ooo_dim{1}' format: {each}); lf ].

	^ aStream contents.
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> computeProcedureInitialisationAndAllocation: aFASTFortranSegment [

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
FASTFortranTransformationVisitor >> computeProcedureLocalVariablesDimensions: aFASTFortranSegment [

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
FASTFortranTransformationVisitor >> computeProcedureParameters: aFASTFortranSegment [

	| parameters |
	parameters := OrderedCollection new.
	parameters add: (FASTFortran2kScalarVariable new name: 'this').
	parameters addAll:
		((self computeDimensionalExpressions: aFASTFortranSegment) collect: [
			 :parameter | FASTFortran2kScalarVariable new name: parameter ]).

	^ parameters
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> computeProcedureParametersDeclaration: aFASTFortranSegment [

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
FASTFortranTransformationVisitor >> computeRoutineParams: segmentDimensions [

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
FASTFortranTransformationVisitor >> computeRoutineParamsDeclarations: routineParams [
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
FASTFortranTransformationVisitor >> computeSegmentsDimensions: aFASTFortranSegment [

	| visitor |
	visitor := FASTEsopeSegmentDimensionsVisitor new.

	^ aFASTFortranSegment statements 
		collect: [ :declarationStatement |
		  (declarationStatement accept: visitor) flattened 
		]
]

{ #category : 'helpers' }
FASTFortranTransformationVisitor >> createProgramFile: f77Filename forProgramUnits: programUnitsF2k [
	"Creates one or several FASTFortran2kProgramFile from the programUnitsF2k
	 - one for a FASTFortran2kProgramMain
	 - one for all FASTFortran2kProcedure grouped in a FASTFortran2kModule
	 - one for each FASTFortran2kDerivedType (segments)"

	| puModule puMain programFiles |
	programFiles := OrderedCollection new: 2.
	puModule := OrderedCollection new.
	puMain := nil.

	programUnitsF2k do: [ :progUnit |
		progUnit class = FASTFortran2kProgramMain
			ifTrue: [ puMain := progUnit ]
			ifFalse: [ puModule add: progUnit ] ].

	puModule ifNotEmpty: [ programFiles filename: (self fortran2kFilename: f77Filename) ].

	puMain ifNotNil: [ programFiles filename: (self fortran2kFilename: f77Filename) ].

	puModule ifNotEmpty: [
		programFiles
			addProgramUnit: ((self makePuModule: f77Filename)
				 procedures: puModule;
				 yourself).

		self addUsesIn: programFiles programUnit last.
	].

	puMain ifNotNil: [ 
		programFiles addProgramUnit: puMain.

		self addUsesIn: puMain
	].

	useNeeded removeAll 
	
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> ensureEmptyStream [

	tmpStream := WriteStream with: ''
]

{ #category : 'helpers' }
FASTFortranTransformationVisitor >> fortran2kFilename: f77Filename [
	"assuming f77Filename is of the form: 'xyz.f' "
	
	^f77Filename , '90'
]

{ #category : 'initialization' }
FASTFortranTransformationVisitor >> initialize [

	super initialize.

	model := FASTFortran2kModel new.
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeBoxedTypeDefinition: segmentName [

	^ FASTFortran2kFormattedCodeString new
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

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeContainsStatement: segmentName [

	^ FASTFortran2kFormattedCodeString new
		  content: '
contains
	 ! ## primary aspects
    ! begin: the fields dimensions from the parameters
    ! end: the fields dimensions from the parameters

';
		  values: (Dictionary with: #segmentName -> segmentName)
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeInterfaces: segmentName [

	^ FASTFortran2kFormattedCodeString new
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

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProcedureAssignPointerToPointer: segmentName [

	^ FASTFortran2kFormattedCodeString new
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

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProcedureBoxed: segmentName [

	^ FASTFortran2kFormattedCodeString new
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

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProcedureIgnore: segmentName [

	^ FASTFortran2kFormattedCodeString new
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

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProcedureSegadj: aFASTFortranSegment [

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

	segxxx := FASTFortran2kFormattedCodeString new
		          content: tmpStream contents;
		          values: {
				          (#segmentName -> aFASTFortranSegment name).
				          (#segmentParameterNames -> parameterNames) }
				          asDictionary.

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProcedureSegcop: aFASTFortranSegment [

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

	segxxx := FASTFortran2kFormattedCodeString new
		          content: tmpStream contents;
		          values:
			          (Dictionary with:
					           #segmentName -> aFASTFortranSegment name).

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProcedureSegini2: aFASTFortranSegment [
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

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProcedureSegini: aFASTFortranSegment [

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

	segxxx := FASTFortran2kFormattedCodeString new
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

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProcedureSeglik: aFASTFortranSegment [

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

	segxxx := FASTFortran2kFormattedCodeString new
		          content: tmpStream contents;
		          values: {
				          (#segmentName -> aFASTFortranSegment name).
				          (#segmentParameterNames -> parameterNames) }
				          asDictionary.

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProcedureSegload: aFASTFortranSegment [

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

	segxxx := FASTFortran2kFormattedCodeString new
		          content: tmpStream contents;
		          values:
			          (Dictionary with:
					           #segmentName -> aFASTFortranSegment name).

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProcedureSegloc: segmentName [

	^ FASTFortran2kFormattedCodeString new
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

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProcedureSegmentType: segmentName [

	^ FASTFortran2kFormattedCodeString new
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

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProcedureSegmov: aFASTFortranSegment [

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

	segxxx := FASTFortran2kFormattedCodeString new
		          content: tmpStream contents;
		          values:
			          (Dictionary with:
					           #segmentName -> aFASTFortranSegment name).

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProcedureSegpar: aFASTFortranSegment [

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

	segxxx := FASTFortran2kFormattedCodeString new
		          content: tmpStream contents;
		          values: {
				          (#segmentName -> aFASTFortranSegment name).
				          (#segmentParameterNames -> parameterNames) }
				          asDictionary.

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProcedureSegprt: aFASTFortranSegment [

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

	segxxx := FASTFortran2kFormattedCodeString new
		          content: tmpStream contents;
		          values:
			          (Dictionary with:
					           #segmentName -> aFASTFortranSegment name).

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProcedureSegstore: aFASTFortranSegment [

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

	segxxx := FASTFortran2kFormattedCodeString new
		          content: tmpStream contents;
		          values:
			          (Dictionary with:
					           #segmentName -> aFASTFortranSegment name).

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProcedureSegsup: aFASTFortranSegment [

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

	segxxx := FASTFortran2kFormattedCodeString new
		          content: tmpStream contents;
		          values:
			          (Dictionary with:
					           #segmentName -> aFASTFortranSegment name).

	self ensureEmptyStream.
	^ segxxx
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProceduresDimensions: aFASTFortranSegment [

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

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeProgramUnit: programUnits [

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

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makePuModule: filename [
	^ FASTFortran2kModule new 
		name: (($. split: filename) first, '_mod');
		statementBlock: (FASTFortran2kStatementBlock new
			addStatement: (FASTFortran2kImplicitStatement new 
				mooseModel: model; 
				yourself
			);
			mooseModel: model;
			yourself
		);
		mooseModel: model;
		yourself.
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeSegmentModuleProlog [

	^ FASTFortran2kSourceCodeString new content: '
	use ignore_m
	use contract_m
	use segment_m
	use str_m

	implicit none
	private
'
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeSegmentTypeName: segmentName [

	^ FASTFortran2kFormattedCodeString new
		  content: '

    public {segmentName}_type_name
    character(len=segment_type_len), parameter :: {segmentName}_type_name = ''{segmentName}''
';
		  values: (Dictionary with: #segmentName -> segmentName)
]

{ #category : 'entity creation' }
FASTFortranTransformationVisitor >> makeTypeDefinition: aFASTFortranSegment [

	| segment visitor |
	segment := FASTFortran2kDerivedTypeDefinition new
		           name: aFASTFortranSegment name;
		           derivedTypeComponents: OrderedCollection new.

	visitor := FASTEsopeSegmentVisitor new.

	aFASTFortranSegment statements do: [ :declarationStatement |
		segment derivedTypeComponents addAll:
			(declarationStatement accept: visitor) ].


	^segment
]

{ #category : 'accessing' }
FASTFortranTransformationVisitor >> model [

	^ model
]

{ #category : 'accessing' }
FASTFortranTransformationVisitor >> model: aFASTModel [

	model := aFASTModel 
]

{ #category : 'helpers' }
FASTFortranTransformationVisitor >> programFile: programFile in: f77Filename modules: programUnits [

	| puModule puMain |
	puModule := OrderedCollection new.
	puMain := nil.

	programUnits do: [ :progUnit |
		progUnit class = FASTFortran2kProgramMain
			ifTrue: [ puMain := progUnit ]
			ifFalse: [ puModule add: progUnit ] ].

	puModule ifNotEmpty: [ programFile filename: (self fortran2kFilename: f77Filename) ].

	puMain ifNotNil: [ programFile filename: (self fortran2kFilename: f77Filename) ].

	puModule ifNotEmpty: [
		programFile
			addProgramUnit: ((self makePuModule: f77Filename)
				 procedures: puModule;
				 yourself).

		self addUsesIn: programFile programUnit last.
	].

	puMain ifNotNil: [ 
		programFile addProgramUnit: puMain.

		self addUsesIn: puMain
	].

	useNeeded removeAll 
	
]

{ #category : 'visiting' }
FASTFortranTransformationVisitor >> visitFASTEsopeIncludeStatement: aFASTEsopeIncludeStatement [

	| famixProgramUnit f2kProgramUnit |
	
	famixProgramUnit := aFASTEsopeIncludeStatement statementContainer fastBehaviouralParent famix.
	f2kProgramUnit := stack top.
	famixProgramUnit includes halt
]

{ #category : 'visiting' }
FASTFortranTransformationVisitor >> visitFASTEsopePointerDeclarationStatement: aFASTEsopePointerDeclarationStatement [
	^aFASTEsopePointerDeclarationStatement pointerDeclarators 
		collect: [ :pointerDeclarator | pointerDeclarator accept: self ].
	
]

{ #category : 'visiting' }
FASTFortranTransformationVisitor >> visitFASTEsopePointerDeclarator: aFASTEsopePointerDeclarator [ 
	
	| esopeDeclarator callerProgramUnit pointerDeclaredType |

	esopeDeclarator := FASTFortran2kDerivedTypeDeclaration new 
		type: (FASTFortran2kUserDefinedType new 
			name: aFASTEsopePointerDeclarator pointedTypeName;
			mooseModel: model;
			yourself
		);
		addDeclarator: (aFASTEsopePointerDeclarator variableDeclarator accept: self);
		mooseModel: model;
		yourself.

	callerProgramUnit := stack top.
	pointerDeclaredType := aFASTEsopePointerDeclarator pointerDeclarationStatement famix declaredType.

	useNeeded add: (callerProgramUnit  -> pointerDeclaredType).

	^esopeDeclarator
]

{ #category : 'visiting' }
FASTFortranTransformationVisitor >> visitFASTEsopeSegment: aFASTEsopeSegmentNode [

	| module segmentName |
	segmentName := aFASTEsopeSegmentNode name.

	module := FASTFortran2kModule new name: segmentName , '_m'.
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

{ #category : 'visiting - expressions' }
FASTFortranTransformationVisitor >> visitFASTFortranAssignmentExpression: anAssignmentExpressionNode [

	| variable expression |
	variable := anAssignmentExpressionNode variable accept: self.
	expression := anAssignmentExpressionNode expression accept: self.

	^ FASTFortran2kAssignmentExpression new
		  variable: variable;
		  expression: expression;
		  mooseModel: model;
		  yourself
]

{ #category : 'visiting - statements' }
FASTFortranTransformationVisitor >> visitFASTFortranAssignmentStatement: anAssignmentStatementNode [

	^ FASTFortran2kAssignmentStatement new
		  variable: (anAssignmentStatementNode variable accept: self);
		  expression: (anAssignmentStatementNode expression accept: self);
		  "migrateFrom: anAssignmentStatementNode;"
		  mooseModel: model;
		  yourself
]

{ #category : 'visiting' }
FASTFortranTransformationVisitor >> visitFASTFortranAsterisk: aFASTFortranAsterisk [

	^ FASTFortran2kAsterisk new mooseModel: model
]

{ #category : 'visiting - expressions' }
FASTFortranTransformationVisitor >> visitFASTFortranBinaryExpression: aBinaryExpresionNode [

	^ FASTFortran2kBinaryExpression new
		  operator: aBinaryExpresionNode operator;
		  leftOperand: (aBinaryExpresionNode leftOperand accept: self);
		  rightOperand: (aBinaryExpresionNode rightOperand accept: self);
		  mooseModel: model;
		  yourself
]

{ #category : 'visiting - expressions' }
FASTFortranTransformationVisitor >> visitFASTFortranBooleanLiteral: aBooleanLiteralNode [

	^ FASTFortran2kBooleanLiteral new
		  primitiveValue: aBooleanLiteralNode primitiveValue;
		  mooseModel: model;
		  yourself
]

{ #category : 'visiting - statements' }
FASTFortranTransformationVisitor >> visitFASTFortranCallStatement: aFASTFortranCallStatement [

	| callStatement callerProgramUnit calledProgramFile |

	callStatement := FASTFortran2kCallStatement new
		name: aFASTFortranCallStatement name;
		arguments: (aFASTFortranCallStatement arguments
				collect: [ :argument | argument accept: self ]
		);
		mooseModel: model;
		yourself.

	callerProgramUnit := stack top.
	calledProgramFile := aFASTFortranCallStatement famix candidates anyOne.

	useNeeded add: (callerProgramUnit -> calledProgramFile).

	^ callStatement

]

{ #category : 'visiting - expressions' }
FASTFortranTransformationVisitor >> visitFASTFortranCharacterLiteral: aFASTFortranCharacterLiteral [

	^ FASTFortran2kCharacterLiteral new
		  primitiveValue: aFASTFortranCharacterLiteral primitiveValue;
		  mooseModel: model;
		  yourself
]

{ #category : 'visiting' }
FASTFortranTransformationVisitor >> visitFASTFortranCharacterType: aFASTFortranCharacterType [

	^ FASTFortran2kCharacterType new size:
		  (aFASTFortranCharacterType size accept: self)
]

{ #category : 'visiting' }
FASTFortranTransformationVisitor >> visitFASTFortranComment: aCommentNode [

	^ FASTFortran2kComment new
		  content: aCommentNode content;
		  mooseModel: model;
		  yourself
]

{ #category : 'visiting - statements' }
FASTFortranTransformationVisitor >> visitFASTFortranDoStatement: aDoStatementNode [

	^ FASTFortran2kDoStatement new
		  loopControl: (aDoStatementNode loopControl accept: self);
		  statementBlock:
			  (self visitSatementBlock: aDoStatementNode statementBlock);
		  mooseModel: model;
		  yourself
]

{ #category : 'visiting - programUnits' }
FASTFortranTransformationVisitor >> visitFASTFortranFunction: aFASTFortranFunction [

	| subroutine |
	subroutine := FASTFortran2kFunction new
		name: aFASTFortranFunction name;
		mooseModel: model;
		yourself.
		
	stack push: subroutine.
	
	super visitFASTFortranFunction: aFASTFortranFunction.
	
	stack pop.
	^subroutine.
]

{ #category : 'visiting - expressions' }
FASTFortranTransformationVisitor >> visitFASTFortranFunctionCall: aFASTFortranFunctionCall [

	| functionCall callerProgramUnit calledProgramFile |

	functionCall := FASTFortran2kFunctionCall new
		mooseModel: model;
		name: aFASTFortranFunctionCall name ;
		arguments: (aFASTFortranFunctionCall arguments collect: [:arg | arg accept: self]) ;
		yourself.

	callerProgramUnit := stack top.
	calledProgramFile := aFASTFortranFunctionCall famix candidates anyOne.

	useNeeded add: (callerProgramUnit -> calledProgramFile).

	^functionCall 
]

{ #category : 'visiting - statements' }
FASTFortranTransformationVisitor >> visitFASTFortranFunctionStatement: aFunctionStatementNode [


	| fct |
	fct := FASTFortran2kInternalFunction new
		name: aFunctionStatementNode name.
	
	fct returnType: (aFunctionStatementNode famix declaredType accept: self).
		
	fct	 parameters: (aFunctionStatementNode parameters collect: [:parameter | 
			FASTFortran2kScalarVariable new 
				name: parameter name; 
				mooseModel: model;
				yourself
			]).
		
	fct statementBlock: FASTFortran2kStatementBlock new.

	aFunctionStatementNode parameters do: [:parameter |
		fct statementBlock addStatement: (
			FASTFortran2kVariableDeclarationStatement new
				type: (parameter famixParameter declaredType accept: self);
				declarators: { FASTFortran2kVariableDeclarator new 
					name:  parameter name; 
					mooseModel: model; 
					yourself 
				};
				mooseModel: model;
				yourself
		)
	].

	
	fct statementBlock addStatement:	(	
			FASTFortran2kAssignmentStatement new
				variable: (FASTFortran2kVariable new name: aFunctionStatementNode name);
				expression: (aFunctionStatementNode expression accept: self);
				mooseModel: model;
				yourself
			).
		
	^fct
]

{ #category : 'visiting - expressions' }
FASTFortranTransformationVisitor >> visitFASTFortranIntegerLiteral: anIntegerLiteralNode [

	^ FASTFortran2kIntegerLiteral new
		  primitiveValue: anIntegerLiteralNode primitiveValue;
		  mooseModel: model;
		  yourself
]

{ #category : 'visiting' }
FASTFortranTransformationVisitor >> visitFASTFortranIntegerType: aFASTFortranIntegerType [

	^ FASTFortran2kIntegerType new
]

{ #category : 'visiting - helpers' }
FASTFortranTransformationVisitor >> visitFASTFortranList: list [

	^ list collect: [ :item | item accept: self ]
]

{ #category : 'visiting - expressions' }
FASTFortranTransformationVisitor >> visitFASTFortranLoopControlExpression: aLoopControlNode [

	^ FASTFortran2kLoopControlExpression new
		  init: (self accept: aLoopControlNode init);
		  limit: (self accept: aLoopControlNode limit);
		  increment: (self accept: aLoopControlNode increment);
		  mooseModel: model;
		  yourself
]

{ #category : 'visiting - statements' }
FASTFortranTransformationVisitor >> visitFASTFortranPrintStatement: aFASTFortranPrintStatement [

	^ FASTFortran2kPrintStatement new
		  format: (aFASTFortranPrintStatement format accept: self);
		  arguments:
			  (aFASTFortranPrintStatement arguments collect: [ :arg |
					   arg accept: self ]);
		  mooseModel: model;
		  yourself
]

{ #category : 'visiting - programUnits' }
FASTFortranTransformationVisitor >> visitFASTFortranProgramFile: aFASTFortranProgramFile [

	self flag: 'TODO aFASTFortranProgramFile comments'.

	aFASTFortranProgramFile programUnit do: [ :progUnit || visitor |
		visitor := self subVisitor: progUnit transformationVisitorClass.
		progUnit accept: visitor
	].

]

{ #category : 'visiting - programUnits' }
FASTFortranTransformationVisitor >> visitFASTFortranProgramMain: aProgramNode [

	| programMain |
	
	programMain := FASTFortran2kProgramMain new 
		name: aProgramNode name;
		mooseModel: model; 
		yourself.

	stack push: programMain.
	
	programMain statementBlock: (aProgramNode statementBlock accept: self).
	
	programMain statementBlock statements
		detect: [ :statement | statement class = FASTFortran2kImplicitStatement ]
		ifNone: [ programMain statementBlock statements addFirst: FASTFortran2kImplicitStatement new ].

	stack pop.
	^programMain
]

{ #category : 'visiting - expressions' }
FASTFortranTransformationVisitor >> visitFASTFortranRealLiteral: aRealLiteralNode [

	^ FASTFortran2kRealLiteral new
		  primitiveValue: aRealLiteralNode primitiveValue;
		  mooseModel: model;
		  yourself
]

{ #category : 'visiting' }
FASTFortranTransformationVisitor >> visitFASTFortranRealType: aRealTypeNode [

	^ FASTFortran2kRealType new
		  mooseModel: model;
		  yourself
]

{ #category : 'visiting - expressions' }
FASTFortranTransformationVisitor >> visitFASTFortranScalarVariable: aScalarVariableNode [

	^ FASTFortran2kScalarVariable new
		  name: aScalarVariableNode name;
		  mooseModel: model;
		  yourself
]

{ #category : 'visiting' }
FASTFortranTransformationVisitor >> visitFASTFortranSegment: aFASTFortranSegment [

	| module segmentName |
	segmentName := aFASTFortranSegment name.

	module := FASTFortran2kModule new name: segmentName , '_m'.
	module addProcedure: (self makeProcedureSegini2: aFASTFortranSegment).
	module procedures addAll:
		(self makeProceduresDimensions: aFASTFortranSegment).

	module statementBlock:
		(FASTFortran2kStatementBlock new statements: {
				 self makeSegmentModuleProlog.
				 (self makeTypeDefinition: aFASTFortranSegment).
				 (self makeSegmentTypeName: segmentName).
				 (self makeBoxedTypeDefinition: segmentName).
				 (self makeInterfaces: segmentName).
				 (self makeContainsStatement: segmentName).
				 (self makeProcedureIgnore: segmentName).
				 (self makeProcedureAssignPointerToPointer: segmentName).
				 (self makeProcedureSegmentType: segmentName).
				 (self makeProcedureSegcop: aFASTFortranSegment).
				 (self makeProcedureSegmov: aFASTFortranSegment).
				 (self makeProcedureSegadj: aFASTFortranSegment).
				 (self makeProcedureSegsup: aFASTFortranSegment).
				 (self makeProcedureSegprt: aFASTFortranSegment).
				 (self makeProcedureSegstore: aFASTFortranSegment).
				 (self makeProcedureSegload: aFASTFortranSegment).
				 (self makeProcedureSegpar: aFASTFortranSegment).
				 (self makeProcedureSeglik: aFASTFortranSegment).
				 (self makeProcedureSegloc: segmentName).
				 (self makeProcedureBoxed: segmentName) }).
	^ module
]

{ #category : 'visiting - statements' }
FASTFortranTransformationVisitor >> visitFASTFortranStatementBlock: aFASTFortranStatementBlock [

	| programUnit f2kStatementBlock |
	programUnit := stack top.
	f2kStatementBlock := FASTFortran2kStatementBlock new
		  mooseModel: model;
		  yourself.

	aFASTFortranStatementBlock statements
		do: [ :statement | | f2kStatement |
			f2kStatement := statement accept: self.

			statement class = FASTFortranFunctionStatement
				ifFalse: [ 
					f2kStatement isCollection
						ifTrue: [ f2kStatementBlock statements addAll: f2kStatement ]
						ifFalse: [  f2kStatementBlock addStatement: f2kStatement ]
					
				]
				ifTrue:  [ programUnit addInternalProcedure: f2kStatement ]
		].

	^f2kStatementBlock
]

{ #category : 'visiting - programUnits' }
FASTFortranTransformationVisitor >> visitFASTFortranSubroutine: aFASTFortranSubroutine [

	| subroutine |
	subroutine := FASTFortran2kSubroutine new
		name: aFASTFortranSubroutine name;
		mooseModel: model;
		yourself.
		
	stack push: subroutine.

	subroutine statementBlock: (aFASTFortranSubroutine statementBlock accept: self).
	
	stack pop.
	^subroutine.
]

{ #category : 'visiting - statements' }
FASTFortranTransformationVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	^ FASTFortran2kVariableDeclarationStatement new
		  type: (aFASTFortranVariableDeclarationStatement declaredType accept: self);
		  mooseModel: model;
		  yourself
]

{ #category : 'visiting - statements' }
FASTFortranTransformationVisitor >> visitFASTFortranVariableDeclarator: aFASTFortranVariableDeclarator [

	| varDeclarator |
	varDeclarator := FASTFortran2kVariableDeclarator new
		  name: aFASTFortranVariableDeclarator name;
		  yourself.
		
	varDeclarator dimensions:
		(self visitVariableDeclaratorDimensions: varDeclarator dimensions).

	^varDeclarator 
]

{ #category : 'visiting' }
FASTFortranTransformationVisitor >> visitFamixF77Type: aFamixF77Type [
	| aTypeClass |
	aTypeClass := {
		#real -> FASTFortran2kRealType.
		#integer -> FASTFortran2kIntegerType.
		#character -> FASTFortran2kCharacterType.
		#logical -> FASTFortran2kLogicalType.
	} asDictionary at: aFamixF77Type name.

	^aTypeClass new
		mooseModel: model;
		yourself.
]

{ #category : 'visiting - statements' }
FASTFortranTransformationVisitor >> visitSatementBlock: statementBlock [

	| statements |

	statements := self visitFASTFortranList: statementBlock statements.

	^ FASTFortran2kStatementBlock new statements: statements
]

{ #category : 'visiting' }
FASTFortranTransformationVisitor >> visitSegmentAttributes: attributes [

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

{ #category : 'visiting' }
FASTFortranTransformationVisitor >> visitSementAttributes: attributes [

	| generatedCode |
	self ensureEmptyStream.
	attributes do: [ :each |
		| parameters |

		self flag: #FIXME. "handle parameters in each declaractors dimensions"
		parameters := each declarators collect: #dimensions.

		parameters ifNotEmpty: [ 
 		tmpStream
			<<
			''	
			].
		].
	generatedCode := tmpStream contents.
	self ensureEmptyStream.
	^ generatedCode
]

{ #category : 'visiting - statements' }
FASTFortranTransformationVisitor >> visitVariableDeclaratorDimensions: variableDeclarationsDimensions [
	
	^variableDeclarationsDimensions
		collect: [ :dimension | 
			dimension accept: self
		]
]
