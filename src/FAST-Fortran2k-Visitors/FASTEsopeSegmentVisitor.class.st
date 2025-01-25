Class {
	#name : 'FASTEsopeSegmentVisitor',
	#superclass : 'FASTFortranModelTransformationVisitor',
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'visiting - statements' }
FASTEsopeSegmentVisitor >> visitDeclarationDimension: aFASTExpression [
	"We consider lowerBound is not possible from Esope segment"

	aFASTExpression upperBound class = FASTFortranScalarVariable
		ifFalse: [ ^ nil ].

	^ FASTFortran2kDerivedTypeComponent new
		  type: FASTFortran2kIntegerType new;
		  declarators: { (FASTFortran2kVariableDeclarator new name:
					   aFASTExpression upperBound name) }
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

	variableDeclaration := FASTFortran2kDerivedTypeComponent new.

	variableDeclaration type:
		(aFASTFortranVariableDeclarationStatement declaredType accept: self).
	variableDeclaration declarators:
		(aFASTFortranVariableDeclarationStatement declarators collect: [
			 :declartor | "thenReject: #isNil" declartor accept: self ]).
	declarationStatements add: variableDeclaration.

	^ declarationStatements
]
