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
		spec repository:
			'https://github.com/moosetechnology/FAST-Fortran-2K:main'.
		self definePackages: spec.
		self defineGroups: spec.
		self defineDependencies: spec ]
]

{ #category : 'baselines' }
BaselineOfFASTFortran2k >> defineDependencies: spec [

	spec
		baseline: 'FAST'
		with: [ spec
				loads: #('tools');
				repository: 'github://moosetechnology/FAST:v2/src' ] ;

		baseline: 'FASTEsope'
		with: [ spec
				loads: #('default');
				repository: 'github://moosetechnology/FAST-Esope' ];

		baseline: 'CarrefourEsope'
		with: [ spec
				loads: #('default');
				repository: 'github://moosetechnology/Carrefour-Esope:main' ]
]

{ #category : 'baselines' }
BaselineOfFASTFortran2k >> defineGroups: spec [

	^ spec
		  group: 'default' with: #( core );

		  group: 'core' with: #( 'FAST-Fortran2k-Entities' 'FAST-Fortran2k-Visitors' 'Famix-Esope-Transformator');
		  group: 'all' with: #( core 'FAST-Fortran2k-Generator' 'FAST-Fortran2k-Visitors-Tests' )
]

{ #category : 'baselines' }
BaselineOfFASTFortran2k >> definePackages: spec [

	spec
		package: 'FAST-Fortran2k-Generator'
		with: [ spec requires: #( FASTEsope ) ];
		package: 'FAST-Fortran2k-Entities'
		with: [ spec requires: #( FAST FASTEsope ) ];
		package: 'FAST-Fortran2k-Visitors'
		with: [ spec requires: #( FASTEsope 'FAST-Fortran2k-Entities' ) ];
		package: 'Famix-Esope-Transformator'
		with: [ spec requires: #( FASTEsope 'FAST-Fortran2k-Visitors' ) ];
		package: 'FAST-Fortran2k-Visitors-Tests'
		with: [ spec requires: #( FASTEsope 'FAST-Fortran2k-Visitors' ) ]
]
