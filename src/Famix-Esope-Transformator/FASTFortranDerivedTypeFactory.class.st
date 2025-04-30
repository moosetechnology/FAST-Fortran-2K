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

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> assignement: variable value: expression [

	| var |

	var := variable isMooseObject
		ifTrue: [ variable ]
		ifFalse: [ self scalarVariable: variable ].

	^model newAssignmentStatement
		variable: var ;
		expression: expression
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> comment: aString [

	^model newComment
		content: aString
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> components [

	^fields reject: #isSegmentParameter
]

{ #category : 'api' }
FASTFortranDerivedTypeFactory >> createModule [

	| module |
	module := model newModule name: name , '_mod'.

	module statementBlock:(
		model newStatementBlock statements: {
			self makeSegmentModuleProlog.
			self makeTypeDefinition .
			self makeSegmentTypeName .

			self makeBoxedTypeDefinition .
			self makeInterfaces
		}
	).

	module procedures addAll: (self makeProceduresFromDimensioningExpressions).
	
	module procedures addAll: {
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

			self makeProcedureBoxed 
	}.

	^module
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> declareMaxRankTemporaries: tempPrefix [

		^(1 to: self rankMax)
			collect: [ :i |
				self formattedCode: 'integer :: {1}{2}' values: {  tempPrefix . i asString }
			].
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> derivedTypeFieldAccessVariable: instanceName field: fieldName [

	^model newDerivedTypeComponentAccess
		instance: (self scalarVariable: instanceName);
		field: (self scalarVariable: fieldName)
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> do: condition body: statements [

	| do |
	do := model newDoStatement
		loopControl: condition ;
		body: model newStatementBlock.

	statements do: [ :stmt | do body addStatement: stmt ].

	^do

]

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> fields [

	^fields
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> fields: fastFortranDeclarations [

	fields := OrderedCollection new: fastFortranDeclarations size.

	fastFortranDeclarations do: [ :fastVariableDeclaration |
		fastVariableDeclaration declarators do: [ :fastVariableDeclarator |
			fields add: (FASTFortranDerivedTypeComponentFieldFactory new
				derivedTypeFactory: self ;
				type: fastVariableDeclaration declaredType ;
				fieldDeclarator: fastVariableDeclarator
			).

			(self getParameterFactories: fastVariableDeclarator dimensions)
				do: [ :paramFactory |  
					fields 
						detect: [ :factory | factory name = paramFactory name ]
						ifNone: [ fields add: paramFactory ]
				]
		]
	]
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> formattedCode: aString values: values [

	^values
		ifEmpty: [ model newSourceCodeString content: aString ]
		ifNotEmpty: [ model newFormattedCodeString content: aString ; values: values ]
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> functionCall: aString arguments: aCollection [ 

	^model newFunctionCall
		name: aString ;
		arguments: aCollection ;
		yourself
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> functionCallStatement: aString arguments: aCollection [ 

	^model newFunctionCallStatement
		name: aString ;
		arguments: aCollection ;
		yourself
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> getParameterFactories: fastFortranArrayRanges [
	"
	segment foo
	integer bar(N+1, M * N)
	end segment
	
	[foo]
    	parameters = N M

	[foo/bar]
    	type = integer
    	rank = 2
    	dim1 = N + 1
    	dim2 = M * N

	"

	^fastFortranArrayRanges flatCollect: [ :aFASTFortranArrayRange |
		(aFASTFortranArrayRange 
			accept: FASTFortranParameterExtractionVisitor new)
			collect: [ :paramName | 
				FASTFortranDerivedTypeParameterFieldFactory new
					derivedTypeFactory: self;
					name: paramName;
					yourself
			]
	]
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> if: condition then: statements [

	| if |
	if := model newIfBlockStatement
		condition: condition ;
		thenStatementBlock: model newStatementBlock.

	statements do: [ :stmt | if thenStatementBlock addStatement: stmt ].

	^if

]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> if: condition then: thenStatements else: elseStatements [

	| if |
	if := self if: condition then: thenStatements.
	
	if elseStatementBlock: model newStatementBlock.

	elseStatements do: [ :elseStatement |
		if elseStatementBlock addStatement: elseStatement
	].

	^if

]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> literal: anObject [

	(anObject = true) ifTrue: [ ^model newBooleanLiteral primitiveValue: '.true.' ].
	(anObject = false) ifTrue: [ ^model newBooleanLiteral primitiveValue: '.false.' ].

	(anObject isCharacter) ifTrue: [ ^model newCharacterLiteral primitiveValue: anObject asString ].
	(anObject isString) ifTrue: [ ^model newCharacterLiteral primitiveValue: anObject ].

	(anObject isInteger) ifTrue: [ ^model newIntegerLiteral primitiveValue: anObject asString ].

	(anObject isFloat) ifTrue: [ ^model newRealLiteral primitiveValue: anObject asString ].

	Error signal: 'Unknown literal: ' , anObject asString
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
		  content: 'contains
    ! ## primary aspects
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
' ;
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

	paramFactories := self parameters.
	componentFactories := self components.

	segadj := model newSubroutine
		name: name , '_segadj'.

	thisParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'this' ;
		derivedTypeFactory: self).

	segadj addParameter: (self scalarVariable: 'this').
	paramFactories do: [ :param |
		segadj addParameter: (self scalarVariable: param name)
	].

	segadj initBody.
	segadj addComment: '## Adjust the given "this" segment'.
	segadj addComment: '## using the given parameters'.

	segadj addStatement: (thisParameter createSegcmdInoutFieldDeclaration).

	paramFactories ifNotEmpty: [
		segadj statementBlock statements addAll: self makeSegadjLocalDeclarations ].

	segadj addStatement: (model newFormattedCodeString
		content: 'call check_pre_condition(associated(this), ''{1}_segadj'', ''associated(this)'')' ;
		values: { name } ).

	paramFactories ifNotEmpty: [
		segadj addStatement: model newEmptyStatement.
		segadj addStatement: self makeSegadjIfStatement.
	].

	^segadj

]

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeProcedureSegcop [

	| segcop thisParameter thatParameter paramFactories |

	paramFactories := self parameters.

	segcop := model newSubroutine
		name: name , '_segcop'.

	thisParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'this' ;
		derivedTypeFactory: self).
	thatParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'that' ;
		derivedTypeFactory: self).

	segcop addParameter: (self scalarVariable: 'this').
	segcop addParameter: (self scalarVariable: 'that').

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

	segcop addStatement: 
		(self makeSegCall: 'par' arguments: { thisParameter } , paramFactories).
	segcop addStatement: 
		(self makeSegCall: 'ini' arguments: { thatParameter } , paramFactories).
	segcop addStatement: 
		(self makeSegCall: 'mov' arguments: { thisParameter . thatParameter }).
	segcop addStatement: model newEmptyStatement.

	segcop addStatement: (model newFormattedCodeString
		content: 'call check_post_condition(associated(that), ''{1}_segcop'', ''associated(that)'')' ;
		values: { name } ).
	segcop addStatement: (model newFormattedCodeString
		content: 'call check_post_condition(.not. associated(this, that), ''{1}_segcop'', ''.not. associated(this, that)'')' ;
		values: { name } ).

	^segcop
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

	segini addParameter: (self scalarVariable: 'this').
	paramFactories do: [ :param |
		segini addParameter: (self scalarVariable: param name)
	].

	segini initBody.
	segini addComment: '## Initializes a new "this" segment with default values'.
	segini addComment: '## using the given parameters'.
	
	segini addStatement: (thisParameter createSegcmdInoutFieldDeclaration).
	paramFactories do: [ :paramFactory |
		segini addStatement: (paramFactory createSegcmdInFieldDeclaration)
	].
	segini addStatement: model newEmptyStatement.

	segini statementBlock statements addAll: (self declareMaxRankTemporaries: 'ooo_dim').
	segini addStatement: model newEmptyStatement.

	segini addStatement: thisParameter createSeginiFieldInitialization.
	segini addStatement: model newEmptyStatement.

	componentFactories do: [ :compFact |
		segini addComment: ('-- this%' , compFact name).
		compFact createSeginiFieldInitialization do: [:stmt | segini addStatement: stmt ].
	].

	segini addStatement: (model newFormattedCodeString
		content: 'call check_post_condition(associated(this), ''{1}_segini'', ''associated(this)'')' ;
		values: { name } ).

	^segini
]

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeProcedureSeglik [

	| seglik thisParameter thatParameter paramFactories elseStatements |

	paramFactories := self parameters.

	seglik := model newFunction
		name: name , '_seglik' ;
		declaredType: (model newLogicalType).

	thisParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'this' ;
		derivedTypeFactory: self).
	thatParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'that' ;
		derivedTypeFactory: self).

	seglik addParameter: (self scalarVariable: 'this').
	seglik addParameter: (self scalarVariable: 'that').

	seglik initBody.
	seglik addComment: '## Do "this" and "that" segments have the same dimensions ?'.

	seglik addStatement: (thisParameter createSegcmdInFieldDeclaration).
	seglik addStatement: (thatParameter createSegcmdInFieldDeclaration).
	seglik addStatement: model newEmptyStatement.

	seglik addStatement: (self assignement: (name , '_seglik') value: (self literal: false)).
	seglik addStatement: (model newIfLogicalStatement
		condition: (model newUnaryExpression
			operator: '.not.' ;
			expression: (self
				functionCall: 'associated'
				arguments: {  self scalarVariable: 'this' }));
		statement: model newReturnStatement).

	seglik addStatement: (model newIfLogicalStatement
		condition: (model newUnaryExpression
			operator: '.not.' ;
			expression: (self
				functionCall: 'associated'
				arguments: {  self scalarVariable: 'that' }));
		statement: model newReturnStatement).
	seglik addStatement: model newEmptyStatement.
	
	elseStatements := OrderedCollection new: self rankMax.
	
	elseStatements add: (self assignement: (name , '_seglik') value: (self literal: false)).
	elseStatements addAll: (
		paramFactories collect: [ :param |
			self assignement: (name , '_seglik') 
			value: (model newBinaryExpression 
				operator: '.and.' ;
				leftOperand: (self scalarVariable: (name , '_seglik')) ;
				rightOperand: (model newBinaryExpression 
						operator: '==';
						leftOperand: (self derivedTypeFieldAccessVariable: 'this' field: param name);
						rightOperand: (self derivedTypeFieldAccessVariable: 'that' field: param name)
					)
				)
		]
	).

	seglik addStatement: (self 
		if: (self 
			functionCall: 'associated' 
			arguments: { 
				self scalarVariable: 'this' .
				self scalarVariable: 'that'
			}
		) 
		then: { self assignement: (name , '_seglik') value: (self literal: true) }
		else: elseStatements
	).

	^seglik 
]

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeProcedureSegload [

	| paramFactories componentFactories segstore thisParameter seginiArguments |

	paramFactories := self parameters.
	componentFactories := self components.

	segstore := model newSubroutine
		name: name , '_seg_load'.

	thisParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'this' ;
		derivedTypeFactory: self).

	segstore addParameter: (self scalarVariable: 'this').
	segstore addParameter: (self scalarVariable: 'file_number').

	segstore initBody.
	segstore addComment: '## Get the given "this" segment on the file referenced by "file_number"'.
	
	segstore addStatement: (thisParameter createSegcmdInoutFieldDeclaration).
	segstore addStatement: (self formattedCode: 'integer, intent(in) :: file_number' values: #()).
	segstore addStatement: model newEmptyStatement.

	paramFactories do: [ :paramFactory |
		segstore addStatement: (paramFactory createSegcmdFieldDeclaration)
	].
	segstore statementBlock statements addAll: (self declareMaxRankTemporaries: 'ooo_i').
	segstore addStatement: model newEmptyStatement.

	paramFactories do: [ :param |
		segstore addStatement: (self
			formattedCode: 'read(file_number, *) {1}'
			values: { param name } ).
	].
	segstore addStatement: model newEmptyStatement.

	seginiArguments := OrderedCollection new: (self rankMax + 1).
	seginiArguments add: 'this'.
	paramFactories do: [ :param | seginiArguments add: param name ].
	segstore addStatement: (model newCallStatement
		name: 'segini' ;
		arguments: (seginiArguments collect: [ :arg | self scalarVariable: arg])).
	segstore addStatement: model newEmptyStatement.

	self components do: [ :comp | segstore statementBlock statements addAll: (comp makeSegloadDo) ].
	segstore addStatement: model newEmptyStatement.

	^segstore
]

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeProcedureSegloc [
	| segloc  thisParameter functionName |

	functionName := name , '_segloc'.

	segloc := model newFunction
		name: functionName;
		declaredType: (model newSpecialIntrinsicType name: 'int64').

	thisParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'this' ;
		derivedTypeFactory: self).

	segloc addParameter: (self scalarVariable: 'this').
	
	segloc initBody.
	segloc addComment: '## Return a location of the "this" pointer'.
	segloc addComment: '## just to trace pointers during debug,'.
	segloc addComment: '## should not be use for other purpose !!!'.
	segloc addStatement: model newEmptyStatement.

	segloc addStatement: (model newUseOnlyStatement 
		name: 'iso_fortran_env';
		modifiers: #( intrinsic );
		useNoRenames: { model newUseNoRename name: 'int64' }
	).
	segloc addStatement: (model newUseOnlyStatement 
		name: 'iso_c_binding';
		modifiers: #( intrinsic );
		useNoRenames: { model newUseNoRename name: 'c_loc' }
	).
	segloc addStatement: (thisParameter createSegcmdInFieldDeclaration).
	segloc addStatement: model newEmptyStatement.

	segloc addStatement: (self 
		assignement: functionName 
		value: (self 
			functionCall: 'transfer'
			arguments: {
				self functionCall: 'c_loc' arguments: { self scalarVariable: 'this' } .
				self scalarVariable: functionName 
			})
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

	segmov addParameter: (self scalarVariable: 'this').
	segmov addParameter: (self scalarVariable: 'that').

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
		expression: (self 
			functionCall: 'associated' 
			arguments: { 
				self scalarVariable: 'this' .
				self scalarVariable: 'that'  
			}
		)
	).
	if thenStatementBlock: (model newStatementBlock).
	self components do: [ :fieldFactory |
		if thenStatementBlock addStatement: (model newFormattedCodeString
			content: 'that%{1} = this%{1}' ;
			values: { fieldFactory asFieldAccess } )
	].
	segmov addStatement: if.

	^segmov
]

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeProcedureSegpar [

	| paramFactories componentFactories segpar thisParameter |

	paramFactories := self parameters.
	componentFactories := self components.

	segpar := model newSubroutine
		name: name , '_segpar'.

	thisParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'this' ;
		derivedTypeFactory: self).

	segpar addParameter: (self scalarVariable: 'this').
	paramFactories do: [ :param |
		segpar addParameter: (self scalarVariable: param name)
	].

	segpar initBody.
	segpar addComment: '## Return the parameters of the given "this" segment'.
	
	segpar addStatement: (thisParameter createSegcmdInFieldDeclaration).
	paramFactories do: [ :paramFactory |
		segpar addStatement: (paramFactory createSegcmdOutFieldDeclaration)
	].
	segpar addStatement: model newEmptyStatement.

	segpar addStatement: (model newFormattedCodeString
		content: 'call check_pre_condition(associated(this), ''{1}_segpar'', ''associated(this)'')' ;
		values: { name } ).
	segpar addStatement: model newEmptyStatement.

	paramFactories ifNotEmpty: [ 
		segpar addStatement: (
			self
				if: (self functionCall: 'associated' arguments: { self scalarVariable: 'this'})
				then: (paramFactories collect: [ :param |
					self assignement: param name value: (self derivedTypeFieldAccessVariable: 'this' field: param name)
				])
		)
	].

	^segpar
]

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeProcedureSegprt [

	| paramFactories componentFactories segprt thisParameter thenStatements |

	paramFactories := fields collect: #isSegmentParameter.
	componentFactories := fields reject: #isSegmentParameter.

	segprt := model newSubroutine
		name: name , '_segprt'.

	thisParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'this' ;
		derivedTypeFactory: self).

	segprt addParameter: (self scalarVariable: 'this').

	segprt initBody.
	segprt addComment: '## Print the given "this" segment'.
	
	segprt addStatement: (thisParameter createSegcmdInFieldDeclaration).
	segprt addStatement: model newEmptyStatement.

	1 to: self rankMax do: [ :i |
		segprt addStatement: (self formattedCode: ('character(len=64) :: ooo_text_i' , i asString) values: #()).
	].
	(self rankMax > 0)
		ifTrue: [ segprt addStatement: (self formattedCode: 'character(len=64) :: ooo_text_par' values: #() ) ].
	segprt addStatement: (self formattedCode: 'character(len=64) :: ooo_text_value' values: #() ).
	segprt statementBlock statements addAll: (self declareMaxRankTemporaries: 'ooo_i').
	segprt addStatement: model newEmptyStatement.

	segprt addStatement: (self
		formattedCode: 'call check_pre_condition(associated(this), ''{1}_segprt'', ''associated(this)'')'
		values: { name } ).
	segprt addStatement: model newEmptyStatement.

	thenStatements := OrderedCollection new.
	thenStatements add: (self formattedCode: 'write(*, ''(a)'') ''{1}_segprt:''' values: { name }).
	thenStatements add: model newEmptyStatement.

	self parameters do: [ :param |
		thenStatements add: (self formattedCode: 'write(ooo_text_par, *) this % {1}' values: {param name}).
		thenStatements add: (self formattedCode: 'write(*, ''(a)'') ''    {1} = '' //  trim(adjustl(ooo_text_par))' values: {param name}).
	].

	self components do: [ :comp |
		comp rank > 0 
			ifTrue: [ thenStatements addAll: comp makeSegprtDo  ]
			ifFalse: [ 
				thenStatements add: (self formattedCode: 'write(*, ''(1x)'')' values: #()).
				thenStatements add: (self formattedCode: 'write(ooo_text_value, *) this % {1}' values: {comp name}).
				thenStatements add: (self formattedCode: 'write(*, ''(a)'') ''    {1} = '' //  trim(adjustl(ooo_text_value))' values: {comp name}).
				thenStatements add: model newEmptyStatement.
			]		
	].

	segprt addStatement: (self
		if: (self functionCall: 'associated' arguments: { self scalarVariable: 'this' } )
		then: thenStatements).

	^segprt
]

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeProcedureSegstore [

	| paramFactories componentFactories segstore thisParameter |

	paramFactories := self parameters.
	componentFactories := self components.

	segstore := model newSubroutine
		name: name , '_seg_store'.

	thisParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'this' ;
		derivedTypeFactory: self).

	segstore addParameter: (self scalarVariable: 'this').
	segstore addParameter: (self scalarVariable: 'file_number').

	segstore initBody.
	segstore addComment: '## Put the given "this" segment on the file referenced by "file_number"'.
	
	segstore addStatement: (thisParameter createSegcmdInFieldDeclaration).
	segstore addStatement: (self formattedCode: 'integer, intent(in) :: file_number' values: #()).
	segstore addStatement: model newEmptyStatement.

	segstore statementBlock statements addAll: (self declareMaxRankTemporaries: 'ooo_i').
	segstore addStatement: model newEmptyStatement.

	segstore addStatement: (self
		formattedCode: 'call check_pre_condition(associated(this), ''{1}_seg_store'', ''associated(this)'')'
		values: { name } ).
	segstore addStatement: model newEmptyStatement.

	paramFactories do: [ :param |
		segstore addStatement: (self
			formattedCode: 'write(file_number, *) this % {1}'
			values: { param name } ).
	].
	segstore addStatement: model newEmptyStatement.

	componentFactories do: [ :comp | segstore statementBlock statements addAll: (comp makeSegstoreDo) ].
	segstore addStatement: model newEmptyStatement.

	^segstore
]

{ #category : 'helper-segCommands' }
FASTFortranDerivedTypeFactory >> makeProcedureSegsup [
	| segsup thisParameter ifAssociated |

	segsup := model newSubroutine
		name: name , '_segsup'.

	thisParameter := (FASTFortranDerivedTypeThisFieldFactory new
		name: 'this' ;
		derivedTypeFactory: self).

	segsup addParameter: (self scalarVariable: 'this').
	
	segsup initBody.
	segsup addComment: '## Deletes ("supprimer" in French) the given "this" segment'.

	segsup addStatement: (thisParameter createSegcmdInoutFieldDeclaration).
	segsup addStatement: model newEmptyStatement.

	ifAssociated := model newIfBlockStatement.
	ifAssociated condition: (self 
		functionCall: 'associated'
		arguments: { self scalarVariable: 'this' }
	).

	ifAssociated thenStatementBlock: (model newStatementBlock).
	self components do: [ :fieldFactory |
		fieldFactory makeDeallocateStatement
			ifNotNil: [ :deallocate | ifAssociated thenStatementBlock addStatement: deallocate ]
	].

	ifAssociated thenStatementBlock addStatement: (thisParameter makeDeallocateStatement).
	ifAssociated thenStatementBlock addStatement: (model newFunctionCallStatement
			name: 'nullify';
			addArgument: (self scalarVariable: 'this');
			yourself
	).
	segsup addStatement: ifAssociated.

	segsup addStatement: model newEmptyStatement.
	segsup addStatement: (model newFormattedCodeString
		content: 'call check_post_condition(.not. associated(this), ''{1}_segsup'', ''.not. associated(this)'')' ;
		values: { name } ).

	^segsup
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> makeProceduresFromDimensioningExpressions [
	
	| paramFactories componentFactories dimensioningExpressionsProcedures |

	paramFactories := self parameters.
	componentFactories := self components.

	dimensioningExpressionsProcedures := OrderedCollection new.
	
	dimensioningExpressionsProcedures add: (model newSourceCodeString
		  content: '! begin: the fields dimensions from the parameters').
	
	componentFactories do: [ :componentFactory |
		1 to: componentFactory rank do: [ :i | | aFunction aFunctionName |
			aFunctionName := componentFactory name, '_dim', i asString. 
			aFunction := model newFunction
				name: aFunctionName;
				declaredType: (model newIntegerType);
				yourself.
			
			paramFactories do: [ :param |
				aFunction addParameter: (self scalarVariable: param name)
			].

			aFunction initBody.
			
			paramFactories do: [ :paramFactory |
				aFunction addStatement: (paramFactory createSegcmdInFieldDeclaration)
			].
			aFunction addStatement: model newEmptyStatement.

			aFunction addStatement: (self
				assignement: aFunctionName 
				value: (componentFactory dimensioningExpressions at: i)
			).

			aFunction addStatement: (model newFormattedCodeString
				content: '    call check_post_condition({1} >= 0, ''{2}::{1}'', ''{1} >= 0'')

    if ( ignore_do_trace ) then
      call ignore({3}, ''{3}'', ''tlib::bstatu_dim1'')
    end if
' ;
				values: { aFunctionName . name . (paramFactories at: i) name}
			).

			dimensioningExpressionsProcedures add: aFunction
		]
	].

	dimensioningExpressionsProcedures add: (model newSourceCodeString
		  content: '! end: the fields dimensions from the parameters').

	^dimensioningExpressionsProcedures


]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> makeSegCall: segCommand arguments: arguments [

	| stmt |
	stmt := model newCallStatement
		name: (name , '_seg' , segCommand).

	arguments do: [ :arg |
		stmt addArgument: (self scalarVariable: arg name)
	].

	^stmt
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> makeSegadjCheckParamsChanged [

	| statements paramFactories |

	paramFactories := self parameters.
	statements := OrderedCollection new.
	
	statements add:
		(model newFormattedCodeString
			content: 'ooo_eq_pars = (this % {1} == {1})';
			values: { paramFactories first name }).

	paramFactories allButFirst do: [ :paramFactory |
		statements add: (model newFormattedCodeString
			content: 'ooo_eq_pars = ooo_eq_pars .and. (this % {1} == {1})';
			values: { paramFactory name })
	].

	statements add:
		(model newSourceCodeString content: 'if ( ooo_eq_pars ) return').

	statements add: model newEmptyStatement.

	^statements
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> makeSegadjIfStatement [

	| thenStatements |

	thenStatements := self makeSegadjCheckParamsChanged.

	thenStatements addAll: (self parameters collect: [ :paramFactory |
			paramFactory createSeginiFieldInitialization ]).
	thenStatements add: model newEmptyStatement.

	self components do: [ :compFactory|
		thenStatements addAll: compFactory makeSegadjIfStatement ].

	^self
		if: ( self 
			functionCall: 'associated' 
			arguments: {  self scalarVariable: 'this' }
		)
		then: thenStatements
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> makeSegadjLocalDeclarations [

		| statements |

	statements := OrderedCollection new.

	self parameters do: [ :paramFactory |
		statements add: (paramFactory createSegcmdInFieldDeclaration)
	].
	statements add: model newEmptyStatement.

	statements addAll: (self declareMaxRankTemporaries: 'ooo_dim').
	statements addAll: (self declareMaxRankTemporaries: 'ooo_stop').

	self components do: [ :componentFactory |
		statements add: componentFactory createSegadjTemporaryDeclaration
	].
	statements add: (model newSourceCodeString content: 'logical :: ooo_eq_dims').
	statements add: (model newSourceCodeString content: 'logical :: ooo_eq_pars').
	statements add: model newEmptyStatement.

	^statements
]

{ #category : 'helpers-codeString' }
FASTFortranDerivedTypeFactory >> makeSegmentModuleProlog [

	^model newSourceCodeString content: '
  use ignore_mod
  use contract_mod
  use segment_mod
  use str_mod

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
		modifiers: #( public );
		name: name.

	fields do: [ :fieldFactory |
		fieldFactory createSegmentFieldDeclaration
			ifNotNil: [ :declStatement | segment addStatement: declStatement ]
		].

	^segment

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

	^(self components collect: [ :component | component rank ] )
		ifEmpty: [ 0 ]
		ifNotEmpty: [ :collection | collection max ]
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFactory >> scalarVariable: variableName [

	^model newScalarVariable
		name: variableName
]
