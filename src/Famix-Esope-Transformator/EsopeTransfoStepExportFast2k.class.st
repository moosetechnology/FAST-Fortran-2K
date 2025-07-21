"
Last step of transformation Esope to FASTfortran2k, export the models in Fortran-2008
Done by `FASTFortran2kExporter`
"
Class {
	#name : 'EsopeTransfoStepExportFast2k',
	#superclass : 'EsopeTransfoAbstractStep',
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'running' }
EsopeTransfoStepExportFast2k class >> description [ 

		^'Export the migrated fast2k model'
]

{ #category : 'accessing' }
EsopeTransfoStepExportFast2k >> fast2kModel [

	^self controller fast2kModel
]

{ #category : 'running' }
EsopeTransfoStepExportFast2k >> run [ 

	FASTFortran2kExporter on: self fast2kModel
]
