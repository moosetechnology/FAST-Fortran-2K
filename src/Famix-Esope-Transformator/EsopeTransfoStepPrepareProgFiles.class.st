Class {
	#name : 'EsopeTransfoStepPrepareProgFiles',
	#superclass : 'EsopeTransfoAbstractStep',
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'accessing' }
EsopeTransfoStepPrepareProgFiles class >> description [ 

	^'Register program file names'
]

{ #category : 'running' }
EsopeTransfoStepPrepareProgFiles >> run [ 

	(self famixModel allWithType: FamixF77ProgramFile) do: [ :famixProgFile |
		famixProgFile fast:
			(FASTFortranProgramFile new filename: famixProgFile filename) ].

]
