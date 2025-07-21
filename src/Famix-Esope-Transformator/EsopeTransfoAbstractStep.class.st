"
An abstract class for all the steps in the transformation Esope to Fortran2k
Keeps a pointer on the main `controller` (`EsopeTransformationController`) and offers access methods for various instance variables in this controller.
There is a `description` on class side to display the progress on a progress bar
"
Class {
	#name : 'EsopeTransfoAbstractStep',
	#superclass : 'Object',
	#instVars : [
		'controller'
	],
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'accessing' }
EsopeTransfoAbstractStep class >> description [

	| anEsopeTransfoAbstractStep |
	anEsopeTransfoAbstractStep := self new.

	anEsopeTransfoAbstractStep subclassResponsibility
]

{ #category : 'accessing' }
EsopeTransfoAbstractStep >> controller [

	^ controller
]

{ #category : 'accessing' }
EsopeTransfoAbstractStep >> controller: anObject [

	controller := anObject
]

{ #category : 'accessing' }
EsopeTransfoAbstractStep >> famixModel [

	^self controller famixModel
]

{ #category : 'private' }
EsopeTransfoAbstractStep >> fastModelFor: famixProgUnit [

	| fastProgramUnit |
	famixProgUnit bindFASTModel.
	fastProgramUnit := famixProgUnit fast.

	fastProgramUnit 
		ifNotNil: [ fastProgramUnit programFile: famixProgUnit programFile fast ].

	^fastProgramUnit 
]

{ #category : 'accessing' }
EsopeTransfoAbstractStep >> includedFiles [

	^self controller includedFiles
]

{ #category : 'running' }
EsopeTransfoAbstractStep >> run [ 
	self subclassResponsibility 
]

{ #category : 'private' }
EsopeTransfoAbstractStep >> transformationVisitor: visitorClass [

	^visitorClass new
		parentTransformator: self controller ;
		model2k: self controller fast2kModel;
		yourself
]
