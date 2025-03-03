"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestFamixEsopeTransformator',
	#superclass : 'PackageManifest',
	#category : 'Famix-Esope-Transformator-Manifest',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestFamixEsopeTransformator class >> ruleCollectionMessagesToExternalObjectRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#FASTFortranDerivedTypeFactory)) #'2025-02-25T20:04:30.200798+01:00') )
]

{ #category : 'code-critics' }
ManifestFamixEsopeTransformator class >> ruleCollectionProtocolRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#FASTFortranDerivedTypeFactory)) #'2025-02-25T18:34:20.651239+01:00') )
]

{ #category : 'code-critics' }
ManifestFamixEsopeTransformator class >> ruleGuardingClauseRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#FASTFortranDerivedTypeComponentFieldFactory #makeSegprtDo:of: #false)) #'2025-02-25T19:11:40.859094+01:00') )
]

{ #category : 'code-critics' }
ManifestFamixEsopeTransformator class >> ruleLongMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#FASTFortranDerivedTypeFactory)) #'2025-02-25T17:54:51.13185+01:00') )
]

{ #category : 'code-critics' }
ManifestFamixEsopeTransformator class >> ruleReGuardClauseRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#FASTFortranDerivedTypeComponentFieldFactory #makeSegprtDo:of: #false)) #'2025-02-25T19:11:37.405821+01:00') )
]

{ #category : 'code-critics' }
ManifestFamixEsopeTransformator class >> ruleStringConcatenationRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#FASTFortranDerivedTypeFactory)) #'2025-03-03T19:07:17.252041+01:00') )
]
