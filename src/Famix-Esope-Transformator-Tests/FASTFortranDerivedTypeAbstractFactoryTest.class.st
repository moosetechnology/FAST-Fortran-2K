Class {
	#name : 'FASTFortranDerivedTypeAbstractFactoryTest',
	#superclass : 'TestCase',
	#instVars : [
		'fastModel',
		'segFactory',
		'fast2kModel'
	],
	#category : 'Famix-Esope-Transformator-Tests-Segment',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Segment'
}

{ #category : 'running' }
FASTFortranDerivedTypeAbstractFactoryTest >> makeFactory: factoryClass [

	| factory |
	factory := factoryClass new.
	factory derivedTypeFactory: segFactory.
	factory privateDerivedTypeFactory model: fast2kModel.
	
	segFactory fields add: factory.

	^factory
]

{ #category : 'running' }
FASTFortranDerivedTypeAbstractFactoryTest >> setUp [

	super setUp.

	fastModel := FASTEsopeModel new.
	fast2kModel := FASTFortran2kModel new.

	segFactory := FASTFortranDerivedTypeFactory new
		model: fast2kModel ;
		fields: #()

]
