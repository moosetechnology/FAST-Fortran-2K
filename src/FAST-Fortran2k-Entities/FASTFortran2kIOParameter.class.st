"
I represent a specifier keywords used in I/O statement (open, write, read, close, ...).

where the most common specifiers are:

```fortran
    [UNIT=]  u
    IOSTAT=  ios
    ERR=     err
    FILE=    fname
    STATUS=  sta
    ACCESS=  acc
    FORM=    frm
    RECL=    rl
```
	
	

## Relations
======================

### Parents
| Relation | Origin | Opposite | Type | Comment |
|---|
| `invokedIn` | `FASTTNamedEntity` | `invoked` | `FASTTInvocation` | Optional invocation where this name is used|
| `parentIOStatement` | `FASTFortran2kTIOParameter` | `ioParameters` | `FASTFortran2kAbstractIOStatement` | |

### Children
| Relation | Origin | Opposite | Type | Comment |
|---|
| `expression` | `FASTFortran2kIOParameter` | `ioSpecifier` | `FASTTExpression` | value of the parameter (keyword argument)|


## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `name` | `String` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kIOParameter',
	#superclass : 'FASTFortran2kEntity',
	#traits : 'FASTFortran2kTIOParameter + FASTTNamedEntity',
	#classTraits : 'FASTFortran2kTIOParameter classTrait + FASTTNamedEntity classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kIOParameter class >> annotation [

	<FMClass: #IOParameter super: #FASTFortran2kEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'accessing' }
FASTFortran2kIOParameter >> expression [
	"Relation named: #expression type: #FASTTExpression opposite: #ioSpecifier"

	<generated>
	<FMComment: 'value of the parameter (keyword argument)'>
	<FMProperty: #expression type: #FASTTExpression opposite: #ioSpecifier>
	^ self attributeAt: #expression ifAbsent: [ nil ]
]

{ #category : 'accessing' }
FASTFortran2kIOParameter >> expression: anObject [

	<generated>
	(self attributeAt: #expression ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self expression.
		self attributeAt: #expression put: anObject.
		otherSide ioSpecifier: nil ]
	ifNotNil: [ 
		self attributeAt: #expression put: anObject.
		anObject ioSpecifier: self ]
]

{ #category : 'navigation' }
FASTFortran2kIOParameter >> expressionGroup [
	<generated>
	<navigation: 'Expression'>
	^ MooseSpecializedGroup with: self expression
]
