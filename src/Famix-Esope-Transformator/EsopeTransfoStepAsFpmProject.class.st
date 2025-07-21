Class {
	#name : 'EsopeTransfoStepAsFpmProject',
	#superclass : 'EsopeTransfoAbstractStep',
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'accessing' }
EsopeTransfoStepAsFpmProject class >> description [ 

		^'Create FPM project'
]

{ #category : 'running' }
EsopeTransfoStepAsFpmProject >> run [ 

	Fortran2kExportAsFPMProject make
]
