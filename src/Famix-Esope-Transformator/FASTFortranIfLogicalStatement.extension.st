Extension { #name : 'FASTFortranIfLogicalStatement' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortranIfLogicalStatement >> substituteStatementNode: aFASTStatement withNode: aFASTReplacement [
	"will replace aFASTStatement in #statement by aFASTReplacement"

	aFASTReplacement startPos: aFASTStatement startPos.
	aFASTReplacement endPos: aFASTStatement endPos.

	self statement: aFASTReplacement 
]
