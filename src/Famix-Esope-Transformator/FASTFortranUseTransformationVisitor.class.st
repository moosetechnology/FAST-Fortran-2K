Class {
	#name : 'FASTFortranUseTransformationVisitor',
	#superclass : 'FASTFortranAbstractTransformationVisitor',
	#instVars : [
		'parentTransformator'
	],
	#category : 'Famix-Esope-Transformator',
	#package : 'Famix-Esope-Transformator'
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

{ #category : 'visiting - expressions' }
FASTFortranUseTransformationVisitor >> visitFASTEsopeSegment: aFASTEsopeSegmentNode [

	self visitFASTFortranList: aFASTEsopeSegmentNode statements
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

{ #category : 'visiting - expressions' }
FASTFortranUseTransformationVisitor >> visitFASTFortranFunctionCall: aFASTFortranFunctionCall [

	| caller called |
	caller := aFASTFortranFunctionCall famix sender.
	called := aFASTFortranFunctionCall famix candidates anyOne.

	(caller migratedModuleName = called migratedModuleName)
		ifFalse: [ self useNeeded: (caller -> called) ].

	super visitFASTFortranFunctionCall: aFASTFortranFunctionCall
]
