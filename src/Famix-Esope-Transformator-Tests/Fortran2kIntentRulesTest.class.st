Class {
	#name : 'Fortran2kIntentRulesTest',
	#superclass : 'TestCase',
	#instVars : [
		'famixParamF77',
		'famixInvocation',
		'secondaryFamixRtn'
	],
	#category : 'Famix-Esope-Transformator-Tests-Visitors',
	#package : 'Famix-Esope-Transformator-Tests',
	#tag : 'Visitors'
}

{ #category : 'running' }
Fortran2kIntentRulesTest >> buildModel [

	"model: primaryFamixRtn with one parameter passed as 2nd parameter to secondaryFamixRtn"

	| primaryFamixRtn secondaryFamixParameter callStatement |

	primaryFamixRtn := FamixF77PUSubroutine new.
	secondaryFamixRtn := FamixF77PUSubroutine new.

	famixParamF77 := FamixF77Parameter new name: 'param'.
	primaryFamixRtn addParameter: famixParamF77.

	secondaryFamixParameter := FamixF77Parameter new
		name: 'secondaryParam1'.
	secondaryFamixParameter propertyNamed: #intent put: (FASTFortran2kParameterIntent new).
	secondaryFamixRtn addParameter: secondaryFamixParameter.

	secondaryFamixParameter := FamixF77Parameter new
		name: 'secondaryParam2'.
	secondaryFamixParameter propertyNamed: #intent put: (FASTFortran2kParameterIntent new).
	secondaryFamixRtn addParameter: secondaryFamixParameter.

	famixInvocation := FamixF77Invocation new.
	famixInvocation candidates: { secondaryFamixRtn }.
	primaryFamixRtn addOutgoingInvocation: famixInvocation.

	callStatement := FASTFortranCallStatement new
		name: 'secondaryRoutine'.
	callStatement addArgument: (FASTFortranIntegerLiteral new).
	callStatement addArgument: (FASTFortranScalarVariable new
		name: 'param' ;
		famixParameter: famixParamF77).
	callStatement famix: famixInvocation 

]

{ #category : 'running' }
Fortran2kIntentRulesTest >> computeIntent: famixParamF77 [

	Fortran2kIntentAbstractRule checkAllRulesFor: famixParamF77 
]

{ #category : 'tests' }
Fortran2kIntentRulesTest >> testParametersIntentFirstIsWrite [

	| intent |

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
Fortran2kIntentRulesTest >> testParametersIntentFromAccessNotOverriding [
	"An intent value already set is not overriden by the Fortran2kAccessRule"

	| intent |

	famixParamF77 := FamixF77Parameter new.
	famixParamF77 propertyNamed: #intent put: (FASTFortran2kParameterIntent new isOut: true).

	self computeIntent: famixParamF77.

	intent := famixParamF77 propertyNamed: #intent.
 
	self deny: intent isNil.
	self deny: intent isIn.
	self assert: intent isOut.

]

{ #category : 'tests' }
Fortran2kIntentRulesTest >> testParametersIntentFromAllRead [

	| intent |

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

	| intent |

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

	| intent |
	famixParamF77 := FamixF77Parameter new.

	self computeIntent: famixParamF77.

	intent := famixParamF77 propertyNamed: #intent.
 
	self deny: intent isNil.
	self deny: intent isIn.
	self deny: intent isOut.

]

{ #category : 'tests' }
Fortran2kIntentRulesTest >> testParametersIntentFromReadAndWrite [

	| intent |

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
Fortran2kIntentRulesTest >> testParametersIntentFromSecondary [
	"1st parameter of secondaryFamixRtn is OUT, 2nd parameter is IN,
	 famixParamF77 should be IN"

	| intent |

	self buildModel.
	(secondaryFamixRtn parameters first propertyNamed: #intent) isOut: true.
	(secondaryFamixRtn parameters second propertyNamed: #intent) isIn: true.

	self computeIntent: famixParamF77.

	intent := famixParamF77 propertyNamed: #intent.
 
	self deny: intent isNil.
	self assert: intent isIn.
	self deny: intent isOut.

]

{ #category : 'tests' }
Fortran2kIntentRulesTest >> testParametersIntentSpecialInvocationInoutRule [

	| intent |

	self buildModel.
	famixInvocation fast name: 'ajpnt'.

	self computeIntent: famixParamF77.

	intent := famixParamF77 propertyNamed: #intent.
 
	self deny: intent isNil.
	self assert: intent isIn.
	self assert: intent isOut.

]

{ #category : 'tests' }
Fortran2kIntentRulesTest >> testParametersIntentSpecialInvocationOutRule [

	|  intent |

	self buildModel.
	famixInvocation fast name: 'inistr'.

	self computeIntent: famixParamF77.

	intent := famixParamF77 propertyNamed: #intent.
 
	self deny: intent isNil.
	self deny: intent isIn.
	self assert: intent isOut.

]

{ #category : 'tests' }
Fortran2kIntentRulesTest >> testParametersIntentSpecialInvocationRuleNot [

	|  intent |

	self buildModel.
	self computeIntent: famixParamF77.

	intent := famixParamF77 propertyNamed: #intent.
 
	self deny: intent isNil.
	self deny: intent isIn.
	self deny: intent isOut.

]
