Class {
	#name : 'EsopeTransfoStepResolveUses',
	#superclass : 'EsopeTransfoAbstractStep',
	#category : 'Famix-Esope-Transformator-Main',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Main'
}

{ #category : 'accessing' }
EsopeTransfoStepResolveUses class >> description [ 

	^'Resolve uses statements in program unit'
]

{ #category : 'running' }
EsopeTransfoStepResolveUses >> run [ 

	"usesNeeded is a collection of associations:
	 - fmxUser -- a FamixF77ProgramUnit
	 - fmxNeeded -- a FamixF77ProgramUnit or FamixEsopeSegment"

	self usesNeeded do: [ :association | | fmxUser fmxNeeded |
		fmxUser := association key.
		fmxNeeded := association value.

		fmxUser fast transformed2k useSource
			addUse: (fmxNeeded migratedModuleName)
	]
]

{ #category : 'accessing' }
EsopeTransfoStepResolveUses >> usesNeeded [

	^self controller usesNeeded 
]
