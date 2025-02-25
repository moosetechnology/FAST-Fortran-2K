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

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> components [

	^fields reject: #isSegmentParameter
]

{ #category : 'api' }
FASTFortranDerivedTypeFactory >> createModule [

	| module |
	module := model newModule name: name , '_mod'.

	module statementBlock:
		(model newStatementBlock statements: {
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
FASTFortranDerivedTypeFactory >> fields [

	^fields
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
    public boxed_{1}
    type, extends(segment) :: boxed_{1}
        type({1}), pointer, private :: this => null()
    contains
        procedure :: segsup => boxed_{1}_segsup
        procedure :: segcop => boxed_{1}_segcop
        procedure :: segmov => boxed_{1}_segmov
        procedure :: segprt => boxed_{1}_segprt
        procedure :: seg_store => boxed_{1}_seg_store
        procedure :: seg_type => boxed_{1}_seg_type
        final :: boxed_{1}_finalize
    end type boxed_{1} 
';
		  values: { name }
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeContainsStatement [

	^model newSourceCodeString
		  content: '
contains
	 ! ## primary aspects
    ! begin: the fields dimensions from the parameters
    ! end: the fields dimensions from the parameters

'
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeInterfaces [

	^model newFormattedCodeString
		  content: '
	 public assignment (=)
    interface assignment (=)
        module procedure {1}_assign_pointer_to_pointer
    end interface

    public seg_type
    interface seg_type
        module procedure {1}_seg_type
        module procedure boxed_{1}_seg_type
    end interface

    public segini
    interface segini
        module procedure {1}_segini
    end interface

    public segcop
    interface segcop
        module procedure {1}_segcop
        module procedure boxed_{1}_segcop
    end interface

    public segmov
    interface segmov
        module procedure {1}_segmov
        module procedure boxed_{1}_segmov
    end interface

    public segadj
    interface segadj
        module procedure {1}_segadj
    end interface

    public segsup
    interface segsup
        module procedure {1}_segsup
        module procedure boxed_{1}_segsup
    end interface

    public segprt
    interface segprt
        module procedure {1}_segprt
        module procedure boxed_{1}_segprt
    end interface

    public seg_store
    interface seg_store
        module procedure {1}_seg_store
        module procedure boxed_{1}_seg_store
    end interface

    public seg_load
    interface seg_load
        module procedure {1}_seg_load
    end interface

    public segpar
    interface segpar
        module procedure {1}_segpar
    end interface

    public seglik
    interface seglik
        module procedure {1}_seglik
    end interface

    public segloc
    interface segloc
        module procedure {1}_segloc
    end interface

    public ajpnt
    interface  ajpnt
        module procedure {1}_ajpnt
    end interface

    public getpnt
    interface  getpnt
        module procedure {1}_getpnt
    end interface

    public {1}_mypnt
    public {1}_load
';
		  values: { name }
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeProcedureAssignPointerToPointer [

	^model newFormattedCodeString
		  content: '
    subroutine {1}_assign_pointer_to_pointer(this, that)
        ! >> Just to detect at compile-time "this = that" bad usage, 
        ! >> instead of "this => that" good usage
        type({1}), pointer, intent(out) :: this
        type({1}), pointer, intent(in) :: that
        
        if ( ignore_do_trace ) then
            call ignore_{1}(this, ''this'', ''{1}_assign_pointer_to_pointer'')
            call ignore_{1}(that, ''that'', ''{1}_assign_pointer_to_pointer'')
        end if
        
        call check_post_condition(.false. , ''{1}_assign_pointer_to_pointer'', ''should not be called'')
    end subroutine {1}_assign_pointer_to_pointer
';
		  values: { name }
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeProcedureBoxed [

	^model newFormattedCodeString
		  content: '
    ! ## boxed aspects


    subroutine boxed_{1}_seg_type(this_segment, type_name)
        class(boxed_{1}), intent(in) :: this_segment
        character(len=segment_type_len), intent(out) :: type_name

        call {1}_seg_type(this_segment%this, type_name)
    end subroutine boxed_{1}_seg_type


    subroutine boxed_{1}_segsup(this_segment)
        class(boxed_{1}), intent(inout) :: this_segment

        call {1}_segsup(this_segment%this)
    end subroutine boxed_{1}_segsup


    subroutine boxed_{1}_finalize(this_segment)
        type(boxed_{1}), intent(inout) :: this_segment

        call {1}_segsup(this_segment%this)
    end subroutine boxed_{1}_finalize


    subroutine boxed_{1}_segprt(this_segment)
        class(boxed_{1}), intent(in) :: this_segment

        call {1}_segprt(this_segment%this)
    end subroutine boxed_{1}_segprt


    subroutine boxed_{1}_seg_store(this_segment, file_number)
        class(boxed_{1}), intent(in) :: this_segment
        integer, intent(in) :: file_number

        call {1}_seg_store(this_segment%this, file_number)
    end subroutine boxed_{1}_seg_store


    subroutine {1}_load(this_segment, file_number)
        class(segment), pointer, intent(inout) :: this_segment
        integer, intent(in) :: file_number

        type({1}), pointer :: this_{1}
        type(boxed_{1}), pointer :: this_boxed_{1}

        call {1}_seg_load(this_{1}, file_number)

        call new_boxed_{1}(this_boxed_{1}, this_{1})
        
        this_segment => this_boxed_{1}
        call check_post_condition(associated(this_segment), ''{1}_load'', ''associated(this_segment)'')
    end subroutine {1}_load


    subroutine boxed_{1}_segcop(this_segment, that_segment)
        ! >> The first and second be declared the same way !
        ! >> - The first (a.k.a. "passed" for dispatch) argument cannot be a pointer
        ! >>   and must be of the declared type
        ! >> - The second argument, polymorphic, must match the abstract interface
        class(boxed_{1}), intent(in) :: this_segment
        class(segment), pointer, intent(inout) :: that_segment

        type(boxed_{1}), pointer :: that_boxed_{1}
        type({1}), pointer :: that_{1}

        call check_pre_condition(.not. associated(that_segment), ''boxed_{1}_segcop'', ''.not. associated(that_segment)'')

        call {1}_segcop(this_segment%this, that_{1})
        call new_boxed_{1}(that_boxed_{1}, that_{1})

        that_segment => that_boxed_{1}
        call check_post_condition(associated(that_segment), ''boxed_{1}_segcop'', ''associated(that_segment)'')
    end subroutine boxed_{1}_segcop


    subroutine boxed_{1}_segmov(this_segment, that_segment)
        ! >> The first and second be declared the same way !
        ! >> - The first (a.k.a. "passed" for dispatch) argument cannot be a pointer
        ! >>   and must be of the declared type
        ! >> - The second argument, polymorphic, must match the abstract interface
        class(boxed_{1}), intent(in) :: this_segment
        class(segment), pointer, intent(inout) :: that_segment

        type(boxed_{1}), pointer :: that_boxed_{1}

        call check_pre_condition(associated(that_segment), ''boxed_{1}_segmov'', ''associated(that_segment)'')

        select type (that_segment)

            type is (boxed_{1})
                that_boxed_{1} => that_segment

            class default
                that_boxed_{1} => null()
                call check_pre_condition(.false., ''boxed_{1}_segmov'', ''type of that_segment is (boxed_{1})'')
        end select

        call {1}_segmov(this_segment%this, that_boxed_{1}%this)
    end subroutine boxed_{1}_segmov


    subroutine {1}_ajpnt(this, that_{1}, segment_type_name, wanted_position, position)
        type(str), pointer, intent(inout) :: this
        type({1}), pointer, intent(in)  :: that_{1}
        character(len=*), intent(in) :: segment_type_name
        integer, intent(in) :: wanted_position
        integer, intent(inout) :: position

        character(len=segment_type_len) :: segment_type_name_expected
        type(boxed_{1}), pointer :: that_boxed_{1}
        class(segment), pointer :: that_segment

        call check_pre_condition(associated(this), ''{1}_ajpnt'', ''associated(this)'')
        call check_pre_condition(associated(that_{1}), ''{1}_ajpnt'', ''associated(that_{1})'')
        call {1}_seg_type(that_{1}, segment_type_name_expected)
        call check_pre_condition(segment_type_name == segment_type_name_expected, ''{1}_ajpnt'', &
            ''segment_type_name == segment_type_name_expected'')

        call new_boxed_{1}(that_boxed_{1}, that_{1})
        
        that_segment => that_boxed_{1}
        
        call ajpnt(this, that_segment, segment_type_name, wanted_position, position)
    end subroutine {1}_ajpnt


    function {1}_mypnt(this, position) result(that_{1})
        type({1}), pointer :: that_{1}
        type(str), pointer, intent(in) :: this
        integer, intent(in) :: position
        
        call {1}_getpnt(this, that_{1}, position)
    end function {1}_mypnt


    subroutine {1}_getpnt(this, that_{1}, position)
        type(str), pointer, intent(in) :: this
        type({1}), pointer, intent(inout)  :: that_{1}
        integer, intent(in) :: position

        class(segment), pointer :: that_segment
        type(boxed_{1}), pointer :: that_boxed_{1}

        call check_pre_condition(associated(this), ''{1}_getpnt'', ''associated(this)'')

        that_{1} => null()

        call getpnt(this, that_segment, position)

        if ( associated(that_segment) ) then
            select type (that_segment)

                type is (boxed_{1})
                    that_boxed_{1} => that_segment
                    that_{1} => that_boxed_{1}%this

                class default
                    that_{1} => null()
                    call check_pre_condition(.false., ''{1}_getpnt'', ''type of that_segment is (boxed_{1})'')
            end select
        end if
    end subroutine {1}_getpnt


    subroutine new_boxed_{1}(this_boxed_{1}, this_{1})
        type(boxed_{1}), pointer, intent(inout) :: this_boxed_{1}
        type({1}), pointer, intent(in) :: this_{1}

        allocate(this_boxed_{1})
        this_boxed_{1}%this => this_{1}
    end subroutine new_boxed_{1}
';
		  values: { name }
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeProcedureIgnore [

	^model newFormattedCodeString
		  content: '
    subroutine ignore_{1}(variable, variable_name, routine)
        use, intrinsic :: iso_fortran_env, only : int64
        use, intrinsic :: iso_c_binding, only : c_loc

        type({1}), pointer, intent(in) :: variable
        character(len=*), intent(in) :: variable_name
        character(len=*), intent(in) :: routine

        integer(int64) :: variable_loc
                
        if ( ignore_do_trace ) then
            call ignore_type(''{1}'', variable_name, routine)
            
            if ( ignore_get_false(0) ) then
                variable_loc = transfer(c_loc(variable), variable_loc)
                write(*,*) ''ignore: variable_loc ='', variable_loc
            end if 
        end if
    end subroutine ignore_{1}
';
		  values: { name }
]

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeProcedureSegadj [

	| paramFactories componentFactories segadj thisParameter |

	paramFactories := fields collect: #isSegmentParameter.
	componentFactories := fields reject: #isSegmentParameter.

	segadj := model newSubroutine
		name: name , '_segadj'.

	thisParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'this' ;
		derivedTypeFactory: self).

	segadj addParameter: (model newScalarVariable name: 'this').
	paramFactories do: [ :param |
		segadj addParameter: (model newScalarVariable name: param name)
	].

	segadj initBody.
	segadj addComment: '## Adjust the given "this" segment'.
	segadj addComment: '## using the given parameters'.
	
	segadj addStatement: (thisParameter createSegcmdInoutFieldDeclaration).
	paramFactories do: [ :paramFactory |
		segadj addStatement: (paramFactory createSegcmdInFieldDeclaration)
	].
	segadj addStatement: model newEmptyStatement.

	segadj addStatement: thisParameter createSeginiFieldInitialization.
	paramFactories do: [ :paramFactory |
		segadj addStatement: paramFactory createSeginiFieldInitialization.
	].
	segadj addStatement: model newEmptyStatement.

	1 to: self rankMax do: [ :i |
		segadj addStatement: (model newSourceCodeString content: ('integer :: ooo_dim' , i asString ))
	].
	1 to: self rankMax do: [ :i |
		segadj addStatement: (model newSourceCodeString content: ('integer :: ooo_stop' , i asString ))
	].

	self components do: [ :componentFactory |
		segadj addStatement: componentFactory createSegadjTemporaryDeclaration
	].
	segadj addStatement: (model newSourceCodeString content: 'logical :: ooo_eq_dims').
	segadj addStatement: (model newSourceCodeString content: 'logical :: ooo_eq_pars').
	segadj addStatement: model newEmptyStatement.

	segadj addStatement: (model newFormattedCodeString
		content: 'call check_pre_condition(associated(this), ''{1}_segadj'', ''associated(this)'')' ;
		values: { name } ).
	segadj addStatement: model newEmptyStatement.

	segadj addStatement: self makeSegadjIfStatement.

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

	segcop addStatement: (thisParameter createSegcmdInFieldDeclaration).
	segcop addStatement: (thatParameter createSegcmdInoutFieldDeclaration).
	segcop addStatement: model newEmptyStatement.

	paramFactories do: [ :paramFactory |
		segcop addStatement: (paramFactory createSegcmdFieldDeclaration)
	].
	segcop addStatement: model newEmptyStatement.

	segcop addStatement: (model newFormattedCodeString
		content: 'call check_pre_condition(associated(this), ''{1}_segcop'', ''associated(this)'')' ;
		values: { name } ).
	segcop addStatement: model newEmptyStatement.

	self makeSegCall: 'par' arguments: { thisParameter } , paramFactories.
	self makeSegCall: 'ini' arguments: { thatParameter } , paramFactories.
	self makeSegCall: 'mov' arguments: { thisParameter . thatParameter }.
	segcop addStatement: model newEmptyStatement.

	segcop addStatement: (model newFormattedCodeString
		content: 'call check_post_condition(associated(that), ''{1}_segcop'', ''associated(that)'')' ;
		values: { name } ).
	segcop addStatement: (model newFormattedCodeString
		content: 'call check_post_condition(.not. associated(this, that), ''{1}_segcop'', ''.not. associated(this, that)'')' ;
		values: { name } ).

]

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeProcedureSegini [

	| paramFactories componentFactories segini thisParameter |

	paramFactories := self parameters.
	componentFactories := self components.

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
	
	segini addStatement: (thisParameter createSegcmdInoutFieldDeclaration).
	paramFactories do: [ :paramFactory |
		segini addStatement: (paramFactory createSegcmdInFieldDeclaration)
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
		content: 'call check_pre_condition(associated(this), ''{1}_segini'', ''associated(this)'')' ;
		values: { name } ).
]

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeProcedureSegloc [
	| segloc  |

	segloc := model newFunction
		name: name , '_segloc'.
	
	segloc initBody.

	segloc addStatement: (model newFormattedCodeString 
		content: '
        ! ## Return a location of the "this" pointer
        ! ## just to trace pointers during debug,
        ! ## should not be use for other purpose !!!

        use, intrinsic :: iso_fortran_env, only : int64
        use, intrinsic :: iso_c_binding, only : c_loc

        type(bar), pointer, intent(in) :: this
        integer(int64) :: this_loc

        this_loc = transfer(c_loc(this), this_loc)
		';
		values: { name }
	).

	^segloc
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeProcedureSegmentType [

	^model newFormattedCodeString
		  content: '
    subroutine {1}_seg_type(this, type_name)
        ! ## Return the name of the segment type
        type({1}), pointer, intent(in) :: this
        character(len=segment_type_len), intent(out) :: type_name

        type_name = {1}_type_name

        if ( ignore_do_trace ) then
            call ignore_{1}(this, ''this'', ''{1}_seg_type'')
        end if
    end subroutine {1}_seg_type
';
		  values: { name }
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

	segmov addStatement: (thisParameter createSegcmdInFieldDeclaration).
	segmov addStatement: (thatParameter createSegcmdInoutFieldDeclaration).
	segmov addStatement: model newEmptyStatement.

	segmov addStatement: (model newFormattedCodeString
		content: 'call check_pre_condition(associated(this), ''{1}_segmov'', ''associated(this)'')' ;
		values: { name } ).
	segmov addStatement: (model newFormattedCodeString
		content: 'call check_pre_condition(associated(that), ''{1}_segmov'', ''associated(that)'')' ;
		values: { name } ).
	segmov addStatement: (model newFormattedCodeString
		content: 'call check_pre_condition(seglik(this,that), ''{1}_segmov'', ''seglik(this,that)'')' ;
		values: { name } ).
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
			values: { fieldFactory asFieldAccess } )
	].
	segmov addStatement: if.
]

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeProcedureSegsup [
	| segsup thisParameter if |

	segsup := model newSubroutine
		name: name , '_segsup'.

	thisParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'this' ;
		derivedTypeFactory: self).

	segsup addParameter: (model newScalarVariable name: 'this').
	
	segsup initBody.
	segsup addComment: '## Delete ("supprimer" in French) the given "this" segment'.

	segsup addStatement: (thisParameter createSeginiFieldDeclaration).
	segsup addStatement: model newEmptyStatement.

	if := model newIfBlockStatement new.
	if condition: (model newFunctionCall
		name: 'associated';
		addArgument: (model newScalarVariable name: 'this');
		yourself
	).
	if thenStatementBlock: (model newStatementBlock).
	self components do: [ :fieldFactory |
		if thenStatementBlock addStatement: (model newFormattedCodeString
			content: 'deallocate(this%{1})' ;
			values: { fieldFactory name } )
	].
	
	if thenStatementBlock addStatement: (model newFunctionCallStatement
			name: 'deallocate';
			addArgument: (model newScalarVariable name: 'this');
			yourself
	).
	if thenStatementBlock addStatement: (model newFunctionCallStatement
			name: 'nullify';
			addArgument: (model newScalarVariable name: 'this');
			yourself
	).
	segsup addStatement: if.

	^segsup
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

    public {1}_type_name
    character(len=segment_type_len), parameter :: {1}_type_name = ''{1}''
';
		  values: { name }
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeTypeDefinition [

	| segment |
	segment := model newDerivedTypeDefinition
		           name: name.

	fields do: [ :fieldFactory |
		fieldFactory createSegmentFieldDeclaration
			ifNotNil: [ :declStatement | segment addStatement: declStatement ]
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

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> parameters [

	^fields select: #isSegmentParameter
]

{ #category : 'accessing - private tests' }
FASTFortranDerivedTypeFactory >> privateFields: componentFactories [

	fields := componentFactories 
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> rankMax [

	^(self components collect: #rank)
		ifEmpty: [ 0 ]
		ifNotEmpty: [ :collection | collection max ]
]
