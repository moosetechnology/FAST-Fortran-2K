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
		baseline: 'FASTFortranGenerator'
		with: [ spec
				loads: #('default');
				repository: 'github://moosetechnology/FAST-Fortran' ] ;

		baseline: 'FASTFortranEntities'
		with: [ spec
				loads: #('default');
				repository: 'github://moosetechnology/FAST-Fortran' ] ;

		baseline: 'FASTFortranVisitors'
		with: [ spec
				loads: #('default');
				repository: 'github://moosetechnology/FAST-Fortran' ] ;

		baseline: 'FASTFortranVisitorsTests'
		with: [ spec
				loads: #('default');
				repository: 'github://moosetechnology/FAST-Fortran' ]
]

{ #category : 'baselines' }
BaselineOfFASTFortran2k >> definePackages: spec [
	spec
		repository: 'https://github.com/moosetechnology/FAST-Fortran-2K';
		package: 'FAST-Fortran2k-Generator' with: [ spec requires: #(FASTFortranGenerator) ] ;
		package: 'FAST-Fortran2k-Entities' with: [ spec requires: #(FASTFortranEntities) ];
		package: 'FAST-Fortran2k-Visitors' with: [ spec requires: #(FASTFortranVisitors 'FAST-Fortran2k-Entities') ];
		package: 'FAST-Fortran2k-Visitors-Tests' with: [ spec requires: #(FASTFortranVisitorsTests 'FAST-Fortran2k-Visitors') ]
]
