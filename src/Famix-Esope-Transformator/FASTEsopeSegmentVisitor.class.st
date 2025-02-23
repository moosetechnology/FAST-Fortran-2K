Class {
	#name : 'FASTEsopeSegmentVisitor',
	#superclass : 'FASTFortranTransformationVisitor',
	#category : 'Famix-Esope-Transformator',
	#package : 'Famix-Esope-Transformator'
}

{ #category : 'visiting - statements' }
FASTEsopeSegmentVisitor >> visitDeclarationDimension: aFASTExpression [
	"We consider lowerBound is not possible from Esope segment"

	aFASTExpression upperBound class = FASTFortranScalarVariable
		ifFalse: [ ^ nil ].

	^ self model newDerivedTypeParameter
		name: aFASTExpression upperBound name;
		declaredType: self model newIntegerType;
		yourself
]

{ #category : 'visiting - statements' }
FASTEsopeSegmentVisitor >> visitFASTFortranVariableDeclarationStatement: aFASTFortranVariableDeclarationStatement [

	| derivedTypeComponents derivedTypeParameters |

	derivedTypeParameters := 
		aFASTFortranVariableDeclarationStatement declarators flatCollect: [ :declarator |
			declarator dimensions collect: [ :declaratorDimension |
			(self visitDeclarationDimension: declaratorDimension) 
				ifNotNil: [ :f2kDim | f2kDim ] 
			] 
		].

	derivedTypeComponents := 
		aFASTFortranVariableDeclarationStatement declarators collect: [ :declarator |
			self model newDerivedTypeComponent
				name: declarator name;
				declaredType: (aFASTFortranVariableDeclarationStatement declaredType accept: self);
				rank: declarator dimensions size;
				yourself
		].

	^ derivedTypeParameters , derivedTypeComponents
]
