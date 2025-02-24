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
