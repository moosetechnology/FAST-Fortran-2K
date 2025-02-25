Class {
	#name : 'FASTFortranDerivedTypeComponentFieldFactory',
	#superclass : 'FASTFortranDerivedTypeFieldFactory',
	#instVars : [
		'type'
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

	| stmt declarator |
	stmt := self model newVariableDeclarationStatement.
	stmt declaredType: (type accept: (FASTFortranBehavioralTransformationVisitor new parentTransformator: self)).

	declarator := self model newVariableDeclarator.
	declarator name: name.
	1 to: rank do: [ :i | declarator addDimension: self model newArrayRange ].

	stmt addDeclarator: declarator.

	^stmt
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> createSegadjTemporaryDeclaration [

	| stmt |
	stmt := self asVariableDeclaration.
	stmt modifiers: #( pointer ).
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
			makeAllocationCallForDimensionnedField: ('this%' , name) 
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

	^self asVariableDeclaration
		modifiers: #( public ) ;
		yourself.
]

{ #category : 'accessing' }
FASTFortranDerivedTypeComponentFieldFactory >> fieldDeclarator: aFastFortranVariableDeclarator [

	name := aFastFortranVariableDeclarator name.
	rank := aFastFortranVariableDeclarator dimensions size.
]

{ #category : 'accessing' }
FASTFortranDerivedTypeComponentFieldFactory >> isSegmentParameter [

	^false
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> makeAllocationCallForDimensionnedField: fieldName with: prefix [

	^self functionCall: 'allocate' arguments: {
		"creating the array access as a functioncall which is syntactically equivlent"
		self
			functionCall: fieldName
			arguments: ((1 to: rank) collect: [ :i | self scalarVariable: (prefix , i asString) ])
	}
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> temporariesForDimCheckIfExtendableInitialization [

	^(1 to: rank) collect: [ :i |
		self
			assignement: ('ooo_eq_dims')
			value: (self model newBinaryExpression
				operator: '.and.';
				leftOperand: (self scalarVariable: 'ooo_eq_dims');
				rightOperand: (self model newBinaryExpression
					operator: '==';
					leftOperand: ( 
						self functionCall: 'size'
							arguments: { 
								(self derivedTypeFieldAccessVariable: 'this' field: name) .
								self model newIntegerLiteral primitiveValue: i
							}
					);
					rightOperand: (self scalarVariable: ('ooo_dim', i asString))
				)
			)
	]

]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeComponentFieldFactory >> temporariesForDimInitialization [

	^(1 to: rank) collect: [ :i |
		self
			assignement: ('ooo_dim' , i asString)
			value: (self
				functionCall: (name , '_dim' , i asString)
				arguments: (self derivedTypeFactory parameters
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
							self scalarVariable: ('oo_', name).
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
