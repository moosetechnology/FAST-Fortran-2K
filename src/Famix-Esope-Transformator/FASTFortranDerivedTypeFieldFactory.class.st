Class {
	#name : 'FASTFortranDerivedTypeFieldFactory',
	#superclass : 'Object',
	#instVars : [
		'name',
		'type',
		'rank',
		'dimensions',
		'isSegmentParameter',
		'derivedTypeFactory'
	],
	#category : 'Famix-Esope-Transformator-Segment',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Segment'
}

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFieldFactory >> createComponentDeclaration [

	^isSegmentParameter
		ifTrue: [ self createSegmentParameterDeclaration ]
		ifFalse: [ self createSegmentComponentDeclaration ]
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFieldFactory >> createSegmentComponentDeclaration [

	^self model newDerivedTypeComponent
		addDeclarator: (self model newVariableDeclarator name: name) ;
		rank: rank ;
		declaredType: (type accept: (FASTFortranBehavioralTransformationVisitor new parentTransformator: self))
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeFieldFactory >> createSegmentParameterDeclaration [

	^self model newDerivedTypeParameter
		addDeclarator: (self model newVariableDeclarator name: name) ;
		declaredType: self model newIntegerType
]

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
FASTFortranDerivedTypeFieldFactory >> fieldDeclarator: aFastFortranVariableDeclarator [

	name := aFastFortranVariableDeclarator name.
	rank := aFastFortranVariableDeclarator dimensions size.
	isSegmentParameter := false
]

{ #category : 'accessing - private tests' }
FASTFortranDerivedTypeFieldFactory >> isSegmentParameter: anObject [

	isSegmentParameter := anObject
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFieldFactory >> model [

	^derivedTypeFactory model
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFieldFactory >> type: declaredType [

	type := declaredType
]
