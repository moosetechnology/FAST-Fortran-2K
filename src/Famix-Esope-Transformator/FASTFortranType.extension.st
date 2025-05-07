Extension { #name : 'FASTFortranType' }

{ #category : '*Famix-Esope-Transformator' }
FASTFortranType >> ioDefaultFormatForRead [
	"used in 'read' statement as default format
	for more information, follow the link: 	https://www.intel.com/content/www/us/en/docs/fortran-compiler/developer-guide-reference/2023-1/format-specifications.html
	"

	^ '*'
]

{ #category : '*Famix-Esope-Transformator' }
FASTFortranType >> ioDefaultFormatForWrite [
	"used in 'print', 'write' statement as default format
	for more information, follow the link: 	https://www.intel.com/content/www/us/en/docs/fortran-compiler/developer-guide-reference/2023-1/format-specifications.html "

	^ '*'
]
