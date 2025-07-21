"
First actual migration from Esope to FASTFortran2k: migrating included files
- get the FAST model
- perform transformation (`FASTFortranIncludedFileTransformationVisitor`)
- get the statements to put in place of the inclusion (typically: variable declarations)
- register all used type and called procedures (`FASTFortranUseTransformationVisitor`) to generate `use` statements later
"
Class {
	#name : 'EsopeTransfoStepMigrateIncludedFiles',
	#superclass : 'EsopeTransfoAbstractStep',
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'accessing' }
EsopeTransfoStepMigrateIncludedFiles class >> description [ 

	^'Migrating include files'
]

{ #category : 'running' }
EsopeTransfoStepMigrateIncludedFiles >> migrateIncludedFileFAST2k: aFASTIncludedFile [
	"transformationVisitorClass should be FASTFortranIncludedFileTransformationVisitor"

	| visitor includedStatements |

	visitor := self transformationVisitor: aFASTIncludedFile transformationVisitorClass.
	visitor filename: aFASTIncludedFile programFile filename.

	includedStatements := aFASTIncludedFile accept: visitor.

	self includedFiles
		at: aFASTIncludedFile programFile filename
		put: includedStatements.

	visitor := FASTFortranUseTransformationVisitor new
		parentTransformator: self;
		yourself.
	aFASTIncludedFile accept: visitor.

]

{ #category : 'running' }
EsopeTransfoStepMigrateIncludedFiles >> run [ 

	(self famixModel allWithType: FamixF77IncludedFile)
		do: [ :famixIncludedFile || fastPUIncludedFile |
			fastPUIncludedFile := self fastModelFor: famixIncludedFile.
			self migrateIncludedFileFAST2k: fastPUIncludedFile
	]
]
