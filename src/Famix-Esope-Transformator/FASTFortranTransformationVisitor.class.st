Class {
	#name : 'FASTFortranTransformationVisitor',
	#superclass : 'FASTFortranAbstractTransformationVisitor',
	#instVars : [
		'useNeeded',
		'allModules',
		'model'
	],
	#category : 'Famix-Esope-Transformator-Visitors',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Visitors'
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
FASTFortranTransformationVisitor >> transformationVisitor: visitorClass [

	^visitorClass new
		parentTransformator: self ;
		model: model;
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
