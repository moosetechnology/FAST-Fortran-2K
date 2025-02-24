"
Creates a derived type from a segment
"
Class {
	#name : 'FASTEsopeSegmentVisitor',
	#superclass : 'FASTFortranBehavioralTransformationVisitor',
	#category : 'Famix-Esope-Transformator-Segment',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Segment'
}

{ #category : 'visiting - statements' }
FASTEsopeSegmentVisitor >> visitDeclarationDimension: aFASTExpression [
	"We consider lowerBound is not possible from Esope segment"

	aFASTExpression upperBound class = FASTFortranScalarVariable
		ifFalse: [ ^ nil ].

	^FASTFortran2kDerivedTypeComponent new
		declaredType: FASTFortran2kIntegerType new ;
		declarators: { (FASTFortran2kVariableDeclarator new name: aFASTExpression upperBound name) };
		yourself
]

{ #category : 'visiting - statements' }
FASTEsopeSegmentVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	| declarationStatements variableDeclaration |
	declarationStatements := OrderedCollection new.

	aFASTFortranVariableDeclarationStatement declarators do: [
		:declarator |
		declarator dimensions do: [ :declarationDimension |
			(self visitDeclarationDimension: declarationDimension) ifNotNil: [
				:f2kDim | declarationStatements add: f2kDim ] ] ].

	variableDeclaration := self model newDerivedTypeComponent.

	variableDeclaration declaredType:
		(aFASTFortranVariableDeclarationStatement declaredType accept: self).

	variableDeclaration declarators:
		(self visitFASTFortranList: aFASTFortranVariableDeclarationStatement declarators).
	declarationStatements add: variableDeclaration.

	^ declarationStatements
]
