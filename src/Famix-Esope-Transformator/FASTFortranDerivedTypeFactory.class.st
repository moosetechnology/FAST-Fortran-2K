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
			FASTFortranDerivedTypeComponentFieldFactory new
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

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeCheckPostCondition: segcommand segmentName: segName parameters: parametersCollection [

	| checkPostCondition |
	checkPostCondition := model newCallStatement
		name: 'check_post_condition'.
	checkPostCondition addArgument: (model newFunctionCall
		name: 'associated' ;
		addArgument: (model newScalarVariable name: 'this') ).
	checkPostCondition addArgument: (model newCharacterLiteral primitiveValue: segName).
	checkPostCondition addArgument: (model newCharacterLiteral primitiveValue: 'associated(this)').

	^checkPostCondition
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

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeProcedureSegcop [

	| segcop thisParameter thatParameter paramFactories |

	paramFactories := fields collect: #isSegmentParameter.

	segcop := model newSubroutine
		name: name , '_segcop'.

	thisParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'this' ;
		derivedTypeFactory: self).
	thatParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'that' ;
		derivedTypeFactory: self).

	segcop addParameter: (model newScalarVariable name: 'this').
	segcop addParameter: (model newScalarVariable name: 'that').

	segcop initBody.
	segcop addComment: '## Copy "this" segment to a new "that" segment'.

	segcop addStatement: (thisParameter createSeginiFieldDeclaration).
	segcop addStatement: (thatParameter createSeginiFieldDeclaration).
	segcop addStatement: model newEmptyStatement.

	paramFactories do: [ :paramFactory |
		segcop addStatement: (paramFactory createSeginiFieldDeclaration)
	].
	segcop addStatement: model newEmptyStatement.

	segcop addStatement: (model newFormattedCodeString
		content: 'call check_pre_condition(associated(this), ''{1}_segcop'', ''associated(this)'')' ;
		value: { name } ).
	segcop addStatement: model newEmptyStatement.

	self makeSegCall: 'par' arguments: { thisParameter } , paramFactories.
	self makeSegCall: 'ini' arguments: { thatParameter } , paramFactories.
	self makeSegCall: 'mov' arguments: { thisParameter . thatParameter }.
	segcop addStatement: model newEmptyStatement.

	segcop addStatement: (model newFormattedCodeString
		content: 'call check_post_condition(associated(that), ''{1}_segcop'', ''associated(that)'')' ;
		value: { name } ).
	segcop addStatement: (model newFormattedCodeString
		content: 'call check_post_condition(.not. associated(this, that), ''{1}_segcop'', ''.not. associated(this, that)'')' ;
		value: { name } ).

]

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeProcedureSegini [

	| paramFactories componentFactories segini thisParameter |

	paramFactories := fields collect: #isSegmentParameter.
	componentFactories := fields reject: #isSegmentParameter.

	segini := model newSubroutine
		name: name , '_segini'.

	thisParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'this' ;
		derivedTypeFactory: self).

	segini addParameter: (model newScalarVariable name: 'this').
	paramFactories do: [ :param |
		segini addParameter: (model newScalarVariable name: param name)
	].

	segini initBody.
	segini addComment: '## Initialize a new "this" segment with default values'.
	segini addComment: '## using the given parameters'.
	
	segini addStatement: (thisParameter createSeginiFieldDeclaration).
	paramFactories do: [ :paramFactory |
		segini addStatement: (paramFactory createSeginiFieldDeclaration)
	].
	segini addStatement: model newEmptyStatement.

	segini addStatement: thisParameter createSeginiFieldInitialization.
	paramFactories do: [ :paramFactory |
		segini addStatement: paramFactory createSeginiFieldInitialization.
	].
	segini addStatement: model newEmptyStatement.

	componentFactories do: [ :compFact |
		segini addComment: ('-- this%' , compFact name).
		compFact createSeginiFieldInitialization do: [:stmt | segini addStatement: stmt ].
	].

	segini addStatement: (model newFormattedCodeString
		content: 'call check_pre_condition(associated(this), ''{1}_seg'', ''associated(this)'')' ;
		value: { name } ).
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

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeProcedureSegmov [

	| segmov thisParameter thatParameter if |

	segmov := model newSubroutine
		name: name , '_segmov'.

	thisParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'this' ;
		derivedTypeFactory: self).
	thatParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'that' ;
		derivedTypeFactory: self).

	segmov addParameter: (model newScalarVariable name: 'this').
	segmov addParameter: (model newScalarVariable name: 'that').

	segmov initBody.
	segmov addComment: '## Copy data from "this" segment to an existing "that" segment'.
	segmov addComment: '## "that" must have same dimensions than "this"'.

	segmov addStatement: (thisParameter createSeginiFieldDeclaration).
	segmov addStatement: (thatParameter createSeginiFieldDeclaration).
	segmov addStatement: model newEmptyStatement.

	segmov addStatement: (model newFormattedCodeString
		content: 'call check_pre_condition(associated(this), ''{1}_segmov'', ''associated(this)'')' ;
		value: { name } ).
	segmov addStatement: (model newFormattedCodeString
		content: 'call check_pre_condition(associated(that), ''{1}_segmov'', ''associated(that)'')' ;
		value: { name } ).
	segmov addStatement: (model newFormattedCodeString
		content: 'call check_pre_condition(seglik(this,that), ''{1}_segmov'', ''seglik(this,that)'')' ;
		value: { name } ).
	segmov addStatement: model newEmptyStatement.

	if := model newIfBlockStatement.
	if condition: (model newUnaryExpression
		operator: '.not.' ;
		expression: (model newFunctionCall
			name: 'associated' ;
			addArgument: (model newScalarVariable name: 'this') ;
			addArgument: (model newScalarVariable name: 'that')) ).
	if thenStatementBlock: (model newStatementBlock).
	(fields reject: #isSegmentParameter) do: [ :fieldFactory |
		if thenStatementBlock addStatement: (model newFormattedCodeString
			content: 'that%{1} := this%{1}' ;
			value: { fieldFactory asFieldAccess } )
	].
	segmov addStatement: if.
]

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeSegCall: segCommand arguments: arguments [

	| stmt |
	stmt := model newCallStatement
		name: (name , '_seg' , segCommand).

	arguments do: [ :arg |
		stmt addArgument: (model newScalarVariable
			name: arg name)
	].

	^stmt
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
	segment := model newDerivedTypeDefinition
		           name: name.

	fields do: [ :fieldFactory |
		fieldFactory createSegmentFieldDeclaration
			ifNotNil: [ :declStatement | segment addField: declStatement ]
		]

]

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> model [

	^model
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> model: anObject [

	model := anObject
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> name [

	^name
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> name: anObject [

	name := anObject
]
