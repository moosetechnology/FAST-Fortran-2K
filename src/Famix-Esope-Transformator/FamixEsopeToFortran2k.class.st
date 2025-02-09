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
FamixEsopeToFortran2k >> resolveUses: usesNeeded [
	"usesNeeded is a collection of associations:
	 - user -- a FamixF77ProgramUnit
	 - needed -- a FamixF77ProgramUnit or FamixEsopeSegment"

	usesNeeded do: [ :association |
	]
]

{ #category : 'running' }
FamixEsopeToFortran2k >> run [

	| usesNeeded |
	usesNeeded := Set new.

	(modelIn allWithType: FamixF77ProgramFile) do: [ :famixProgFile || fastProgFile |
		fastProgFile := FASTFortranProgramFile new
			filename: famixProgFile filename.
		fastProgFile famix: famixProgFile.

		famixProgFile programUnits do: [ :famixProgUnit || visitor fastProgramUnit |
			famixProgUnit bindFASTModel.
			fastProgramUnit := famixProgUnit fast.
			fastProgFile addProgramUnit: fastProgramUnit.

			visitor := self transformationVisitor: fastProgramUnit transformationVisitorClass.
			fastProgramUnit accept: visitor.

			visitor := FASTFortranUseTransformationVisitor new
				parentTransformator: self.
			fastProgramUnit accept: visitor.
			usesNeeded addAll: visitor usesNeeded.

			fastProgramUnit accept: CRFEsopeBindingCleanerVisitor new
		]
	].

	self resolveUses: usesNeeded.

	FASTFortran2kExporterVisitor new
		model: modelOut ;
		export
]

{ #category : 'running' }
FamixEsopeToFortran2k >> transformationVisitor: visitorClass [

	^visitorClass new
		parentTransformator: self ;
		yourself
]

{ #category : 'accessing' }
FamixEsopeToFortran2k >> usesNeeded [

	^ usesNeeded
]
