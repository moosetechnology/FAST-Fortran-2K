Class {
	#name : 'FASTFortranDerivedTypeThisFieldFactory',
	#superclass : 'FASTFortranDerivedTypeParameterFieldFactory',
	#category : 'Famix-Esope-Transformator-Segment',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Segment'
}

{ #category : 'entity-creation' }
FASTFortranDerivedTypeThisFieldFactory >> createSeginiFieldDeclaration [

	^self model newVariableDeclarationStatement 
		"addModifier: 'pointer' ;
		addModifier: 'intent(inout)' ;"
		addDeclarator: (self model newVariableDeclarator name: 'this') ;
		declaredType: (self model newUserDefinedType name: self derivedTypeFactory name)
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeThisFieldFactory >> createSeginiFieldInitialization [

	^self model newFunctionCallStatement
		name: 'allocate' ;
		addArgument: (self model newScalarVariable name: 'this')
		
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeThisFieldFactory >> createSegmentFieldDeclaration [
	"do not generate a declaration for 'this' field in the derivedType definition"
	
	^nil
]

{ #category : 'testing' }
FASTFortranDerivedTypeThisFieldFactory >> isSegmentThisParameter [

	^true
]
