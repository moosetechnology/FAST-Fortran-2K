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

	^self model newDerivedTypeComponent
		name: name ;
		rank: rank ;
		declaredType: (type accept: (FASTFortranBehavioralTransformationVisitor new parentTransformator: self))
]

{ #category : 'as yet unclassified' }
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
