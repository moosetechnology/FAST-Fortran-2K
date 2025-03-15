"
I collect all uses needed in programUnits

uses are stored in `usesNeedded` as a collection of associations: needing entity -> needed entity
Later this will generate appropriate use statements in appropriate program units
"
Class {
	#name : 'FASTFortranUseTransformationVisitor',
	#superclass : 'FASTFortranAbstractTransformationVisitor',
	#traits : 'FASTEsopeTVisitor',
	#classTraits : 'FASTEsopeTVisitor classTrait',
	#instVars : [
		'parentTransformator'
	],
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
}

{ #category : 'accessing' }
FASTFortranUseTransformationVisitor >> model2k [
	"not needed here"

	self shouldNotImplement 
]

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
				self useNeeded:  (programUnit -> type)
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
FASTFortranUseTransformationVisitor >> visitFASTEsopeSeg: aFASTEsopeSegCommand command: commandName [

	aFASTEsopeSegCommand variables 
		do: [ :variable |  | programUnit segment |
			programUnit := variable famixVariable parentBehaviouralEntity.
			segment := variable famixVariable declaredType.

			self useNeeded: (programUnit -> segment)
		]
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

{ #category : 'visiting - statements' }
FASTFortranUseTransformationVisitor >> visitFASTFortranExternalStatement: aFASTFortranExternalStatement [
	"here we know for sure this will need use statement since it is an external procedure
	- if a use statement with this name already exists, we do nothing othewise we can create a one
	We can ask module name with: aFASTFortranExternalStatement famix migratedModuleName
	
	"
	self useNeeded: 
		(aFASTFortranExternalStatement famix programUnit 
		-> aFASTFortranExternalStatement famix externalProcedure)
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

{ #category : 'visiting - statements' }
FASTFortranUseTransformationVisitor >> visitFASTFortranVariableDeclarator: aFASTFortranVariableDeclarator [
]
