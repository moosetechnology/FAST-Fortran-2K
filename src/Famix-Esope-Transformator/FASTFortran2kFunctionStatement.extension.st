Extension { #name : 'FASTFortran2kFunctionStatement' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortran2kFunctionStatement >> migratedModuleName [

	^self statementContainer fastBehaviouralParent migratedModuleName
]
