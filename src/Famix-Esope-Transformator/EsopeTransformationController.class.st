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
transformationController := EsopeTransformationController new.

famixEsopeModel := importer sourceFolder: srcFolder;  includeFolder: incFolder; import.
transformationController famixModel: famixEsopeModel; run

```

Si vous souhaitez une compilation et éxecution avec [fpm](https://fpm.fortran-lang.org), 
remplacez la ligne 
```st 
transformationController famixModel: famixEsopeModel; run
```
dans le script précedent par
```st
transformationController famixModel: famixEsopeModel; isFpm: true; run
```

"
Class {
	#name : 'EsopeTransformationController',
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

{ #category : 'import-export' }
EsopeTransformationController class >> sourceFolder: aSourcePathString includeFolder: anIncludePathString [

	| famixEsopeModel |
	famixEsopeModel := FamixEsopeImporter new 
		sourceFolder: aSourcePathString ;
		includeFolder: anIncludePathString ;
		import.

	self new
		famixModel: famixEsopeModel ; 
		isFpm: true ;
		run
]

{ #category : 'accessing' }
EsopeTransformationController >> famixModel [

	^ famixModel
]

{ #category : 'accessing' }
EsopeTransformationController >> famixModel: anObject [

	famixModel := anObject
]

{ #category : 'accessing' }
EsopeTransformationController >> fast2kModel [

	^ fast2kModel
]

{ #category : 'accessing' }
EsopeTransformationController >> getModule: filename ifAbsentPut: aBlock [

	^allModules
		at: filename 
		ifAbsentPut: aBlock
]

{ #category : 'accessing' }
EsopeTransformationController >> includedFiles [

	^ includedFiles
]

{ #category : 'initialization' }
EsopeTransformationController >> initialize [

	super initialize.

	famixModel := FamixEsopeModel new.
	allModules := Dictionary new.
	usesNeeded := Set new.
	fast2kModel := FASTFortran2kModel new.
	includedFiles := Dictionary new.
	isFpm := false

]

{ #category : 'accessing' }
EsopeTransformationController >> isFpm: anObject [

	isFpm := anObject
]

{ #category : 'running' }
EsopeTransformationController >> migrationSteps [

	^{
		EsopeTransfoStepPrepareProgFiles .
		EsopeTransfoStepMigrateIncludedFiles .
		EsopeTransfoStepMigrateProgramUnits .
		EsopeTransfoStepResolveUses .
		EsopeTransfoStepExportFast2k .
		isFpm ifTrue: [ EsopeTransfoStepAsFpmProject ] ifFalse: [ EsopeTransfoStepNoop ]
	}
]

{ #category : 'running' }
EsopeTransformationController >> run [
	"The following commented statement is already initialized in initialize method"
	"usesNeeded := Set new." 

	UIManager default displayProgress: ''
		from: 1 to: self migrationSteps size
		during: [:bar |
			self migrationSteps withIndexDo: [ :step :i |
				bar label: step description.
				bar current: i.

				self runStep: step
			] 
		]
]

{ #category : 'running' }
EsopeTransformationController >> runStep: aStepClass [

	aStepClass new
		controller: self ;
		run
]

{ #category : 'accessing' }
EsopeTransformationController >> specialCallTreatments [

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
EsopeTransformationController >> transformationVisitor: visitorClass [

	^visitorClass new
		parentTransformator: self ;
		model2k: fast2kModel;
		yourself
]

{ #category : 'accessing' }
EsopeTransformationController >> useNeeded: anAssociation [

	usesNeeded add: anAssociation 
]

{ #category : 'accessing' }
EsopeTransformationController >> usesNeeded [

	^ usesNeeded
]
