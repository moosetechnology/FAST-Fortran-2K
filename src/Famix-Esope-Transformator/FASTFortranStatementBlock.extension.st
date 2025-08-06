Extension { #name : 'FASTFortranStatementBlock' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortranStatementBlock >> substituteStatementNode: aFASTStatement withNode: aFASTReplacement [
	"will replace aFASTStatement in #statements by aFASTReplacement
	 the order of statements need to be kept and we must keep in mind that putting a node in #statements
	 has ripple effect on the node itself through Famix slots automatic actions
	 Also need to drop the old FASTStatement from the model"

	| tempList |

	aFASTReplacement startPos: aFASTStatement startPos.
	aFASTReplacement endPos: aFASTStatement endPos.

	tempList := Array withAll: statements.
	tempList
		at: (tempList indexOf: aFASTStatement)
		put: aFASTReplacement.

	aFASTStatement mooseModel remove: aFASTStatement.

	self statements: tempList 
]
