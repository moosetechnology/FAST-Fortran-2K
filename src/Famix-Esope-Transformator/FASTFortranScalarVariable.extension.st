Extension { #name : 'FASTFortranScalarVariable' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortranScalarVariable >> generateF2kDeclarationInModel: anF2kModel [

	^ anF2kModel newVariableDeclarationStatement
		  declaredType:
			  (self famixParameter declaredType generateF2kInModel: anF2kModel);
		  declarators:
			  { (anF2kModel newVariableDeclarator name: self name) };
		  modifiers: { (self famixParameter cacheAt: #intent) };
		  yourself
]
