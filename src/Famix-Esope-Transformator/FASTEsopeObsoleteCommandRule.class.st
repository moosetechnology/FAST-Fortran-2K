Class {
	#name : 'FASTEsopeObsoleteCommandRule',
	#superclass : 'FASTEsopeAbstractSimplifyingRule',
	#category : 'Famix-Esope-Transformator-Simplification',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Simplification'
}

{ #category : 'accessing' }
FASTEsopeObsoleteCommandRule >> invocationsToIgnore [
	^#(oooeta actstr)
]

{ #category : 'visiting - statements' }
FASTEsopeObsoleteCommandRule >> visitFASTFortranCallStatement: aFASTFortranCallStatement [

	
]
