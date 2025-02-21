Class {
	#name : 'FASTFortranDerivedTypeFactory',
	#superclass : 'Object',
	#instVars : [
		'name',
		'fields',
		'parameters',
		'model'
	],
	#category : 'Famix-Esope-Transformator-Segment',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Segment'
}

{ #category : 'api' }
FASTFortranDerivedTypeFactory >> createModule [

	| module |
	module := self model newModule name: name , '_mod'.

	module statementBlock:
		(FASTFortran2kStatementBlock new statements: {
				 self makeSegmentModuleProlog.
				 self makeTypeDefinition .
				 self makeSegmentTypeName .

				 self makeBoxedTypeDefinition .
				 self makeInterfaces .
				 self makeContainsStatement .
				 self makeProcedureIgnore .
				 self makeProcedureAssignPointerToPointer .
				 self makeProcedureSegmentType .

				 self makeProcedureSegini .
				 self makeProcedureSegcop .
				 self makeProcedureSegmov .
				 self makeProcedureSegadj .
				 self makeProcedureSegsup .
				 self makeProcedureSegprt .
				 self makeProcedureSegstore .
				 self makeProcedureSegload .
				 self makeProcedureSegpar .
				 self makeProcedureSeglik .
				 self makeProcedureSegloc .

				 self makeProcedureBoxed  }).
	^ module
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> fields: fastFortranDeclarations [

	fields := fastFortranDeclarations flatCollect: [ :fastVariableDeclaration |
		fastVariableDeclaration declarators collect: [ :fastVariableDeclarator |
			FASTFortranDerivedTypeFieldFactory new
				derivedTypeFactory: self ;
				type: fastVariableDeclaration declaredType ;
				fieldDeclarator: fastVariableDeclarator

		]
	]
]

{ #category : 'helpers - segment' }
FASTFortranDerivedTypeFactory >> makeSegmentModuleProlog [

	^ self model newSourceCodeString content: '
	use ignore_m
	use contract_m
	use segment_m
	use str_m

	implicit none
	private
'
]

{ #category : 'helpers - segment' }
FASTFortranDerivedTypeFactory >> makeTypeDefinition [

	| segment |
	segment := self model newDerivedTypeDefinition
		           name: name.

	fields do: [ :fieldFactory | segment addField: fieldFactory createComponentDeclaration ]

]

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> model: anObject [

	model := anObject
]

{ #category : 'accessing' }
FASTFortranDerivedTypeFactory >> name: anObject [

	name := anObject
]
