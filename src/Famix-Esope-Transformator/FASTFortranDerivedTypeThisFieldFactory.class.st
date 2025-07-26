Class {
	#name : 'FASTFortranDerivedTypeThisFieldFactory',
	#superclass : 'FASTFortranDerivedTypeParameterFieldFactory',
	#category : 'Famix-Esope-Transformator-Segment',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Segment'
}

{ #category : 'entity-creation' }
FASTFortranDerivedTypeThisFieldFactory >> createSegcmdFieldDeclaration [

	^self model newVariableDeclarationStatement
		addDeclarator: (self model newVariableDeclarator name: name) ;
		declaredType: (self model newUserDefinedType name: self privateDerivedTypeFactory name)
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeThisFieldFactory >> createSegcmdInFieldDeclaration [

	^self createSegcmdFieldDeclaration
		modifiers: { FASTFortran2kPointerModifier new . FASTFortran2kParameterIntent new isIn: true } ;
		yourself
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeThisFieldFactory >> createSegcmdInoutFieldDeclaration [

	^self createSegcmdFieldDeclaration
		modifiers: { FASTFortran2kPointerModifier new . FASTFortran2kParameterIntent new isIn: true ; isOut: true } ;
		yourself
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeThisFieldFactory >> createSeginiFieldInitialization [

	^self model newFunctionCallStatement
		name: 'allocate' ;
		addArgument: (self scalarVariable: name) ;
		yourself
		
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeThisFieldFactory >> createSegmentFieldDeclaration [
	"do not generate a declaration for 'this' field in the derivedType definition"
	
	^nil
]

{ #category : 'testing' }
FASTFortranDerivedTypeThisFieldFactory >> isAllocatable [ 

	^true
]

{ #category : 'testing' }
FASTFortranDerivedTypeThisFieldFactory >> isSegmentThisParameter [

	^true
]

{ #category : 'entity-creation' }
FASTFortranDerivedTypeThisFieldFactory >> makeDeallocateStatement [

	^self 
		functionCallStatement: 'deallocate'
		arguments: {
			self scalarVariable: name
		}
		
]
