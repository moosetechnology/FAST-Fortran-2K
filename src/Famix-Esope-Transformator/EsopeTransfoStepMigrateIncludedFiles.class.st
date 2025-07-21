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

	| visitor includedStatements |

	visitor := self transformationVisitor: aFASTIncludedFile transformationVisitorClass.
	visitor filename: aFASTIncludedFile programFile filename.

	includedStatements := aFASTIncludedFile accept: visitor.

	self includedFiles at: aFASTIncludedFile programFile filename put: includedStatements.

	visitor := FASTFortranUseTransformationVisitor new
		parentTransformator: self;
		yourself.
	aFASTIncludedFile accept: visitor.

]

{ #category : 'running' }
EsopeTransfoStepMigrateIncludedFiles >> run [ 

	(self famixModel allWithType: FamixF77IncludedFile)
		do: [ :famixIncludedFile || fastPUIncludedFile |
			fastPUIncludedFile := self
				fastModelFor: famixIncludedFile
				in: famixIncludedFile programFile.
			self migrateIncludedFileFAST2k: fastPUIncludedFile
	]
]
