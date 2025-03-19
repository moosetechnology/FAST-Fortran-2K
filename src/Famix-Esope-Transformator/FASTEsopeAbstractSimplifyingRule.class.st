"
I am a simplification rule for a FASTFortran AST

I take take an AST and converts some instruction to comment to ""remove them"" from the AST
"
Class {
	#name : 'FASTEsopeAbstractSimplifyingRule',
	#superclass : 'FASTFortran2kAbstractVisitor',
	#traits : 'FASTTSimplifier',
	#classTraits : 'FASTTSimplifier classTrait',
	#instVars : [
		'nodeStack',
		'simplified'
	],
	#category : 'Famix-Esope-Transformator-Simplification',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Simplification'
}

{ #category : 'entity-creation' }
FASTEsopeAbstractSimplifyingRule class >> simplify: aFASTEntity [

	^self new
		simplify: aFASTEntity
]

{ #category : 'accessing' }
FASTEsopeAbstractSimplifyingRule >> fastExporter [

	^ FASTFortran2kProgramFileExporterVisitor new
]

{ #category : 'initialization' }
FASTEsopeAbstractSimplifyingRule >> initialize [ 

	super initialize.

	simplified := false.
	nodeStack := Stack new
]

{ #category : 'accessing - private tests' }
FASTEsopeAbstractSimplifyingRule >> nodeStack [

	^nodeStack 
]

{ #category : 'accessing' }
FASTEsopeAbstractSimplifyingRule >> parentStatement [

	^ nodeStack top
]

{ #category : 'accessing' }
FASTEsopeAbstractSimplifyingRule >> simplified [

	^simplified
]

{ #category : 'run' }
FASTEsopeAbstractSimplifyingRule >> simplify: aFASTEntity [

	simplified := false.

	aFASTEntity accept: self.

	^simplified
]

{ #category : 'accessing' }
FASTEsopeAbstractSimplifyingRule >> toggleSimplifiedOn [

	simplified := true
]

{ #category : 'visiting - statements' }
FASTEsopeAbstractSimplifyingRule >> visitFASTFortran2kIfLogicalStatement: aFASTFortranIfLogicalStatement [

	nodeStack push: aFASTFortranIfLogicalStatement.

	super visitFASTFortran2kIfLogicalStatement: aFASTFortranIfLogicalStatement.

	nodeStack pop
]

{ #category : 'visiting - programUnits' }
FASTEsopeAbstractSimplifyingRule >> visitFASTFortran2kProgramFile: aFASTFortran2kProgramFile [

	aFASTFortran2kProgramFile programUnits do: [ :programunit |
		programunit accept: self
	]
]

{ #category : 'visiting - statements' }
FASTEsopeAbstractSimplifyingRule >> visitFASTFortran2kStatementBlock: aFASTFortranStatementBlock [

	nodeStack push: aFASTFortranStatementBlock.

	aFASTFortranStatementBlock statements do: [:stmt | stmt accept: self ].

	nodeStack pop
]

{ #category : 'generated' }
FASTEsopeAbstractSimplifyingRule >> visitFASTTEntity: aFASTTEntity [

]

{ #category : 'generated' }
FASTEsopeAbstractSimplifyingRule >> visitFASTTNamedEntity: aFASTAssociation [

]
