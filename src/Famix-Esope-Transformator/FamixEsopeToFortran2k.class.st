Class {
	#name : 'FamixEsopeToFortran2k',
	#superclass : 'Object',
	#instVars : [
		'allModules',
		'usesNeeded',
		'famixModel',
		'fast2kModel'
	],
	#category : 'Famix-Esope-Transformator',
	#package : 'Famix-Esope-Transformator'
}

{ #category : 'running' }
FamixEsopeToFortran2k >> exportFAST2k [

	FASTFortran2kExporterVisitor new
		model: fast2kModel ;
		export
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

{ #category : 'initialization' }
FamixEsopeToFortran2k >> initialize [

	super initialize.

	famixModel := FamixEsopeModel new.
	allModules := Dictionary new.
	usesNeeded := Set new.
	fast2kModel := FASTFortran2kModel new.

]

{ #category : 'running' }
FamixEsopeToFortran2k >> migrateToFAST2k: aFASTProgramUnit [

	| visitor |

	visitor := self transformationVisitor: aFASTProgramUnit transformationVisitorClass.
	aFASTProgramUnit accept: visitor.

	visitor := FASTFortranUseTransformationVisitor new
		parentTransformator: self.
	aFASTProgramUnit accept: visitor.

	^visitor parentTransformator fast2kModel

]

{ #category : 'running' }
FamixEsopeToFortran2k >> resolveUses: usesNeeded [
	"usesNeeded is a collection of associations:
	 - user -- a FamixF77ProgramUnit
	 - needed -- a FamixF77ProgramUnit or FamixEsopeSegment"

	usesNeeded do: [ :association | | source target | 1halt.
		source := association key.
		target := association value.
		source fast attributeAt: source fast name ifAbsentPut: target migratedModuleName
	]
]

{ #category : 'running' }
FamixEsopeToFortran2k >> run [
	usesNeeded := Set new.

	(famixModel allWithType: FamixF77ProgramFile) do: [ :famixProgFile |
		famixProgFile fast: (FASTFortranProgramFile new
			filename: famixProgFile filename).

		famixProgFile programUnits do: [ :famixProgUnit || fastProgramUnit |
			fastProgramUnit := self fastModelFor: famixProgUnit in: famixProgFile.
			
			fastProgramUnit ifNotNil: [ 
				self migrateToFAST2k: fastProgramUnit.

				self flag: '#FIXME: fastProgramUnit mooseModel removeAll'.
				"fastProgramUnit mooseModel cleanAll"
			 ]
		]
	].

	self resolveUses: usesNeeded.

	self exportFAST2k
]

{ #category : 'running' }
FamixEsopeToFortran2k >> transformationVisitor: visitorClass [

	^visitorClass new
		parentTransformator: self ;
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
