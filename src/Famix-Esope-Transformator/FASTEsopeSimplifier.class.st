"
I simplify an ESOPE AST before migrating it to Fortran2k (`FamixEsopeToFortran2k`)

I have rules to simplify the code (ex: instruction not migrated, deadcode,...) and apply them until there is no more simplifications possible.

"
Class {
	#name : 'FASTEsopeSimplifier',
	#superclass : 'Object',
	#category : 'Famix-Esope-Transformator-Simplification',
	#package : 'Famix-Esope-Transformator',
	#tag : 'Simplification'
}
