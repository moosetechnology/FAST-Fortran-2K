Class {
	#name : 'FASTEsopeObsoleteCommandRule',
	#superclass : 'FASTFortranVisitor',
	#traits : 'FASTEsopeTVisitor + FASTTSimplifier',
	#classTraits : 'FASTEsopeTVisitor classTrait + FASTTSimplifier classTrait',
	#instVars : [
		'nodeStack',
		'simplified'
	],
	#category : 'Famix-Esope-Transformator-Simplification',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Simplification'
}

{ #category : 'entity-creation' }
FASTEsopeObsoleteCommandRule class >> simplify: aFASTEntity [

	^self new
		simplify: aFASTEntity
]

{ #category : 'accessing' }
FASTEsopeObsoleteCommandRule >> fastExporter [

	^FASTEsopeExporterVisitor new
]

{ #category : 'initialization' }
FASTEsopeObsoleteCommandRule >> initialize [ 

	super initialize.

	simplified := false.
	nodeStack := Stack new
]

{ #category : 'accessing' }
FASTEsopeObsoleteCommandRule >> invocationsToIgnore [

	^#(
		oooeta
		"ooossg" "used to register all used segment see: https://github.com/moosetechnology/FAST-Fortran-2K/issues/90"
		ooostp
		actstr
		desstr
	)
]

{ #category : 'accessing - private tests' }
FASTEsopeObsoleteCommandRule >> nodeStack [

	^nodeStack 
]

{ #category : 'accessing' }
FASTEsopeObsoleteCommandRule >> parentStatement [

	^ nodeStack top
]

{ #category : 'accessing' }
FASTEsopeObsoleteCommandRule >> simplified [

	^simplified
]

{ #category : 'run' }
FASTEsopeObsoleteCommandRule >> simplify: aFASTEntity [

	simplified := false.

	aFASTEntity accept: self.

	^simplified
]

{ #category : 'accessing' }
FASTEsopeObsoleteCommandRule >> toggleSimplifiedOn [

	simplified := true
]

{ #category : 'visiting - statements' }
FASTEsopeObsoleteCommandRule >> visitFASTEsopeSegact: aFASTEsopeSegact [

	self commentOut: 'obsolete' statement: aFASTEsopeSegact

]

{ #category : 'visiting - statements' }
FASTEsopeObsoleteCommandRule >> visitFASTEsopeSegdes: aFASTEsopeSegdes [

	self commentOut: 'obsolete' statement: aFASTEsopeSegdes

]

{ #category : 'visiting - statements' }
FASTEsopeObsoleteCommandRule >> visitFASTFortranCallStatement: aFASTFortranCallStatement [

	(self invocationsToIgnore includes: aFASTFortranCallStatement name)
		ifTrue: [
			self commentOut: 'obsolete' statement: aFASTFortranCallStatement
		]
]

{ #category : 'visiting - statements' }
FASTEsopeObsoleteCommandRule >> visitFASTFortranIfLogicalStatement: aFASTFortranIfLogicalStatement [

	nodeStack push: aFASTFortranIfLogicalStatement.

	super visitFASTFortranIfLogicalStatement: aFASTFortranIfLogicalStatement.

	nodeStack pop
]

{ #category : 'visiting - statements' }
FASTEsopeObsoleteCommandRule >> visitFASTFortranStatementBlock: aFASTFortranStatementBlock [

	nodeStack push: aFASTFortranStatementBlock.

	aFASTFortranStatementBlock statements do: [:stmt | stmt accept: self ].

	nodeStack pop
]
