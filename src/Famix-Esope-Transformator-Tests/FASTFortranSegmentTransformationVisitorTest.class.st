"
A FASTFortranSegmentTransformationVisitorTest is a test class for testing the behavior of FASTFortranSegmentTransformationVisitor
"
Class {
	#name : 'FASTFortranSegmentTransformationVisitorTest',
	#superclass : 'FASTEsopeAbstractTransformationVisitorTest',
	#category : 'Famix-Esope-Transformator-Tests-Visitors',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Visitors'
}

{ #category : 'running' }
FASTFortranSegmentTransformationVisitorTest >> testEsopeSegmentToDerivedTypeInModule [
	"
	segment foo
	integer bar
	end segment
	"

	| stmt res f2ksegment |

	stmt := self segment: 'foo' attributes: { #bar -> #integer }.
	
	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kModule.
	self assert: res name equals: 'foo_mod'.
	
	f2ksegment := res statementBlock statements detect: [ :e | e class = FASTFortran2kDerivedTypeDefinition ].
	
	self assert: f2ksegment name equals: 'foo'.
	
	self assert: f2ksegment statements size equals: 1.
	
	stmt := f2ksegment statements anyOne.
	self assert: stmt class equals: FASTFortran2kVariableDeclarationStatement.
	self assert: stmt declaredType class equals: FASTFortran2kIntegerType.
	self assert: stmt declarators size equals: 1.
	self assert: stmt declarators anyOne name equals: 'bar'.
	self assert: stmt declarators anyOne dimensions size equals: 0.
	
]

{ #category : 'running' }
FASTFortranSegmentTransformationVisitorTest >> testEsopeSegmentWithArrayFieldToDerivedTypeInModule [
	"
	segment foo
	integer bar(N)
	end segment
	"

	| stmt res f2ksegment |

	stmt := self segment: 'foo' attributes: { #bar -> #integer }.
	stmt statements anyOne declarators anyOne
		dimensions: { FASTFortranArrayRange new upperBound: (self scalarVariable: #N) }.

	res := stmt accept: visitor.

	self assert: res class equals: FASTFortran2kModule.
	self assert: res name equals: 'foo_mod'.

	f2ksegment := res statementBlock statements detect: [ :e | e class = FASTFortran2kDerivedTypeDefinition ].

	self assert: f2ksegment name equals: 'foo'.

	self assert: f2ksegment statements size equals: 2.
	f2ksegment statements do: [ :statement | self assert: statement class equals: FASTFortran2kVariableDeclarationStatement ].

	stmt := f2ksegment statements detect: [ :each | each declarators anyOne name = 'N' ].
	self assert: stmt declaredType class equals: FASTFortran2kIntegerType.

	stmt := f2ksegment statements detect: [ :each | each declarators anyOne name = 'bar' ].
	self assert: stmt declaredType class equals: FASTFortran2kIntegerType.
	self assert: stmt declarators anyOne dimensions size equals: 1.

]

{ #category : 'running' }
FASTFortranSegmentTransformationVisitorTest >> testFunctionWithSegment [
	"
	integer fct()
	  segment foo
	  end segment
	end function fct
----
module someFile_mod
	implicit none
contains
	integer function fct()
	end function fct
end module someFile_mod

module foo_mod
	implicit none
	...
	type :: foo
	...
	end type foo
	...
end module foo_mod
	"

	| res f2ksegment |
	
	self functionWithSegment.

	fastProcedures anyOne accept: visitor.
	
	res := visitor model2k allWithSubTypesOf: (FASTFortran2kModule).
	self assert: res size equals: 1.
	
	res := res anyOne.

	self assert: res class equals: FASTFortran2kModule.
	self assert: res name equals: 'foo_mod'.
	
	f2ksegment := res statementBlock statements detect: [ :e | e class = FASTFortran2kDerivedTypeDefinition ].
	
	self assert: f2ksegment name equals: 'foo'.
	self assert: f2ksegment statements size equals: 0.
]

{ #category : 'running' }
FASTFortranSegmentTransformationVisitorTest >> testProcedureWithTowSegmentsInTwoModules [

		"
---- foo_mod.f90 -----
module foo_mod
	...
   type :: foo
   		...
   end type foo
	...
end module foo_mod


---- bar_mod.f90 -----
module bar_mod
	...
   type :: bar
   		...
   end type bar
	...
end module bar_mod
	"

	| modules res f2ksegment  |

	self subroutineWithTwoSegment.

	fastProcedures anyOne accept: visitor.

	modules := visitor model2k allWithSubTypesOf: FASTFortran2kModule.
	self assert: modules size equals: 2.
	
	res := modules
		detect: [:mod | mod name = 'foo_mod']
		ifNone: [ self fail ] .

	f2ksegment := res statementBlock statements detect: [ :e | e class = FASTFortran2kDerivedTypeDefinition ].
	
	self assert: f2ksegment name equals: 'foo'.
	self assert: f2ksegment statements size equals: 0.

	res := modules
		detect: [:mod | mod name = 'bar_mod']
		ifNone: [ self fail ] .

	f2ksegment := res statementBlock statements detect: [ :e | e class = FASTFortran2kDerivedTypeDefinition ].
	
	self assert: f2ksegment name equals: 'bar'.
	self assert: f2ksegment statements size equals: 0.
]

{ #category : 'running' }
FASTFortranSegmentTransformationVisitorTest >> testProgramWithSegment [
	"
	program main
	segment foo
	end segment
	end
----
program main
	implicit none
end program main

module foo_mod
	implicit none
	...
	type :: foo
	...
	end type foo
	...
end module foo_mod
	"

	| res f2ksegment |
	
	self programWithSegment.

	fastMainProgram accept: visitor.
	
	res := visitor model2k allWithSubTypesOf: (FASTFortran2kModule).
	self assert: res size equals: 1.
	
	res := res anyOne.

	self assert: res class equals: FASTFortran2kModule.
	self assert: res name equals: 'foo_mod'.
	
	f2ksegment := res statementBlock statements detect: [ :e | e class = FASTFortran2kDerivedTypeDefinition ].
	
	self assert: f2ksegment name equals: 'foo'.
	
	self assert: f2ksegment statements size equals: 0.
]

{ #category : 'running' }
FASTFortranSegmentTransformationVisitorTest >> visitorClass [ 

	^FASTFortranSegmentTransformationVisitor
]
