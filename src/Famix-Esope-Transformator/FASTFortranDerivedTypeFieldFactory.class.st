Class {
	#name : 'FASTFortranDerivedTypeFieldFactory',
	#superclass : 'Object',
	#instVars : [
		'name',
		'rank',
		'dimensions',
		'derivedTypeFactory'
	],
	#category : 'Famix-Esope-Transformator-Segment',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Segment'
}

{ #category : 'accessing - private tests' }
FASTFortranDerivedTypeFieldFactory >> derivedTypeFactory [

	^derivedTypeFactory
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFieldFactory >> derivedTypeFactory: aFactory [

	derivedTypeFactory := aFactory
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFieldFactory >> fast2kModel [
	"for polymorphism with FamixEsopeToFortran2k"

	^self model
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

{ #category : 'entity creation' }
FASTFortranDerivedTypeFieldFactory >> scalarVariable: variableName [

	^self derivedTypeFactory scalarVariable: variableName
]
