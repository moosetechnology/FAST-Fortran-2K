"
A FASTFortran2kUseResolverTest is a test class for testing the behavior of FASTFortran2kUseResolver
"
Class {
	#name : 'FASTFortran2kUseResolverTest',
	#superclass : 'TestCase',
	#instVars : [
		'model'
	],
	#category : 'FAST-Fortran2k-Visitors-Tests-Resolver',
	#package : 'FAST-Fortran2k-Visitors-Tests',
	#tag : 'Resolver'
}

{ #category : 'running' }
FASTFortran2kUseResolverTest >> setUp [
	super setUp.

	"Put here a common initialization logic for tests"
	
	model := FASTFortran2kModel new name: 'model to resolve'
]

{ #category : 'tests' }
FASTFortran2kUseResolverTest >> testAddUseInProgramMain [
" 
program main
	implicit none
	call sub() ! We need to find out where the sub module is located.
end program main

-----
program main 
	use :: someFile_mod ! 
	implicit none
	call sub()
end program main
"

	| programMain res |
	programMain := (model newProgramMain name: 'main')
		statementBlock: (model newStatementBlock statements: { 
			model newImplicitStatement.
			model newCallStatement name: 'sub'; arguments: #()
		}
	).
		
	(model newProgramFile filename: 'main.f90') addProgramUnit: programMain.

	self assert: programMain statementBlock statements size equals: 2.

	FASTFortran2kUseResolver runOn: model.
	
	self assert: programMain statementBlock statements size equals: 3.
	
	res := programMain statementBlock statements last.
	self assert: res class equals: FASTFortran2kUseStatement.


	
	
]
