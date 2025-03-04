Class {
	#name : 'FASTFortranDerivedTypeFieldFactory',
	#superclass : 'Object',
	#instVars : [
		'name',
		'derivedTypeFactory'
	],
	#category : 'Famix-Esope-Transformator-Segment',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Segment'
}

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFieldFactory >> assignement: variable value: expression [

	^derivedTypeFactory assignement: variable value: expression
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFieldFactory >> comment: aString [

	^derivedTypeFactory comment: aString
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFieldFactory >> derivedTypeFactory: aFactory [

	derivedTypeFactory := aFactory
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFieldFactory >> derivedTypeFieldAccessVariable: instanceName field: fieldName [

	^derivedTypeFactory derivedTypeFieldAccessVariable: instanceName field: fieldName
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFieldFactory >> do: condition body: statements [

	^derivedTypeFactory do: condition body: statements
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFieldFactory >> fast2kModel [
	"for polymorphism with FamixEsopeToFortran2k"

	^self model
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFieldFactory >> formattedCode: aString values: values [

	^derivedTypeFactory formattedCode: aString values: values
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFieldFactory >> functionCall: aString arguments: arguments [

	^derivedTypeFactory functionCall: aString arguments: arguments
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFieldFactory >> functionCallStatement: aString arguments: arguments [

	^derivedTypeFactory functionCallStatement: aString arguments: arguments
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFieldFactory >> if: condition then: statements [

	^derivedTypeFactory if: condition then: statements
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFieldFactory >> literal: anObject [

	^derivedTypeFactory literal: anObject
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFieldFactory >> makeDeallocateStatement [

	self isAllocatable ifFalse: [ ^nil ].

	^self 
		functionCallStatement: 'deallocate'
		arguments: {
			self derivedTypeFieldAccessVariable: 'this' field: name
		}
		
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFieldFactory >> model [

	^derivedTypeFactory model
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFieldFactory >> name [

	^name 
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFieldFactory >> name: aString [

	name := aString 
]

{ #category : 'accessing - private tests' }
FASTFortranDerivedTypeFieldFactory >> privateDerivedTypeFactory [

	^derivedTypeFactory
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFieldFactory >> scalarVariable: variableName [

	^derivedTypeFactory scalarVariable: variableName
]
