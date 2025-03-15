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
FASTEsopeObsoleteCommandRule >> visitFASTEsopeSegact: aFASTEsopeSegact [

	self
		substituteStatementNode: aFASTEsopeSegact
		withNode: (self commentOut: 'obsolete' statement: aFASTEsopeSegact)

]

{ #category : 'visiting - statements' }
FASTEsopeObsoleteCommandRule >> visitFASTEsopeSegdes: aFASTEsopeSegdes [

	self
		substituteStatementNode: aFASTEsopeSegdes
		withNode: (self commentOut: 'obsolete' statement: aFASTEsopeSegdes)

]

{ #category : 'visiting - statements' }
FASTEsopeObsoleteCommandRule >> visitFASTFortranCallStatement: aFASTFortranCallStatement [

	(self invocationsToIgnore includes: aFASTFortranCallStatement name)
		ifTrue: [
			self
				substituteStatementNode: aFASTFortranCallStatement
				withNode: (self commentOut: 'obsolete' statement: aFASTFortranCallStatement)
		]
]
