Class {
	#name : 'FamixEsopeToFortran2k',
	#superclass : 'Object',
	#instVars : [
		'allModules',
		'usesNeeded',
		'famixModel',
		'fast2kModel',
		'includedFiles'
	],
	#category : 'Famix-Esope-Transformator-Core',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Core'
}

{ #category : 'running' }
FamixEsopeToFortran2k >> exportFAST2k [

	FASTFortran2kExporterVisitor new
		model: fast2kModel ;
		export
]

{ #category : 'running' }
FamixEsopeToFortran2k >> famixEsopeToFast2k [

	(famixModel allWithType: FamixF77ProgramFile) do: [ :famixProgFile |
		famixProgFile fast: (FASTFortranProgramFile new
			filename: famixProgFile filename)
	].

	"dealing with all IncludedFile-s"
	(famixModel allWithType: FamixF77IncludedFile) do: [ :famixIncludedFile || fastPUIncludedFile |
		fastPUIncludedFile := self fastModelFor: famixIncludedFile in: famixIncludedFile programFile.

		self migrateIncludedFileToFAST2k: fastPUIncludedFile.
	].

	"dealing with 'normal' PrugramUnit-s"
	(famixModel allWithType: FamixF77ProgramFile) do: [ :famixProgFile |
		famixProgFile programUnits do: [ :famixProgUnit || fastProgramUnit |
			(famixProgUnit class = FamixF77IncludedFile)
				ifFalse: [ 
					fastProgramUnit := self fastModelFor: famixProgUnit in: famixProgUnit programFile.

					self migrateToFAST2k: fastProgramUnit.

				"self flag: '#FIXME: cleaning, quid revolveUses'.
				fastProgramUnit accept: fastProgramUnit mooseModel carrefourBinderCleaner"
			 ]
		]
	]

]

{ #category : 'accessing' }
FamixEsopeToFortran2k >> famixModel [

	^ famixModel
]

{ #category : 'accessing' }
FamixEsopeToFortran2k >> famixModel: anObject [

	famixModel := anObject
]

{ #category : 'accessing' }
FamixEsopeToFortran2k >> fast2kModel [

	^ fast2kModel
]

{ #category : 'running' }
FamixEsopeToFortran2k >> fastModelFor: famixProgUnit in: famixProgFile [

	| fastProgramUnit |
	famixProgUnit bindFASTModel.
	fastProgramUnit := famixProgUnit fast.

	fastProgramUnit 
		ifNotNil: [ fastProgramUnit programFile: famixProgFile fast ].

	^fastProgramUnit 
]

{ #category : 'helpers - segment' }
FamixEsopeToFortran2k >> getModule: filename ifAbsentPut: aBlock [

	^allModules
		at: filename 
		ifAbsentPut: aBlock
]

{ #category : 'accessing' }
FamixEsopeToFortran2k >> includedFiles [

	^ includedFiles
]

{ #category : 'initialization' }
FamixEsopeToFortran2k >> initialize [

	super initialize.

	famixModel := FamixEsopeModel new.
	allModules := Dictionary new.
	usesNeeded := Set new.
	fast2kModel := FASTFortran2kModel new.
	includedFiles := Dictionary new.

]

{ #category : 'running' }
FamixEsopeToFortran2k >> migrateIncludedFileToFAST2k: aFASTIncludedFile [

	| visitor includedStatements |

	visitor := self transformationVisitor: aFASTIncludedFile transformationVisitorClass.
	visitor filename: aFASTIncludedFile programFile filename.

	includedStatements := aFASTIncludedFile accept: visitor.

	includedFiles at: aFASTIncludedFile programFile filename put: includedStatements.

	visitor := FASTFortranUseTransformationVisitor new
		parentTransformator: self;
		yourself.
	aFASTIncludedFile accept: visitor.

]

{ #category : 'running' }
FamixEsopeToFortran2k >> migrateToFAST2k: aFASTProgramUnit [

	| visitor |

	visitor := self transformationVisitor: aFASTProgramUnit transformationVisitorClass.
	visitor filename: aFASTProgramUnit programFile filename.
	aFASTProgramUnit accept: visitor.

	visitor := FASTFortranUseTransformationVisitor new
		parentTransformator: self;
		yourself.
	aFASTProgramUnit accept: visitor.

	^fast2kModel

]

{ #category : 'running' }
FamixEsopeToFortran2k >> migrationSteps [
	^{
		'Converting famix esope model to fast2k model' -> #famixEsopeToFast2k .
		'Resolve uses statements in program unit' -> #resolveUses .
		'Export the migrated fast2k model' -> #exportFAST2k 
	}
]

{ #category : 'running' }
FamixEsopeToFortran2k >> resolveUses [

	"usesNeeded is a collection of associations:
	 - fmxUser -- a FamixF77ProgramUnit
	 - fmxNeeded -- a FamixF77ProgramUnit or FamixEsopeSegment"

	usesNeeded do: [ :association | | fmxUser fmxNeeded |
		fmxUser := association key.
		fmxNeeded := association value.

		fmxUser fast transformed2k useSource
			addUse: (fmxNeeded migratedModuleName)
	]
]

{ #category : 'running' }
FamixEsopeToFortran2k >> run [
	"The following commented statement is already initialized in initialize method"
	"usesNeeded := Set new." 

	UIManager default displayProgress: ''
		from: 0 to: (self migrationSteps size - 1)
		during: [:bar |
			self migrationSteps withIndexDo: [ :step :i |
				bar label: step key.
				bar current: i.

				self perform: step value
			] 
		]
]

{ #category : 'running' }
FamixEsopeToFortran2k >> transformationVisitor: visitorClass [

	^visitorClass new
		parentTransformator: self ;
		model2k: fast2kModel;
		yourself
]

{ #category : 'accessing' }
FamixEsopeToFortran2k >> useNeeded: anAssociation [

	usesNeeded add: anAssociation 
]

{ #category : 'accessing' }
FamixEsopeToFortran2k >> usesNeeded [

	^ usesNeeded
]
