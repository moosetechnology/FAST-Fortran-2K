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
		self definePackages: spec.
		self defineDependencies: spec ]
]

{ #category : 'baselines' }
BaselineOfFASTFortran2k >> defineDependencies: spec [

	spec
		baseline: 'FAST-Fortran-Generator'
		with: [ spec
				loads: #('default');
				repository: 'github://moosetechnology/FAST-Fortran' ] ;

	baseline: 'FAST-Fortran-Entities'
		with: [ spec
				loads: #('default');
				repository: 'github://moosetechnology/FAST-Fortran' ] ;

	baseline: 'FAST-Fortran-Visitors'
		with: [ spec
				loads: #('default');
				repository: 'github://moosetechnology/FAST-Fortran' ] ;

	baseline: 'FAST-Fortran-Visitors-Tests'
		with: [ spec
				loads: #('default');
				repository: 'github://moosetechnology/FAST-Fortran' ]
]

{ #category : 'baselines' }
BaselineOfFASTFortran2k >> definePackages: spec [
	spec
		repository: 'https://github.com/moosetechnology/FAST-Fortran-2K';
		package: 'FAST-Fortran2k-Generator' with: [ spec requires: #('FAST-Fortran-Generator') ] ;
		package: 'FAST-Fortran2k-Entities' with: [ spec requires: #('FAST-Fortran-Entities') ];
		package: 'FAST-Fortran2k-Visitors' with: [ spec requires: #('FAST-Fortran-Visitors' 'FAST-Fortran2k-Entities') ];
		package: 'FAST-Fortran2k-Visitors-Tests' with: [ spec requires: #('FAST-Fortran-Visitors-Tests' 'FAST-Fortran2k-Visitors') ]
]
