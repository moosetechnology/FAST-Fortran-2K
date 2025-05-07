Class {
	#name : 'BaselineOfFASTFortran2k',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfFASTFortran2k',
	#package : 'BaselineOfFASTFortran2k'
}

{ #category : 'baselines' }
BaselineOfFASTFortran2k >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec description: 'FAST Fortran 2003/2008'.
		self defineDependencies: spec.
		self definePackages: spec.
		self defineGroups: spec ]
]

{ #category : 'baselines' }
BaselineOfFASTFortran2k >> defineDependencies: spec [

	spec
		baseline: 'CarrefourEsope'
		with: [ spec
				repository: 'github://moosetechnology/Carrefour-Esope:main' ]
]

{ #category : 'baselines' }
BaselineOfFASTFortran2k >> defineGroups: spec [
	
	spec
		group: 'default' with: #( 'core' );
		group: 'core' with: #( 'FAST-Fortran2k-Entities' 'FAST-Fortran2k-Visitors' 'Famix-Esope-Transformator' );
		group: 'all' with: #( core 'FAST-Fortran2k-Generator' 'FAST-Fortran2k-Visitors-Tests' 'Famix-Esope-Transformator-Tests' )
]

{ #category : 'baselines' }
BaselineOfFASTFortran2k >> definePackages: spec [

	spec
		package: 'FAST-Fortran2k-Generator'
		with: [ spec requires: #( 'CarrefourEsope' ) ];
		package: 'FAST-Fortran2k-Entities'
		with: [ spec requires: #( 'CarrefourEsope' ) ];
		package: 'Famix-Esope-Transformator'
		with: [ spec requires: #( 'FAST-Fortran2k-Entities' 'CarrefourEsope' ) ];
		package: 'Famix-Esope-Transformator-Tests'
		with: [ spec requires: #( 'Famix-Esope-Transformator' ) ];
		package: 'FAST-Fortran2k-Visitors-Tests'
		with: [ spec requires: #( 'Famix-Esope-Transformator' ) ]
]
