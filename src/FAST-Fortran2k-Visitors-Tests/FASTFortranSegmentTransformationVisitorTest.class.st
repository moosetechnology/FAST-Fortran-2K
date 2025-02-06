"
A FASTFortranSegmentTransformationVisitorTest is a test class for testing the behavior of FASTFortranSegmentTransformationVisitor
"
Class {
	#name : 'FASTFortranSegmentTransformationVisitorTest',
	#superclass : 'FASTFortranAbstractTransformationVisitorTest',
	#category : 'FAST-Fortran2k-Visitors-Tests',
	#package : 'FAST-Fortran2k-Visitors-Tests'
}

{ #category : 'running' }
FASTFortranSegmentTransformationVisitorTest >> newVisitor [

	^FASTFortranSegmentTransformationVisitor new
		parentVisitor: FASTFortranTransformationVisitor new
]

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
	
	self assert: f2ksegment derivedTypeComponents size equals: 1.
	
	stmt := f2ksegment derivedTypeComponents anyOne.
	self assert: stmt class equals: FASTFortran2kDerivedTypeComponent.
	self assert: stmt type class equals: FASTFortran2kIntegerType.
	self assert: stmt declarators size equals: 1.
	
	stmt := stmt declarators first.
	self assert: stmt class equals: FASTFortran2kVariableDeclarator.
	self assert: stmt name equals: 'bar'.
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
	
	self assert: f2ksegment derivedTypeComponents size equals: 2.
	
	stmt := f2ksegment derivedTypeComponents first.
	self assert: stmt class equals: FASTFortran2kDerivedTypeComponent.
	self assert: stmt type class equals: FASTFortran2kIntegerType.
	self assert: stmt declarators size equals: 1.
	self assert: stmt declarators anyOne class equals: FASTFortran2kVariableDeclarator.
	self assert: stmt declarators anyOne name equals: 'N'.
	
	stmt := f2ksegment derivedTypeComponents second.
	self assert: stmt class equals: FASTFortran2kDerivedTypeComponent.
	self assert: stmt type class equals: FASTFortran2kIntegerType.
	self assert: stmt declarators size equals: 1.
	
	stmt := stmt declarators first.
	self assert: stmt class equals: FASTFortran2kVariableDeclarator.
	self assert: stmt name equals: 'bar'.
]

{ #category : 'running' }
FASTFortranSegmentTransformationVisitorTest >> testEsopeTwoSegmentsInTwoModules [

		"
--- someFile.seg ----
   subroutine _$fakesubroutine
	segment foo
	end segment

	segment bar
	end segment
	end


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

	| stmt res f2ksegment segment_foo segment_bar fastFakesubroutine |

	self skip: '#TODO: remove this test or improving it to handle segment in programFile ? '.

	segment_foo := self segment: 'foo' attributes: #().
	segment_bar := self segment: 'bar' attributes: #().

	fastFakesubroutine := self subroutine: '_$fakesubroutine'.
	fastFakesubroutine statementBlock: (self statementBlock: {segment_foo . segment_bar }).
	
	fastProgramFile addProgramUnit: fastFakesubroutine.

	res := fastProgramFile accept: visitor.

	self assert: res class equals: FASTFortran2kModule.
	self assert: res name equals: 'foo_m'.
	
	f2ksegment := res statementBlock statements detect: [ :e | e class = FASTFortran2kDerivedTypeDefinition ].
	
	self assert: f2ksegment name equals: 'foo'.
	
	self assert: f2ksegment derivedTypeComponents size equals: 1.
	
	stmt := f2ksegment derivedTypeComponents anyOne.
	self assert: stmt class equals: FASTFortran2kDerivedTypeComponent.
	self assert: stmt type class equals: FASTFortran2kIntegerType.
	self assert: stmt declarators size equals: 1.
	
	stmt := stmt declarators first.
	self assert: stmt class equals: FASTFortran2kVariableDeclarator.
	self assert: stmt name equals: 'bar'.
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
	
	res := visitor model allWithSubTypesOf: (FASTFortran2kModule).
	self assert: res size equals: 1.
	
	res := res anyOne.

	self assert: res class equals: FASTFortran2kModule.
	self assert: res name equals: 'foo_mod'.
	
	f2ksegment := res statementBlock statements detect: [ :e | e class = FASTFortran2kDerivedTypeDefinition ].
	
	self assert: f2ksegment name equals: 'foo'.
	self assert: f2ksegment derivedTypeComponents size equals: 0.
]

{ #category : 'running' }
FASTFortranSegmentTransformationVisitorTest >> testProcedureWithTowSegmentsInTwoModules [

		"
--- someFile.f ----
   subroutine sub
	segment foo
	end segment

	segment bar
	end segment
	end


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

	self flag: '#FIXME: the order of module is unpredictable. how to fix this '.

	self subroutineWithTwoSegment.

	fastProcedures anyOne accept: visitor.

	modules := visitor model allWithSubTypesOf: (FASTFortran2kModule).
	self assert: modules size equals: 2.
	
	res := modules first.

	self assert: res class equals: FASTFortran2kModule.
	self assert: res name equals: 'foo_mod'.
	
	f2ksegment := res statementBlock statements detect: [ :e | e class = FASTFortran2kDerivedTypeDefinition ].
	
	self assert: f2ksegment name equals: 'foo'.
	self assert: f2ksegment derivedTypeComponents size equals: 0.

	res := modules second.

	self assert: res class equals: FASTFortran2kModule.
	self assert: res name equals: 'bar_mod'.
	
	f2ksegment := res statementBlock statements detect: [ :e | e class = FASTFortran2kDerivedTypeDefinition ].
	
	self assert: f2ksegment name equals: 'bar'.
	self assert: f2ksegment derivedTypeComponents size equals: 0.
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
	
	res := visitor model allWithSubTypesOf: (FASTFortran2kModule).
	self assert: res size equals: 1.
	
	res := res anyOne.

	self assert: res class equals: FASTFortran2kModule.
	self assert: res name equals: 'foo_mod'.
	
	f2ksegment := res statementBlock statements detect: [ :e | e class = FASTFortran2kDerivedTypeDefinition ].
	
	self assert: f2ksegment name equals: 'foo'.
	
	self assert: f2ksegment derivedTypeComponents size equals: 0.
]
