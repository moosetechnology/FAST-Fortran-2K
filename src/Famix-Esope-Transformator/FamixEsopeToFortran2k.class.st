"
# Migration automatique de Esope vers Fortran-2k:

- Cloner un projet à migrer, dans `/tmp/`, par exemple [bookstore](https://gitlab.inria.fr/framatome/code/bookstore). Adapter les variables `srcFolder` et `incFolder`.

- Créer une image moose dépuis Pharo Launcher et lancer l'image

- Charger le dépôt [FAST-Fortran-2k](https://github.com/moosetechnology/FAST-Fortran-2K) avec le script Metacello suivant dans un playground:

```st
Metacello new
	baseline: 'FASTFortran2k';
	repository: 'github://moosetechnology/FAST-Fortran-2K';
	onConflictUseIncoming;
	load
```

- Une fois le projet chargé, lancer le script suivant depuis un playground

```st
srcFolder := '/tmp/bookstore/src'.
incFolder := '/tmp/bookstore/src'.

importer := FortranProjectImporter new.
esopeToFortran2kTranspiler := FamixEsopeToFortran2k new.

famixEsopeModel := importer sourceFolder: srcFolder;  includeFolder: incFolder; import.
esopeToFortran2kTranspiler famixModel: famixEsopeModel; run

```

Si vous souhaitez une compilation et éxecution avec [fpm](https://fpm.fortran-lang.org), 
remplacez la ligne 
```st 
esopeToFortran2kTranspiler famixModel: famixEsopeModel; run
```
dans le script précedent par
```st
esopeToFortran2kTranspiler famixModel: famixEsopeModel; isFpm: true; run
```

"
Class {
	#name : 'FamixEsopeToFortran2k',
	#superclass : 'Object',
	#instVars : [
		'allModules',
		'usesNeeded',
		'famixModel',
		'fast2kModel',
		'includedFiles',
		'specialCallTreatments',
		'isFpm'
	],
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'migration-substeps' }
FamixEsopeToFortran2k >> collectUsesNeeded: aFASTProgramUnit [

	| visitor |
	visitor := FASTFortranUseTransformationVisitor new
		parentTransformator: self;
		yourself.
	aFASTProgramUnit accept: visitor.
]

{ #category : 'running' }
FamixEsopeToFortran2k >> exportFAST2k [

	FASTFortran2kExporter on: fast2kModel
]

{ #category : 'running' }
FamixEsopeToFortran2k >> famixEsopeToFast2k [

	"too quick to go in the progress bar (?)"
	(famixModel allWithType: FamixF77ProgramFile) do: [ :famixProgFile |
		famixProgFile fast:
			(FASTFortranProgramFile new filename: famixProgFile filename) ].

	self migrateIncludedFiles.
	self migrateProgramUnits
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

{ #category : 'helper' }
FamixEsopeToFortran2k >> fastModelFor: famixProgUnit in: famixProgFile [

	| fastProgramUnit |
	famixProgUnit bindFASTModel.
	fastProgramUnit := famixProgUnit fast.

	fastProgramUnit 
		ifNotNil: [ fastProgramUnit programFile: famixProgFile fast ].

	^fastProgramUnit 
]

{ #category : 'accessing' }
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
	isFpm := false

]

{ #category : 'accessing' }
FamixEsopeToFortran2k >> isFpm: anObject [

	isFpm := anObject
]

{ #category : 'migration-substeps' }
FamixEsopeToFortran2k >> migrateIncludedFileFAST2k: aFASTIncludedFile [

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

{ #category : 'migration-substeps' }
FamixEsopeToFortran2k >> migrateIncludedFiles [
	"dealing with all IncludedFile-s"

	| toProcess |
	toProcess := famixModel allWithType: FamixF77IncludedFile.

	UIManager default
		displayProgress: ''
		from: 1
		to: toProcess size
		during: [ :bar |
			bar label: 'Migrating include files'.
			toProcess withIndexDo: [ :famixIncludedFile :i || fastPUIncludedFile |
				bar current: i.

				fastPUIncludedFile := self
					fastModelFor: famixIncludedFile
					in: famixIncludedFile programFile.
				self migrateIncludedFileFAST2k: fastPUIncludedFile ]
		].

	^ toProcess
]

{ #category : 'migration-substeps' }
FamixEsopeToFortran2k >> migrateProgramUnitAST: aFASTProgramUnit [

	| visitor |
	visitor := self transformationVisitor: aFASTProgramUnit transformationVisitorClass.
	visitor filename: aFASTProgramUnit programFile filename.
	^aFASTProgramUnit accept: visitor.
]

{ #category : 'migration-substeps' }
FamixEsopeToFortran2k >> migrateProgramUnitFAST2k: aFASTProgramUnit [

	| fastFortran2kProgramUnit |

	FASTEsopeObsoleteCommandRule simplify: aFASTProgramUnit.

	fastFortran2kProgramUnit := self migrateProgramUnitAST: aFASTProgramUnit.

	self simplifyFASTProgramUnit: fastFortran2kProgramUnit.

	self collectUsesNeeded: aFASTProgramUnit.

	^ fast2kModel
]

{ #category : 'migration-substeps' }
FamixEsopeToFortran2k >> migrateProgramUnits [
	"dealing with 'normal' PrugramUnit-s"

	| toProcess |
	
	toProcess := famixModel allWithType: FamixF77ProgramFile.

	UIManager default
		displayProgress: ''
		from: 1
		to: toProcess size
		during: [ :bar |
			bar label: 'Migrating program files'.
			toProcess withIndexDo: [ :famixProgFile :i |
				bar current: i.

				famixProgFile programUnits do: [ :famixProgUnit || fastProgramUnit |
					famixProgUnit class = FamixF77IncludedFile ifFalse: [
						fastProgramUnit := self
							fastModelFor: famixProgUnit
							in: famixProgUnit programFile.
						self migrateProgramUnitFAST2k: fastProgramUnit ] ] ]
		].

	^ toProcess
]

{ #category : 'running' }
FamixEsopeToFortran2k >> migrationSteps [

	| steps |

	steps := {
		'Converting famix esope model to fast2k model' -> #famixEsopeToFast2k .
		'Resolve uses statements in program unit' -> #resolveUses .
		'Export the migrated fast2k model' -> #exportFAST2k 
	}.
	
	^isFpm
		ifTrue: [ steps , { 'Create FPM project' -> #asFpmProject } ]
		ifFalse: [ steps ]
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
		from: 1 to: self migrationSteps size
		during: [:bar |
			self migrationSteps withIndexDo: [ :step :i |
				bar label: step key.
				bar current: i.

				self perform: step value
			] 
		]
]

{ #category : 'migration-substeps' }
FamixEsopeToFortran2k >> simplifyFASTProgramUnit: aFAST2kProgramUnit [

	FASTEsopeSimplifier on: aFAST2kProgramUnit
]

{ #category : 'accessing' }
FamixEsopeToFortran2k >> specialCallTreatments [

	^specialCallTreatments ifNil: [
		specialCallTreatments := Dictionary newFrom: {
			"#oooeta -> #commentOutStatement: .
			#actstr -> #commentOutStatement: ."
			#mypnt -> #prefixCallWithType: .
			#rdstr -> #replaceCallByLoadStr: .
			#wrstr -> #replaceCallByStoreStr:
		} ]
]

{ #category : 'helper' }
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
