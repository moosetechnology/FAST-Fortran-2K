Class {
	#name : 'Fortran2kIntentRulesTest',
	#superclass : 'TestCase',
	#category : 'Famix-Esope-Transformator-Tests-Visitors',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Visitors'
}

{ #category : 'running' }
Fortran2kIntentRulesTest >> computeIntent: famixParamF77 [

	Fortran2kIntentAbstractRule checkAllRulesOn: famixParamF77 
]

{ #category : 'tests' }
Fortran2kIntentRulesTest >> testParametersIntentFirstIsWrite [

	| famixParamF77 intent |
	famixParamF77 := FamixF77Parameter new.
	FamixF77Access new
		variable: famixParamF77 ;
		isWrite: false ;
		sourceAnchor: (FamixF77IndexedFileAnchor new propertyNamed: #startPos put: 42 ; yourself).
	FamixF77Access new
		variable: famixParamF77 ;
		isWrite: true ;
		sourceAnchor: (FamixF77IndexedFileAnchor new propertyNamed: #startPos put: 17 ; yourself).

	self computeIntent: famixParamF77.

	intent := famixParamF77 propertyNamed: #intent.
 
	self deny: intent isNil.
	self deny: intent isIn.
	self assert: intent isOut.

]

{ #category : 'tests' }
Fortran2kIntentRulesTest >> testParametersIntentFromAllRead [

	| famixParamF77 intent |
	famixParamF77 := FamixF77Parameter new.
	FamixF77Access new variable: famixParamF77.
	FamixF77Access new variable: famixParamF77 ; isWrite: false.

	self computeIntent: famixParamF77.

	intent := famixParamF77 propertyNamed: #intent.
 
	self deny: intent isNil.
	self assert: intent isIn.
	self deny: intent isOut.

]

{ #category : 'tests' }
Fortran2kIntentRulesTest >> testParametersIntentFromAllWrite [

	| famixParamF77 intent |
	famixParamF77 := FamixF77Parameter new.
	FamixF77Access new variable: famixParamF77 ; isWrite: true.
	FamixF77Access new variable: famixParamF77 ; isWrite: true.

	self computeIntent: famixParamF77.

	intent := famixParamF77 propertyNamed: #intent.
 
	self deny: intent isNil.
	self deny: intent isIn.
	self assert: intent isOut.

]

{ #category : 'tests' }
Fortran2kIntentRulesTest >> testParametersIntentFromNoAccesses [

	| famixParamF77 intent |
	famixParamF77 := FamixF77Parameter new.

	self computeIntent: famixParamF77.

	intent := famixParamF77 propertyNamed: #intent.
 
	self deny: intent isNil.
	self deny: intent isIn.
	self deny: intent isOut.

]

{ #category : 'tests' }
Fortran2kIntentRulesTest >> testParametersIntentFromReadAndWrite [

	| famixParamF77 intent |
	famixParamF77 := FamixF77Parameter new.
	FamixF77Access new variable: famixParamF77 ; isWrite: false.
	FamixF77Access new variable: famixParamF77 ; isWrite: true.

	self computeIntent: famixParamF77.

	intent := famixParamF77 propertyNamed: #intent.
 
	self deny: intent isNil.
	self assert: intent isIn.
	self assert: intent isOut.

]

{ #category : 'tests' }
Fortran2kIntentRulesTest >> testParametersIntentSpecialInvocationInoutRule [

	| famixParamF77 intent callStatement |
	famixParamF77 := FamixF77Parameter new name: 'param'.
	callStatement := FASTFortranCallStatement new
		name: 'ajpnt' ;
		famix: (FamixF77Invocation new).
	callStatement addArgument: (FASTFortranScalarVariable new
		name: 'param' ;
		famixParameter: famixParamF77).

	FamixF77PUSubroutine new
		addParameter: famixParamF77 ;
		addOutgoingInvocation: callStatement famix.

	self computeIntent: famixParamF77.

	intent := famixParamF77 propertyNamed: #intent.
 
	self deny: intent isNil.
	self assert: intent isIn.
	self assert: intent isOut.

]

{ #category : 'tests' }
Fortran2kIntentRulesTest >> testParametersIntentSpecialInvocationOutRule [

	| famixParamF77 intent callStatement |
	famixParamF77 := FamixF77Parameter new name: 'param'.
	callStatement := FASTFortranCallStatement new
		name: 'inistr' ;
		famix: (FamixF77Invocation new).
	callStatement addArgument: (FASTFortranScalarVariable new
		name: 'param' ;
		famixParameter: famixParamF77).

	FamixF77PUSubroutine new
		addParameter: famixParamF77 ;
		addOutgoingInvocation: callStatement famix.

	self computeIntent: famixParamF77.

	intent := famixParamF77 propertyNamed: #intent.
 
	self deny: intent isNil.
	self deny: intent isIn.
	self assert: intent isOut.

]

{ #category : 'tests' }
Fortran2kIntentRulesTest >> testParametersIntentSpecialInvocationRuleNot [

	| famixParamF77 intent callStatement |
	famixParamF77 := FamixF77Parameter new name: 'param'.
	callStatement := FASTFortranCallStatement new
		name: 'fct' ;
		famix: (FamixF77Invocation new).
	callStatement addArgument: (FASTFortranScalarVariable new
		name: 'param' ;
		famixParameter: famixParamF77).

	FamixF77PUSubroutine new
		addParameter: famixParamF77 ;
		addOutgoingInvocation: callStatement famix.

	self computeIntent: famixParamF77.

	intent := famixParamF77 propertyNamed: #intent.
 
	self deny: intent isNil.
	self deny: intent isIn.
	self deny: intent isOut.

]
