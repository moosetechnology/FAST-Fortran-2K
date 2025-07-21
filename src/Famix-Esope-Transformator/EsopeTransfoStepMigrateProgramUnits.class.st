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
EsopeTransfoStepMigrateProgramUnits >> migrateProgramUnitFAST2k: aFASTProgramUnit [

	| fastFortran2kProgramUnit |

	FASTEsopeObsoleteCommandRule simplify: aFASTProgramUnit.

	fastFortran2kProgramUnit := self migrateProgramUnitAST: aFASTProgramUnit.

	self simplifyFASTProgramUnit: fastFortran2kProgramUnit.

	self collectUsesNeeded: aFASTProgramUnit.

]

{ #category : 'running' }
EsopeTransfoStepMigrateProgramUnits >> run [ 

	(self famixModel allWithType: FamixF77ProgramFile)
		do: [ :famixProgFile || fastProgramUnit |
			famixProgFile programUnits do: [ :famixProgUnit || fastProgramUnit |
				famixProgUnit class = FamixF77IncludedFile ifFalse: [
					fastProgramUnit := self
						fastModelFor: famixProgUnit
						in: famixProgUnit programFile.
					self migrateProgramUnitFAST2k: fastProgramUnit
				]
			]
		]
]

{ #category : 'running' }
EsopeTransfoStepMigrateProgramUnits >> simplifyFASTProgramUnit: aFAST2kProgramUnit [

	FASTEsopeSimplifier on: aFAST2kProgramUnit
]
