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
ManifestFamixEsopeTransformator class >> ruleStringConcatenationRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#'Famix-Esope-Transformator')) #'2025-02-25T11:55:34.9047+01:00') )
]
