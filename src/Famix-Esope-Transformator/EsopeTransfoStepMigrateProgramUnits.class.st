"
Second actual migration from Esope to FASTFortran2k: migrating all Program Units
(each porgram unit goes in its own module)
- gets the FAST model
- simplification of Fortran77 AST (remove obsolete instruction `FASTEsopeObsoleteCommandRule`)
- perform transformation (`FASTFortranMainTransformationVisitor` or `FASTFortranProcedureTransformationVisitor`)
- apply other simplification rules on the generated code (`FASTEsopeSimplifier`)
- collect all modules needed (`use` statements) to satisfy dependencies
"
Class {
	#name : 'EsopeTransfoStepMigrateProgramUnits',
	#superclass : 'EsopeTransfoAbstractStep',
	#instVars : [
		'includedFiles'
	],
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'accessing' }
EsopeTransfoStepMigrateProgramUnits class >> description [ 

		^'Migrating program files'
]

{ #category : 'private' }
EsopeTransfoStepMigrateProgramUnits >> collectUsesNeeded: aFASTProgramUnit [

	| visitor |
	visitor := FASTFortranUseTransformationVisitor new
		parentTransformator: self controller ;
		yourself.
	aFASTProgramUnit accept: visitor.
]

{ #category : 'running' }
EsopeTransfoStepMigrateProgramUnits >> migrateProgramUnitAST: aFASTProgramUnit [

	| visitor |
	visitor := self transformationVisitor: aFASTProgramUnit transformationVisitorClass.
	visitor filename: aFASTProgramUnit programFile filename.
	^aFASTProgramUnit accept: visitor.
]

{ #category : 'running' }
EsopeTransfoStepMigrateProgramUnits >> run [ 

	| fastFortran2kProgramUnit |
	(self famixModel allWithType: FamixF77ProgramFile)
		do: [ :famixProgFile |
			famixProgFile programUnits do: [ :famixProgUnit || fastProgramUnit |
				famixProgUnit class = FamixF77IncludedFile ifFalse: [

					fastProgramUnit := self fastModelFor: famixProgUnit.
					FASTEsopeObsoleteCommandRule simplify: fastProgramUnit.
					fastFortran2kProgramUnit := self migrateProgramUnitAST: fastProgramUnit.
					FASTEsopeSimplifier simplify: fastFortran2kProgramUnit.
					self collectUsesNeeded: fastProgramUnit
				]
			]
		]
]
