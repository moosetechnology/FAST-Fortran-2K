Extension { #name : 'FASTFortran2kModel' }

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kModel >> newModifier: aName [
	| nameLowercased |
	
	nameLowercased  := aName asSymbol asLowercase.

	self assert: (self validesModifiers includes: nameLowercased).

	^self add: (FASTFortran2kModifier new token: nameLowercased)
]

{ #category : '*FAST-Fortran2k-Visitors' }
FASTFortran2kModel >> validesModifiers [
	
	^#(
		allocatable "the data object is an allocatable variable, but is to have memory allocated for it as specified during execution of
the program"
		asynchronous "asynchronous input/output is used to handle variable"
		automatic "the data object to be on the stack"
		bind "the variable or common block is a C language variable with an external association and is interoperable"
		changeentry "the name is that of an external procedure except Fortran program"
		codimension "the data object is a coarray"
		contigious "the array pointer or assumed shape array is CONTIGUOUS"
		dimension "he data object is an array"
		external "the name is that of an external procedure, a dummy procedure, or procedure pointer, and it can be used as an actual argument"
		intent "the dummy argument shall neither be defined nor become undefined in the procedure (INTENT(IN)), shall be defined
before a reference and any actual argument that becomes associated with such a dummy argument shall be definable (INTENT(OUT)),
or is intended for use both to receive data from and to return data to the invoking scoping unit (INTENT(INOUT))"
		intrinsic "the name is that of an intrinsic procedure"
		optional "the dummy argument need not have a corresponding actual argument in a reference to the procedure in which the dummy argument appears"
		parameter "the data object is a named constant"
		pointer "the data object is a pointer"
		private "The named data object, a procedure or a type in a MODULE program unit is accessible only in the current module"
		protected "The named variable is specified in a MODULE program unit, the part in the useful range by use association where the variable can be modified is limited"
		public "The named data object, a procedure or a type in a MODULE program unit is accessible in a program unit that uses that module"
		save "The data object retains its value, definition status, association status, and allocation status after a RETURN or END statement"
		static "The data object to be in static memory"
		target "The data object that is to be associated with a pointer"
		value "The dummy argument to be associated with a definable temporary area whose initial value is that of the actual argument. Neither the value nor the changes in the definition status for the dummy argument influence the actual argume"
		volatile "The data object is prevented optimization"
	)
]
