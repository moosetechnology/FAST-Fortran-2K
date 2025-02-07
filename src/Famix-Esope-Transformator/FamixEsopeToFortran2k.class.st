Class {
	#name : 'FamixEsopeToFortran2k',
	#superclass : 'Object',
	#instVars : [
		'modelIn',
		'modelOut',
		'allModules'
	],
	#category : 'Famix-Esope-Transformator',
	#package : 'Famix-Esope-Transformator'
}

{ #category : 'helpers - segment' }
FamixEsopeToFortran2k >> getModule: filename ifAbsentPut: aBlock [

	^allModules
		at: filename 
		ifAbsentPut: aBlock
]

{ #category : 'initialization' }
FamixEsopeToFortran2k >> initialize [

	super initialize.

	modelOut := FASTFortran2kModel new.
	allModules := Dictionary new.
]

{ #category : 'accessing' }
FamixEsopeToFortran2k >> modelIn [

	^ modelIn
]

{ #category : 'accessing' }
FamixEsopeToFortran2k >> modelIn: anObject [

	modelIn := anObject
]

{ #category : 'accessing' }
FamixEsopeToFortran2k >> modelOut [

	^ modelOut
]

{ #category : 'accessing' }
FamixEsopeToFortran2k >> modelOut: anObject [

	modelOut := anObject
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

		famixProgFile programUnits do: [ :famixProgUnit || visitor fastProgramUnit |
			famixProgUnit bindFASTModel.
			fastProgramUnit := famixProgUnit fast.
			fastProgFile addProgramUnit: fastProgramUnit.

			visitor := self transformationVisitor: fastProgramUnit transformationVisitorClass.
			fastProgramUnit accept: visitor.

			usesNeeded addAll: visitor usesNeeded.
			
			fastProgramUnit accept: CRFFBindingCleaner new
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
