Extension { #name : 'FASTFortranIfLogicalStatement' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortranIfLogicalStatement >> substituteStatementNode: aFASTStatement withNode: aFASTReplacement [
	"will replace aFASTStatement in #statement by aFASTReplacement"

	self statement: aFASTReplacement 
]
