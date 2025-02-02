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

		baseline: 'FASTFortran'
		with: [ spec
				loads: #('all');
				repository: 'github://moosetechnology/FAST-Fortran' ]
]

{ #category : 'baselines' }
BaselineOfFASTFortran2k >> defineGroups: spec [

	^ spec
		  group: 'default' with: #( core );

		  group: 'core' with: #( 'FAST-Fortran2k-Entities' 'FAST-Fortran2k-Visitors' );
		  group: 'all' with: #( core 'FAST-Fortran2k-Generator' 'FAST-Fortran2k-Visitors-Tests' )
]

{ #category : 'baselines' }
BaselineOfFASTFortran2k >> definePackages: spec [

	spec
		package: 'FAST-Fortran2k-Generator'
		with: [ spec requires: #( FASTFortran ) ];
		package: 'FAST-Fortran2k-Entities'
		with: [ spec requires: #( FAST FASTFortran ) ];
		package: 'FAST-Fortran2k-Visitors'
		with: [ spec requires: #( FASTFortran 'FAST-Fortran2k-Entities' ) ];
		package: 'FAST-Fortran2k-Visitors-Tests'
		with: [ spec requires: #( FASTFortran 'FAST-Fortran2k-Visitors' ) ]
]
