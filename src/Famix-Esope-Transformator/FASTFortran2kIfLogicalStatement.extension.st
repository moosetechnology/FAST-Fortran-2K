Extension { #name : 'FASTFortran2kIfLogicalStatement' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kIfLogicalStatement >> substituteStatementNode: aFASTStatement withNode: aFASTReplacement [
	"will replace aFASTStatement in #statement by aFASTReplacement"

	self statement: aFASTReplacement 
]
