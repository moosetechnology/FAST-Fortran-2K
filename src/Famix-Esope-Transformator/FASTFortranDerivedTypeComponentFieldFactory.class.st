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
	"creates 2 statements:
	 - allocate(this%idata(idata_dim1(idim,jdim))
	 - this%idata(:) = segment_integer_default_value"

	| line1 line2 |
	line1 := String streamContents: [ :stream |
		stream
			<< 'allocate(this%' ;
			<< name ;
			<< '(' ;
			<< name ;
			<< '_dim' ;
			<< (self derivedTypeFactory components indexOf: self) asString ;
			<< '('.
			self derivedTypeFactory parameters
				do: [ :param | stream << param name]
				separatedBy: [ stream << ',' ].
			stream << '))'.
	].

	line2 := String streamContents: [ :stream |
		stream
			<< 'this%' ;
			<< self asFieldAccess ;
			<< ' = ' ;
			<< self asDefaultValue
	].

	^{
		self model newSourceCodeString content: line1 .
		self model newSourceCodeString content: line2 }
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

{ #category : 'accessing' }
FASTFortranDerivedTypeComponentFieldFactory >> type: declaredType [

	type := declaredType
]
