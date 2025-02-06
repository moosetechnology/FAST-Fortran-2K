Class {
	#name : 'FASTEsopeSegmentVisitor',
	#superclass : 'FASTFortranTransformationVisitor',
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'visiting - statements' }
FASTEsopeSegmentVisitor >> visitDeclarationDimension: aFASTExpression [
	"We consider lowerBound is not possible from Esope segment"

	aFASTExpression upperBound class = FASTFortranScalarVariable
		ifFalse: [ ^ nil ].

	^ self model newDerivedTypeComponent
		type: self model newIntegerType;
		declarators: { (self model newVariableDeclarator name: aFASTExpression upperBound name) };
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

	variableDeclaration type:
		(aFASTFortranVariableDeclarationStatement declaredType accept: self).
	variableDeclaration declarators:
		(aFASTFortranVariableDeclarationStatement declarators collect: [
			 :declartor | "thenReject: #isNil" declartor accept: self ]).
	declarationStatements add: variableDeclaration.

	^ declarationStatements
]
