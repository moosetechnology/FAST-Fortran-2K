Class {
	#name : 'FASTFortranUseTransformationVisitor',
	#superclass : 'FASTFortranAbstractTransformationVisitor',
	#instVars : [
		'parentTransformator'
	],
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'accessing' }
FASTFortranUseTransformationVisitor >> parentTransformator [

	^ parentTransformator
]

{ #category : 'accessing' }
FASTFortranUseTransformationVisitor >> parentTransformator: anObject [

	parentTransformator := anObject
]

{ #category : 'accessing' }
FASTFortranUseTransformationVisitor >> useNeeded: anAssociation [

	parentTransformator useNeeded: anAssociation 
]

{ #category : 'visiting' }
FASTFortranUseTransformationVisitor >> visitFASTEsopeIncludeStatement: aFASTEsopeIncludeStatement [ 

	| programUnit |
	programUnit := aFASTEsopeIncludeStatement famixInclude includedBy.
	
	aFASTEsopeIncludeStatement famixInclude included types
		ifNotNil: [ :types |
			types do: [ :type |
				self parentTransformator useNeeded:  programUnit -> type
			]
		]
	
]

{ #category : 'visiting' }
FASTFortranUseTransformationVisitor >> visitFASTEsopePointerDeclarationStatement: aFASTEsopePointerDeclarationStatement [

	self visitFASTFortranList: aFASTEsopePointerDeclarationStatement pointerDeclarators
	
]

{ #category : 'visiting' }
FASTFortranUseTransformationVisitor >> visitFASTEsopePointerDeclarator: aFASTEsopePointerDeclarator [ 
	
	| programUnit segment |
	programUnit := aFASTEsopePointerDeclarator pointerDeclarationStatement statementContainer fastBehaviouralParent famix.
	segment := aFASTEsopePointerDeclarator variableDeclarator famixDeclaration declaredType.

	self useNeeded: (programUnit -> segment)

]

{ #category : 'visiting' }
FASTFortranUseTransformationVisitor >> visitFASTEsopeSegCommand: aFASTEsopeSegCommand [

	aFASTEsopeSegCommand variables 
		do: [ :variable |  | programUnit segment |
			programUnit := variable famixVariable parentBehaviouralEntity.
			segment := variable famixVariable declaredType.

			self useNeeded: (programUnit -> segment)
		]
]

{ #category : 'visiting' }
FASTFortranUseTransformationVisitor >> visitFASTEsopeSegact: aFASTEsopeSegact [ 

	self visitFASTEsopeSegCommand: aFASTEsopeSegact
]

{ #category : 'visiting' }
FASTFortranUseTransformationVisitor >> visitFASTEsopeSegadj: aFASTEsopeSegadj [ 

	self visitFASTEsopeSegCommand: aFASTEsopeSegadj
]

{ #category : 'visiting' }
FASTFortranUseTransformationVisitor >> visitFASTEsopeSegdes: aFASTEsopeSegdes [ 

	self visitFASTEsopeSegCommand: aFASTEsopeSegdes
]

{ #category : 'visiting' }
FASTFortranUseTransformationVisitor >> visitFASTEsopeSegini: aFASTEsopeSegini [ 

	self visitFASTEsopeSegCommand: aFASTEsopeSegini
]

{ #category : 'visiting - expressions' }
FASTFortranUseTransformationVisitor >> visitFASTEsopeSegment: aFASTEsopeSegmentNode [

	self visitFASTFortranList: aFASTEsopeSegmentNode statements
]

{ #category : 'visiting' }
FASTFortranUseTransformationVisitor >> visitFASTEsopeSegprt: aFASTEsopeSegprt [ 

	self visitFASTEsopeSegCommand: aFASTEsopeSegprt
]

{ #category : 'visiting' }
FASTFortranUseTransformationVisitor >> visitFASTEsopeSegsup: aFASTEsopeSegsup [ 

	self visitFASTEsopeSegCommand: aFASTEsopeSegsup
]

{ #category : 'visiting - expressions' }
FASTFortranUseTransformationVisitor >> visitFASTFortranCallStatement: aFASTFortranCallStatement [

	|  caller called |

	caller := aFASTFortranCallStatement famix sender.
	called := aFASTFortranCallStatement famix candidates anyOne.

	(caller migratedModuleName = called migratedModuleName)
		ifFalse: [ self useNeeded: (caller -> called) ].

	super visitFASTFortranCallStatement: aFASTFortranCallStatement
]

{ #category : 'visiting' }
FASTFortranUseTransformationVisitor >> visitFASTFortranFieldAccess: aFASTFortranFieldAccess [ 
	|  pointer pointed |

	pointer := aFASTFortranFieldAccess pointer famixVariable parentBehaviouralEntity.
	pointed := aFASTFortranFieldAccess pointer famixVariable declaredType.
	
	self useNeeded: (pointer -> pointed)
]

{ #category : 'visiting - expressions' }
FASTFortranUseTransformationVisitor >> visitFASTFortranFunctionCall: aFASTFortranFunctionCall [

	| caller called |
	caller := aFASTFortranFunctionCall famix sender.
	called := aFASTFortranFunctionCall famix candidates anyOne.

	(caller migratedModuleName = called migratedModuleName)
		ifFalse: [ self useNeeded: (caller -> called) ].

	super visitFASTFortranFunctionCall: aFASTFortranFunctionCall
]
