"
## Properties
======================

| Name | Type | Default value | Comment |
|---|
| `endPos` | `Number` | nil | |
| `startPos` | `Number` | nil | |

"
Class {
	#name : 'FASTFortran2kEntity',
	#superclass : 'MooseEntity',
	#traits : 'FASTTEntity',
	#classTraits : 'FASTTEntity classTrait',
	#category : 'FAST-Fortran2k-Entities-Entities',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Entities'
}

{ #category : 'meta' }
FASTFortran2kEntity class >> annotation [

	<FMClass: #Entity super: #MooseEntity>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	<abstract>
	^ self
]

{ #category : 'testing' }
FASTFortran2kEntity class >> isAbstract [

	<generated>
	^ self == FASTFortran2kEntity
]

{ #category : 'meta' }
FASTFortran2kEntity class >> metamodel [

	<generated>
	^ FASTFortran2kModel metamodel
]

{ #category : 'testing' }
FASTFortran2kEntity >> isAssignment [

	<generated>
	^ false
]

{ #category : 'testing' }
FASTFortran2kEntity >> isBehaviouralEntity [

	<generated>
	^ false
]

{ #category : 'testing' }
FASTFortran2kEntity >> isBinaryExpression [

	<generated>
	^ false
]

{ #category : 'testing' }
FASTFortran2kEntity >> isBooleanLiteral [

	<generated>
	^ false
]

{ #category : 'testing' }
FASTFortran2kEntity >> isCharacterLiteral [

	<generated>
	^ false
]

{ #category : 'testing' }
FASTFortran2kEntity >> isExpression [

	<generated>
	^ false
]

{ #category : 'testing' }
FASTFortran2kEntity >> isLiteral [

	<generated>
	^ false
]

{ #category : 'testing' }
FASTFortran2kEntity >> isNumericalLiteral [

	<generated>
	^ false
]

{ #category : 'testing' }
FASTFortran2kEntity >> isQueryable [

	<generated>
	^ false
]

{ #category : 'testing' }
FASTFortran2kEntity >> isReturnStatement [

	<generated>
	^ false
]

{ #category : 'testing' }
FASTFortran2kEntity >> isScopableEntity [

	<generated>
	^ false
]

{ #category : 'testing' }
FASTFortran2kEntity >> isStatement [

	<generated>
	^ false
]

{ #category : 'testing' }
FASTFortran2kEntity >> isStatementBlock [

	<generated>
	^ false
]

{ #category : 'testing' }
FASTFortran2kEntity >> isUnaryExpression [

	<generated>
	^ false
]

{ #category : 'testing' }
FASTFortran2kEntity >> isVariableEntity [

	<generated>
	^ false
]
