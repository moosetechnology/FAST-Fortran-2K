Class {
	#name : 'FASTFortranTransformationVisitor',
	#superclass : 'FASTFortranAbstractTransformationVisitor',
	#instVars : [
		'useNeeded',
		'allModules',
		'model'
	],
	#category : 'Famix-Esope-Transformator',
	#package : 'Famix-Esope-Transformator'
}

{ #category : 'helpers' }
FASTFortranTransformationVisitor >> addUseIn: aFASTFortran2kEntity to: moduleName [

	self flag: #FIXME. "how to handle the order of uses statements"

	aFASTFortran2kEntity statementBlock statements 
		addFirst: (
		FASTFortran2kUseStatement new 
			name: moduleName ;
			mooseModel: model;
			yourself
		)
	

]

{ #category : 'helpers' }
FASTFortranTransformationVisitor >> addUsesIn: programUnit [
	"programUnit is a FASTFortran2k ProgramUnit.
	 Checking if it needs some 'use' instructions"

	useNeeded do: [ :assoc || source target |
		source := assoc key.    "a FASTFortran2k ProgramUnit or a DerivedTypeDefinition"
		target := assoc value.  "a FamixF77 ProgramFile or Segment"

		(source inSameFileAs: programUnit)
			ifTrue: [
				(source needsUseFor: target)
					ifTrue: [ self addUseIn: programUnit to: target migratedModuleName ]
			]
	]
]

{ #category : 'helpers' }
FASTFortranTransformationVisitor >> createProgramFile: f77Filename forProgramUnits: programUnitsF2k [
	"Creates one or several FASTFortran2kProgramFile from the programUnitsF2k
	 - one for a FASTFortran2kProgramMain
	 - one for all FASTFortran2kProcedure grouped in a FASTFortran2kModule
	 - one for each FASTFortran2kDerivedType (segments)"

	| puModule puMain programFiles |
	programFiles := OrderedCollection new: 2.
	puModule := OrderedCollection new.
	puMain := nil.

	programUnitsF2k do: [ :progUnit |
		progUnit class = FASTFortran2kProgramMain
			ifTrue: [ puMain := progUnit ]
			ifFalse: [ puModule add: progUnit ] ].

	puModule ifNotEmpty: [ programFiles filename: (self fortran2kFilename: f77Filename) ].

	puMain ifNotNil: [ programFiles filename: (self fortran2kFilename: f77Filename) ].

	puModule ifNotEmpty: [
		programFiles
			addProgramUnit: ((self ensureModule: f77Filename)
				 procedures: puModule;
				 yourself).

		self addUsesIn: programFiles programUnit last.
	].

	puMain ifNotNil: [ 
		programFiles addProgramUnit: puMain.

		self addUsesIn: puMain
	].

	useNeeded removeAll 
	
]

{ #category : 'helpers' }
FASTFortranTransformationVisitor >> fortran2kFilename: f77Filename [
	"assuming f77Filename is of the form: 'xyz.f' "
	
	^f77Filename , '90'
]

{ #category : 'helpers' }
FASTFortranTransformationVisitor >> getModule: filename ifAbsentPut: aBlock [

	^allModules
		at: filename 
		ifAbsentPut: aBlock
]

{ #category : 'initialization' }
FASTFortranTransformationVisitor >> initialize [

	super initialize.

	allModules := Dictionary new.
	model := FASTFortran2kModel new.
]

{ #category : 'accessing' }
FASTFortranTransformationVisitor >> model [

	^ model
]

{ #category : 'accessing' }
FASTFortranTransformationVisitor >> model: anObject [

	model := anObject
]

{ #category : 'helpers' }
FASTFortranTransformationVisitor >> programFile: programFile in: f77Filename modules: programUnits [

	| puModule puMain |
	puModule := OrderedCollection new.
	puMain := nil.

	programUnits do: [ :progUnit |
		progUnit class = FASTFortran2kProgramMain
			ifTrue: [ puMain := progUnit ]
			ifFalse: [ puModule add: progUnit ] ].

	puModule ifNotEmpty: [ programFile filename: (self fortran2kFilename: f77Filename) ].

	puMain ifNotNil: [ programFile filename: (self fortran2kFilename: f77Filename) ].

	puModule ifNotEmpty: [
		programFile
			addProgramUnit: ((self ensureModule: f77Filename)
				 procedures: puModule;
				 yourself).

		self addUsesIn: programFile programUnit last.
	].

	puMain ifNotNil: [ 
		programFile addProgramUnit: puMain.

		self addUsesIn: puMain
	].

	useNeeded removeAll 
	
]

{ #category : 'helpers' }
FASTFortranTransformationVisitor >> transformationVisitor: visitorClass [

	^visitorClass new
		parentTransformator: self ;
		yourself
]

{ #category : 'visiting' }
FASTFortranTransformationVisitor >> visitFASTEsopeIncludeStatement: aFASTEsopeIncludeStatement [

	| famixProgramUnit f2kProgramUnit |
	
	famixProgramUnit := aFASTEsopeIncludeStatement statementContainer fastBehaviouralParent famix.
	f2kProgramUnit := stack top.
	famixProgramUnit includes halt
]

{ #category : 'visiting - programUnits' }
FASTFortranTransformationVisitor >> visitFASTFortranProgramFile: aFASTFortranProgramFile [

	self flag: 'TODO aFASTFortranProgramFile comments'.

	^aFASTFortranProgramFile programUnit collectAsSet: [ :progUnit || visitor |
		visitor := self transformationVisitor: progUnit transformationVisitorClass.
		progUnit accept: visitor
	].

]
