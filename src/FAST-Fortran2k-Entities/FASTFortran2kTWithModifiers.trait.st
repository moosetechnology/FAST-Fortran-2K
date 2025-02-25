"
I represent a modifier for an entity. This entity can be:
 - a declaration (variable, typeDefinition, typeDeclaration, function)


possible value for [Modifier (*Attribute*)](https://staff.cs.manchester.ac.uk/~fumie/internal/RikenDocuments/Fortran_Language_Reference_en.pdf#%5B%7B%22num%22%3A813%2C%22gen%22%3A0%7D%2C%7B%22name%22%3A%22XYZ%22%7D%2Cnull%2C700.94073%2Cnull%5D) are:

  - **allocatable**: *the data object is an allocatable variable, but is to have memory allocated for it as specified during execution of the program*
  - **asynchronous**: *asynchronous input/output is used to handle variable*
  - **automatic**: *the data object to be on the stack*
  - **bind**: *the variable or common block is a C language variable with an external association and is interoperable*
  - **changeentry**: *the name is that of an external procedure except Fortran program*
  - **codimension**: *the data object is a coarray*
  - **contiguous**: *the array pointer or assumed shape array is CONTIGUOUS*
  - **dimension**: *the data object is an array*
  - **external**: *the name is that of an external procedure, a dummy procedure, or procedure pointer, and it can be used as an actual argument*
  - **intent**: *the dummy argument shall neither be defined nor become undefined in the procedure (INTENT(IN)), shall be defined before a reference and any actual argument that becomes associated with such a dummy argument shall be definable (INTENT(OUT)), or is intended for use both to receive data from and to return data to the invoking scoping unit (INTENT(INOUT))*
  - **intrinsic**: *the name is that of an intrinsic procedure*
  - **optional**: *the dummy argument need not have a corresponding actual argument in a reference to the procedure in which the dummy argument appears*
  - **parameter**: *the data object is a named constant*
  - **pointer**: *the data object is a pointer*
  - **private**: *The named data object, a procedure or a type in a MODULE program unit is accessible only in the current module*
  - **protected**: *The named variable is specified in a MODULE program unit, the part in the useful range by use association where the variable can be modified is limited*
  - **public**: *The named data object, a procedure or a type in a MODULE program unit is accessible in a program unit that uses that module*
  - **save**: *The data object retains its value, definition status, association status, and allocation status after a RETURN or END statement*
  - **static**: *The data object to be in static memory*
  - **target**: *The data object that is to be associated with a pointer*
  - **value**: *The dummy argument to be associated with a definable temporary area whose initial value is that of the actual argument. Neither the value nor the changes in the definition status for the dummy argument influence the actual argument*
  - **volatile**: *The data object is prevented optimization*


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `modifiers` | `Object` | #() | A collection of modifiers (strings)|

"
Trait {
	#name : 'FASTFortran2kTWithModifiers',
	#instVars : [
		'#modifiers => FMProperty defaultValue: #()'
	],
	#category : 'FAST-Fortran2k-Entities-Traits',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Traits'
}

{ #category : 'meta' }
FASTFortran2kTWithModifiers classSide >> annotation [

	<FMClass: #TWithModifiers super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kTWithModifiers >> modifiers [

	<FMProperty: #modifiers type: #Object defaultValue: #()>
	<generated>
	<FMComment: 'A collection of modifiers (strings)'>
	^ modifiers ifNil: [ modifiers := #() ]
]

{ #category : 'accessing' }
FASTFortran2kTWithModifiers >> modifiers: anObject [
	<generated>
	modifiers := anObject
]
