"
A transformation step that does nothing (usefull for optional steps when they are not required)
"
Class {
	#name : 'EsopeTransfoStepNoop',
	#superclass : 'EsopeTransfoAbstractStep',
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'accessing' }
EsopeTransfoStepNoop class >> description [ 

	^'No-operation'
]

{ #category : 'running' }
EsopeTransfoStepNoop >> run [ 

	"does not do anything"
]
