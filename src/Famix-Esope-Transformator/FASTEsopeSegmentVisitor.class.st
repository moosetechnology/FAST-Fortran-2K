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
