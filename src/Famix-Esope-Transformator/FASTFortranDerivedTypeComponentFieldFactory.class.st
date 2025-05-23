Class {
	#name : 'FASTFortranDerivedTypeComponentFieldFactory',
	#superclass : 'FASTFortranDerivedTypeFieldFactory',
	#instVars : [
		'type',
		'rank',
		'dimensioningExpressions'
	],
	#category : 'Famix-Esope-Transformator-Segment',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Segment'
}

{ #category : 'converting' }
FASTFortranDerivedTypeComponentFieldFactory >> asDefaultValue [

	^'segment_' , type name , '_default_value'
]

{ #category : 'converting' }
FASTFortranDerivedTypeComponentFieldFactory >> asFieldAccess [

	 "self 
		deprecated: 'Please use #asFieldAccess: '''' instead'
      transformWith: '`@receiver asFieldAccess' -> '`@receiver asFieldAccess:'''''. "

	^self asFieldAccess: ''
]

{ #category : 'converting' }
FASTFortranDerivedTypeComponentFieldFactory >> asFieldAccess: slicingLimitName [

	^String streamContents: [ :stream | 
		stream << name.
		(rank > 0)
			ifTrue: [
				stream << '(:'.
				slicingLimitName 
					ifNotEmpty: [ 
						stream 
							<< slicingLimitName;
							<< '1'
					].
				2 to: rank do: [ :i | 
					stream << ', :'.
					slicingLimitName 
					ifNotEmpty: [ 
						stream 
							<< slicingLimitName;
							<< (i asString)
					]
				].
				stream << ')'
			]
	]
]

{ #category : 'converting' }
FASTFortranDerivedTypeComponentFieldFactory >> asVariableDeclaration [

	| stmt declarator modifiers declaredType initValue |

	declaredType := (type accept: (FASTFortranBehavioralTransformationVisitor new 
		model2k: self model )).

	stmt := self model newVariableDeclarationStatement.
	stmt declaredType: declaredType.

	declarator := self model newVariableDeclarator.
	declarator name: name.

	(rank > 0)
		ifTrue: [
			modifiers := #( pointer ).
			1 to: rank do: [ :i | declarator addDimension: self model newArrayRange ].

			initValue := ( self model newFunctionCall
				name: 'null' ;
				arguments: #()
			)
		]
		ifFalse: [ 
			modifiers := #().
			initValue := declaredType initialValue
		].

	declarator expression: initValue.

	stmt
		addDeclarator: declarator ;
		modifiers: modifiers.

	^stmt
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> checkIfDimExtendable: iDim [

	^self model newBinaryExpression
		leftOperand: ( 
			self functionCall: 'size'
				arguments: { 
					(self derivedTypeFieldAccessVariable: 'this' field: name) .
					self model newIntegerLiteral primitiveValue: iDim
				}
		) ;

		operator: '==' ;

		rightOperand: (self scalarVariable: ('ooo_dim', iDim asString))
				
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> createSegadjTemporaryDeclaration [

	| stmt |
	stmt := self asVariableDeclaration.
	stmt declarators anyOne name: ('ooo_' , name).

	^stmt
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> createSeginiFieldInitialization [

	| statements |

	statements := OrderedCollection new: (rank + 2).

	statements addAll: self temporariesForDimInitialization.

	(rank > 0) ifTrue: [
		statements add: (self 
			makeAllocationCallForDimensionnedField: ('this % ' , name) 
			with: 'ooo_dim'
		)
	].

	statements add: (self
		assignement: (self
			derivedTypeFieldAccessVariable: 'this'
			field: self asFieldAccess)
		value: (self scalarVariable: self asDefaultValue)).

	^statements
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> createSegmentFieldDeclaration [

	| stmt |
	stmt := self asVariableDeclaration.
	^stmt
		modifiers: ( stmt modifiers , #( public ) ) ;
		yourself.
]

{ #category : 'accessing' }
FASTFortranDerivedTypeComponentFieldFactory >> dimensioningExpressions [

	^ dimensioningExpressions ifNil: [ dimensioningExpressions := OrderedCollection new  ]
]

{ #category : 'accessing' }
FASTFortranDerivedTypeComponentFieldFactory >> fieldDeclarator: aFastFortranVariableDeclarator [

	name := aFastFortranVariableDeclarator name.
	rank := aFastFortranVariableDeclarator dimensions size.
	dimensioningExpressions := (aFastFortranVariableDeclarator dimensions 
		select: [ :arrayRange | arrayRange upperBound isNotNil ]
		thenCollect: [ :arrayRange |
			arrayRange upperBound accept: (FASTFortranBehavioralTransformationVisitor new
				model2k: self model
			)
	])
]

{ #category : 'testing' }
FASTFortranDerivedTypeComponentFieldFactory >> isAllocatable [

	| result |
	result := type class = FASTEsopeSegment.

	^rank 
		ifNotNil: [ result or: [ rank > 0 ] ]
		ifNil: [ result ]
]

{ #category : 'accessing' }
FASTFortranDerivedTypeComponentFieldFactory >> isSegmentParameter [

	^false
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> makeAllocationCallForDimensionnedField: fieldName with: prefix [
	"creating the array access (to fieldName) as a functionCall which is
	 syntactically equivalent"

	^self functionCallStatement: 'allocate' arguments: {
		self
			functionCall: fieldName
			arguments: ((1 to: rank) collect: [ :i | self scalarVariable: (prefix , i asString) ])
	}
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> makeSegadjIfStatement [ 

	| ifAdjuster statements adjusterStatements |

	(rank > 0) ifFalse: [ ^#() ].

	statements := OrderedCollection new.
	
	statements add: (self comment: ('-- this%' , name)).
	statements addAll: self temporariesForDimInitialization.
	statements addAll: self temporariesForDimCheckIfExtendableInitialization.

	adjusterStatements := OrderedCollection new.
	adjusterStatements add: (self 
		makeAllocationCallForDimensionnedField: ('ooo_' , name) 
		with: 'ooo_dim').
	adjusterStatements add: (self
		assignement: ('ooo_' , self asFieldAccess)
		value: (self scalarVariable: self asDefaultValue)).
	adjusterStatements add: self model newEmptyStatement.
	adjusterStatements addAll: self temporariesForStopDimInitialization.
	adjusterStatements add: (self
		assignement: ('ooo_' , (self asFieldAccess: 'ooo_stop'))
		value: (self scalarVariable: ('this % ' , (self asFieldAccess: 'ooo_stop')))).
	adjusterStatements add: self model newEmptyStatement.

	adjusterStatements add: (self 
		functionCallStatement: 'deallocate' 
		arguments: { self derivedTypeFieldAccessVariable: 'this' field: name }
	).
	adjusterStatements add: (self model newPointerAssignmentStatement
		variable: (self derivedTypeFieldAccessVariable: 'this' field: name);
		expression: (self scalarVariable: ('ooo_', name))).

	ifAdjuster := self
		if: (self model newUnaryExpression 
			operator: '.not.';
			expression: (self scalarVariable: 'ooo_eq_dims') 	)
			then: adjusterStatements.

	statements add: ifAdjuster.

	^statements
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> makeSegloadDo [

	| statements formatSpecification |
	statements := OrderedCollection new.
	formatSpecification := type ioDefaultFormatForRead.

	statements add: (self comment: ('-- this%' , name)).

	(rank > 0)
		ifTrue: [ statements add: (self
			nestedDoLoops: 1
			of: rank
			allLoops: nil
			finalLoop: {self formattedCode: 'read(file_number, {3}) this % {1}({2})' values: { name . self temporariesAsArguments . formatSpecification } })
		]
		ifFalse: [ 
			statements add: (self formattedCode: 'read(file_number, {2}) this % {1}' values: { name . formatSpecification })
		].

	^statements
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> makeSegprtDo [

	| statements |
	statements := OrderedCollection new.


	statements add: (self comment: ('-- this%' , name)).
	statements add: (self formattedCode: 'write(*, ''(1x)'')' values: #()).

	(rank > 0)
		ifTrue: [ statements add: (self
			nestedDoLoops: 1
			of: rank
			allLoops: 'write(ooo_text_i{1}, *) ooo_i{1}'
			finalLoop: {
				self model newEmptyStatement .
				self formattedCode: 'write(ooo_text_value, *) this % {1}({2})' values: { name . self temporariesAsArguments } .
				self formattedCode: self makeSegprtDoFinalWrite values: #()
			})
		].

	^statements		
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> makeSegprtDoFinalWrite [

	^String streamContents: [ :str |
				str << 'write(*, ''(a)'') ''    ' ;
				<< name ;
				<< '('' &' ;
				cr.
				(1 to: rank)
					do: [ :i |
						str
							<< '    // trim(adjustl(ooo_text_i' ;
							<< i asString ;
							<< ')) // '''
					]
					separatedBy: [ str << ','' &' ; cr ].
				str
					<< ') = '' &' ;
					cr ;
					<< '    // trim(adjustl(ooo_text_value))'
			].
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> makeSegstoreDo [

	| statements formatSpecification |
	statements := OrderedCollection new.
	formatSpecification := type ioDefaultFormatForWrite.

	statements add: (self comment: ('-- this%' , name)).
	(rank > 0)
		ifTrue: [ statements add: (self
			nestedDoLoops: 1
			of: rank
			allLoops: nil
			finalLoop: {self formattedCode: 'write(file_number, {3}) this % {1}({2})' values: { name . self temporariesAsArguments . formatSpecification }})
		]
		ifFalse: [ 
			statements add: (self formattedCode: 'write(file_number, {2}) this % {1}' values: { name . formatSpecification })
		].

	^statements
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> nestedDoLoops: dim of: maxDim allLoops: allLoopsFormattedCode finalLoop: finalLoopStatements [

	| loopControl statements |

	loopControl := self model newLoopControlExpression.
	loopControl init: (self model newAssignmentExpression
		variable: (self scalarVariable: ('ooo_i' , dim asString)) ;
		expression: (self literal: 1) ).
	loopControl
		limit: (self
			functionCall: 'size'
			arguments: {
				self derivedTypeFieldAccessVariable: 'this' field: name .
				self literal: 1
			}).

	statements := OrderedCollection new.

	allLoopsFormattedCode
				ifNotNil: [ statements add: (self formattedCode: allLoopsFormattedCode values: { dim }) ].

	(dim = maxDim)
		ifTrue: [ statements addAll: finalLoopStatements ]
		ifFalse: [
			self nestedDoLoops: (dim+1) of: maxDim allLoops: allLoopsFormattedCode finalLoop: finalLoopStatements
		].

	^self do: loopControl body: statements 

]

{ #category : 'accessing - private tests' }
FASTFortranDerivedTypeComponentFieldFactory >> privateRank: anInt [

	rank := anInt 
]

{ #category : 'accessing' }
FASTFortranDerivedTypeComponentFieldFactory >> rank [

	^rank
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> temporariesAsArguments [

	^String streamContents: [ :str |
		(1 to: rank)
			do: [ :i |
				str
					<< 'ooo_i' ;
					<< i asString
			]
			separatedBy: [ str << ',' ]
	]
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> temporariesForDimCheckIfExtendableInitialization [

	| statements |

	statements := OrderedCollection new: rank.

	statements add: (self
		assignement: 'ooo_eq_dims'
		value: (self checkIfDimExtendable: 1) ).

	statements addAll: ((2 to: rank) collect: [ :iDim |
		self
			assignement: 'ooo_eq_dims'
			value: (self model newBinaryExpression
				leftOperand: (self scalarVariable: 'ooo_eq_dims') ;
				operator: '.and.' ;
				rightOperand: (self checkIfDimExtendable: iDim)
			)
	]).

	^statements
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> temporariesForDimInitialization [

	^(1 to: rank) collect: [ :i |
		self
			assignement: ('ooo_dim' , i asString)
			value: (self
				functionCall: (name , '_dim' , i asString)
				arguments: (self privateDerivedTypeFactory parameters
					collect: [ :param | self scalarVariable: param name]))
	].

]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> temporariesForStopDimInitialization [

	^(1 to: rank) collect: [ :i |
		self
			assignement: ('ooo_stop', i asString)
			value: (self functionCall: 'min'
				arguments: {
					self 
						functionCall: 'size'
						arguments: { 
							self scalarVariable: ('ooo_', name).
							self model newIntegerLiteral primitiveValue: i
						}
					.
					self 
						functionCall: 'size'
						arguments: { 
							(self derivedTypeFieldAccessVariable: 'this' field: name) .
							self model newIntegerLiteral primitiveValue: i
						}
				}
			)
	]

]

{ #category : 'accessing' }
FASTFortranDerivedTypeComponentFieldFactory >> type: declaredType [

	type := declaredType
]
