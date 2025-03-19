"
An exporter for a FASTFortran2kModel. Will export all its ProgramFiles
"
Class {
	#name : 'FASTFortran2kExporter',
	#superclass : 'Object',
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'instance creation' }
FASTFortran2kExporter class >> on: aFASTFortran2kModel [

	^self new
		on: aFASTFortran2kModel
]

{ #category : 'instance creation' }
FASTFortran2kExporter >> on: aFASTFortran2kModel [
	"exports each ProgramFile"
	| visitor |

	(aFASTFortran2kModel allWithType: FASTFortran2kProgramFile)
		do: [ :programFile |
			visitor := FASTFortran2kProgramFileExporterVisitor new
				model: aFASTFortran2kModel.

			programFile filename asFileReference 
				writeStreamDo: [ :aStream | 
					programFile programUnits do: [ :programUnit | 
						programUnit accept: visitor.
						aStream << visitor outputStream contents withUnixLineEndings.
					]
				]
		]
]
