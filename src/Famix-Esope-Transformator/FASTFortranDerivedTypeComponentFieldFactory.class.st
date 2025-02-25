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

	^String streamContents: [ :stream |
		stream << name.
		(rank > 0)
			ifTrue: [
				stream << '(:'.
				2 to: rank do: [ :i | stream << ',:' ].
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

	| statements stmt |

	statements := OrderedCollection new: (rank + 2).

	statements addAll: self temporariesForDimInitialization.

	(rank > 0) ifTrue: [
		stmt := self  functionCall: 'allocate' arguments: {
			"creating the array access as a functioncall which is syntactically equivlent"
			self
				functionCall: ('this%' , name)
				arguments: ((1 to: rank) collect: [ :i | self scalarVariable: ('ooo_dim' , i asString) ])
		}.
		statements add: stmt
	].

	statements add: (self
		assignement: ('this%' , self asFieldAccess)
		value: (self scalarVariable: self asDefaultValue))
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

{ #category : 'accessing' }
FASTFortranDerivedTypeComponentFieldFactory >> type: declaredType [

	type := declaredType
]
