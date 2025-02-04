Class {
	#name : 'FASTFortranTransformationVisitor',
	#superclass : 'FASTFortranAbstractTransformationVisitor',
	#instVars : [
		'useNeeded',
		'allModules'
	],
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
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
			addProgramUnit: ((self makePuModule: f77Filename)
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

{ #category : 'initialization' }
FASTFortranTransformationVisitor >> initialize [

	super initialize.

	model := FASTFortran2kModel new.
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
			addProgramUnit: ((self makePuModule: f77Filename)
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
FASTFortranTransformationVisitor >> subVisitor: visitorClass [

	^visitorClass new
		parentVisitor: self ;
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

	^aFASTFortranProgramFile programUnit collect: [ :progUnit || visitor |
		visitor := self subVisitor: progUnit transformationVisitorClass.
		progUnit accept: visitor
	].

]
