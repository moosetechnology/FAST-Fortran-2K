Extension { #name : 'FASTFortran2kStatementBlock' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kStatementBlock >> substituteStatementNode: aFASTStatement withNode: aFASTReplacement [
	"will replace aFASTStatement in #statements by aFASTReplacement
	 the order of statements need to be kept and we must keep in mind that putting a node in #statements
	 has ripple effect on the node itself through Famix slots automatic actions"

	| tempList |

	tempList := Array withAll: statements.
	tempList
		at: (tempList indexOf: aFASTStatement)
		put: aFASTReplacement.

	self statements: tempList 
]
