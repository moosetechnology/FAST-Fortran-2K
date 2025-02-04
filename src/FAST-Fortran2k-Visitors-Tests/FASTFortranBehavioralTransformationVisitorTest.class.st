Class {
	#name : 'FASTFortranBehavioralTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractTransformationVisitorTest',
	#instVars : [
		'parentVisitor'
	],
	#category : 'FAST-Fortran2k-Visitors-Tests',
	#package : 'FAST-Fortran2k-Visitors-Tests'
}

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> newVisitor [ 

	parentVisitor := FASTFortranTransformationVisitor new.
	^FASTFortranProcedureTransformationVisitor new
		parentVisitor: parentVisitor.

]

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> testCreateModule [

	| module |

	module := visitor createModule: 'someName_mod'.

	self assert: module class equals: FASTFortran2kModule.
	self assert: module name equals: 'someName_mod'.
	
	self assert: module parentProgramFile isNotNil.
	self assert: module parentProgramFile class equals: FASTFortran2kProgramFile.
	self assert: module parentProgramFile filename equals: 'someName_mod.f90'

]

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> testEnsureModuleOnce [

	| module |

	module := visitor ensureModule: 'someName_mod'.

	self assert: module class equals: FASTFortran2kModule.
	self assert: module name equals: 'someName_mod'.

]

{ #category : 'running' }
FASTFortranBehavioralTransformationVisitorTest >> testEnsureModuleTwice [

	| module |

	module := visitor ensureModule: 'someName_mod'.

	self assert: module class equals: FASTFortran2kModule.
	self assert: module name equals: 'someName_mod'.

	self assert: (visitor ensureModule: 'someName_mod') equals: module
]
