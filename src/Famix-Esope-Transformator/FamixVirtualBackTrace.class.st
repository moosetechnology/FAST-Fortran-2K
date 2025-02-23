Class {
	#name : 'FamixVirtualBackTrace',
	#superclass : 'Object',
	#instVars : [
		'startLine',
		'endLine'
	],
	#category : 'Famix-Esope-Transformator',
	#package : 'Famix-Esope-Transformator'
}

{ #category : 'accessing' }
FamixVirtualBackTrace >> endLine [

	^ endLine
]

{ #category : 'accessing' }
FamixVirtualBackTrace >> endLine: anObject [

	endLine := anObject
]

{ #category : 'accessing' }
FamixVirtualBackTrace >> startLine [

	^ startLine
]

{ #category : 'accessing' }
FamixVirtualBackTrace >> startLine: anInt [
	startLine := anInt
]
