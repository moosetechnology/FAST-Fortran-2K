"
This trait is used by Famix models.
It provides an API for creating entities and adding them to the model.


"
Trait {
	#name : 'FASTFortran2kTEntityCreator',
	#category : 'FAST-Fortran2k-Entities-Model',
	#package : 'FAST-Fortran2k-Entities',
	#tag : 'Model'
}

{ #category : 'meta' }
FASTFortran2kTEntityCreator classSide >> annotation [

	<FMClass: #TEntityCreator super: #Object>
	<package: #'FAST-Fortran2k-Entities'>
	<generated>
	^ self
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newAbstractExpression [

	<generated>
	^ self add: FASTFortran2kAbstractExpression new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newAbstractIOStatement [

	<generated>
	^ self add: FASTFortran2kAbstractIOStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newAbstractLiteral [

	<generated>
	^ self add: FASTFortran2kAbstractLiteral new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newAbstractStatement [

	<generated>
	^ self add: FASTFortran2kAbstractStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newAcceptStatement [

	<generated>
	^ self add: FASTFortran2kAcceptStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newAmpersand [

	<generated>
	^ self add: FASTFortran2kAmpersand new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newArrayRange [

	<generated>
	^ self add: FASTFortran2kArrayRange new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newArrayVariable [

	<generated>
	^ self add: FASTFortran2kArrayVariable new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newAssignmentExpression [

	<generated>
	^ self add: FASTFortran2kAssignmentExpression new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newAssignmentStatement [

	<generated>
	^ self add: FASTFortran2kAssignmentStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newAsterisk [

	<generated>
	^ self add: FASTFortran2kAsterisk new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newAutomaticStatement [

	<generated>
	^ self add: FASTFortran2kAutomaticStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newBackspaceStatement [

	<generated>
	^ self add: FASTFortran2kBackspaceStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newBinaryExpression [

	<generated>
	^ self add: FASTFortran2kBinaryExpression new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newBlockData [

	<generated>
	^ self add: FASTFortran2kBlockData new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newBooleanLiteral [

	<generated>
	^ self add: FASTFortran2kBooleanLiteral new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newByteType [

	<generated>
	^ self add: FASTFortran2kByteType new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newCallStatement [

	<generated>
	^ self add: FASTFortran2kCallStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newCharacterLiteral [

	<generated>
	^ self add: FASTFortran2kCharacterLiteral new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newCharacterType [

	<generated>
	^ self add: FASTFortran2kCharacterType new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newClassDeclarationStatement [

	<generated>
	^ self add: FASTFortran2kClassDeclarationStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newCloseStatement [

	<generated>
	^ self add: FASTFortran2kCloseStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newComment [

	<generated>
	^ self add: FASTFortran2kComment new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newCommonGroup [

	<generated>
	^ self add: FASTFortran2kCommonGroup new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newCommonStatement [

	<generated>
	^ self add: FASTFortran2kCommonStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newComplexLiteral [

	<generated>
	^ self add: FASTFortran2kComplexLiteral new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newComplexType [

	<generated>
	^ self add: FASTFortran2kComplexType new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newConditionalStatement [

	<generated>
	^ self add: FASTFortran2kConditionalStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newContinueStatement [

	<generated>
	^ self add: FASTFortran2kContinueStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDataGroup [

	<generated>
	^ self add: FASTFortran2kDataGroup new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDataStatement [

	<generated>
	^ self add: FASTFortran2kDataStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDecodeStatement [

	<generated>
	^ self add: FASTFortran2kDecodeStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDerivedTypeAbstractField [

	<generated>
	^ self add: FASTFortran2kDerivedTypeAbstractField new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDerivedTypeComponent [

	<generated>
	^ self add: FASTFortran2kDerivedTypeComponent new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDerivedTypeComponentAccess [

	<generated>
	^ self add: FASTFortran2kDerivedTypeComponentAccess new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDerivedTypeComponentDimension [

	<generated>
	^ self add: FASTFortran2kDerivedTypeComponentDimension new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDerivedTypeDeclaration [

	<generated>
	^ self add: FASTFortran2kDerivedTypeDeclaration new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDerivedTypeDefinition [

	<generated>
	^ self add: FASTFortran2kDerivedTypeDefinition new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDerivedTypeParameter [

	<generated>
	^ self add: FASTFortran2kDerivedTypeParameter new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDimensionStatement [

	<generated>
	^ self add: FASTFortran2kDimensionStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDoStatement [

	<generated>
	^ self add: FASTFortran2kDoStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDoWhileStatement [

	<generated>
	^ self add: FASTFortran2kDoWhileStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDoubleComplexLiteral [

	<generated>
	^ self add: FASTFortran2kDoubleComplexLiteral new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDoubleComplexType [

	<generated>
	^ self add: FASTFortran2kDoubleComplexType new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDoublePrecisionLiteral [

	<generated>
	^ self add: FASTFortran2kDoublePrecisionLiteral new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newDoublePrecisionType [

	<generated>
	^ self add: FASTFortran2kDoublePrecisionType new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newElseStatement [

	<generated>
	^ self add: FASTFortran2kElseStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newEmptyStatement [

	<generated>
	^ self add: FASTFortran2kEmptyStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newEncodeStatement [

	<generated>
	^ self add: FASTFortran2kEncodeStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newEndFileStatement [

	<generated>
	^ self add: FASTFortran2kEndFileStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newEntryStatement [

	<generated>
	^ self add: FASTFortran2kEntryStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newEquivalenceGroup [

	<generated>
	^ self add: FASTFortran2kEquivalenceGroup new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newEquivalenceStatement [

	<generated>
	^ self add: FASTFortran2kEquivalenceStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newExitStatement [

	<generated>
	^ self add: FASTFortran2kExitStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newExternalStatement [

	<generated>
	^ self add: FASTFortran2kExternalStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newFieldAccess [

	<generated>
	^ self add: FASTFortran2kFieldAccess new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newFormatStatement [

	<generated>
	^ self add: FASTFortran2kFormatStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newFormattedCodeString [

	<generated>
	^ self add: FASTFortran2kFormattedCodeString new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newFunction [

	<generated>
	^ self add: FASTFortran2kFunction new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newFunctionCall [

	<generated>
	^ self add: FASTFortran2kFunctionCall new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newFunctionCallStatement [

	<generated>
	^ self add: FASTFortran2kFunctionCallStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newFunctionReturnStatement [

	<generated>
	^ self add: FASTFortran2kFunctionReturnStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newFunctionStatement [

	<generated>
	^ self add: FASTFortran2kFunctionStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newFunctionTypeDeclarationStatement [

	<generated>
	^ self add: FASTFortran2kFunctionTypeDeclarationStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newGoToAssignedStatement [

	<generated>
	^ self add: FASTFortran2kGoToAssignedStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newGoToComputedStatement [

	<generated>
	^ self add: FASTFortran2kGoToComputedStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newGoToStatement [

	<generated>
	^ self add: FASTFortran2kGoToStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newIModuleProcedureSummary [

	<generated>
	^ self add: FASTFortran2kIModuleProcedureSummary new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newIOParameter [

	<generated>
	^ self add: FASTFortran2kIOParameter new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newIfArithmeticStatement [

	<generated>
	^ self add: FASTFortran2kIfArithmeticStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newIfBlockStatement [

	<generated>
	^ self add: FASTFortran2kIfBlockStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newIfLogicalStatement [

	<generated>
	^ self add: FASTFortran2kIfLogicalStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newImplicitRange [

	<generated>
	^ self add: FASTFortran2kImplicitRange new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newImplicitStatement [

	<generated>
	^ self add: FASTFortran2kImplicitStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newImplicitTypingRule [

	<generated>
	^ self add: FASTFortran2kImplicitTypingRule new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newImpliedDoExpression [

	<generated>
	^ self add: FASTFortran2kImpliedDoExpression new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newImportStatement [

	<generated>
	^ self add: FASTFortran2kImportStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newIncludeStatement [

	<generated>
	^ self add: FASTFortran2kIncludeStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newInquireStatement [

	<generated>
	^ self add: FASTFortran2kInquireStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newIntegerLiteral [

	<generated>
	^ self add: FASTFortran2kIntegerLiteral new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newIntegerType [

	<generated>
	^ self add: FASTFortran2kIntegerType new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newInterface [

	<generated>
	^ self add: FASTFortran2kInterface new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newInterfaceProcedure [

	<generated>
	^ self add: FASTFortran2kInterfaceProcedure new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newInternalFunction [

	<generated>
	^ self add: FASTFortran2kInternalFunction new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newInternalSubroutine [

	<generated>
	^ self add: FASTFortran2kInternalSubroutine new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newIntrinsicStatement [

	<generated>
	^ self add: FASTFortran2kIntrinsicStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newLabelReference [

	<generated>
	^ self add: FASTFortran2kLabelReference new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newLogicalType [

	<generated>
	^ self add: FASTFortran2kLogicalType new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newLoopControlExpression [

	<generated>
	^ self add: FASTFortran2kLoopControlExpression new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newMapStatement [

	<generated>
	^ self add: FASTFortran2kMapStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newModifier [

	<generated>
	^ self add: FASTFortran2kModifier new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newModule [

	<generated>
	^ self add: FASTFortran2kModule new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newNameEntity [

	<generated>
	^ self add: FASTFortran2kNameEntity new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newNameListStatement [

	<generated>
	^ self add: FASTFortran2kNameListStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newNumericalConstant [

	<generated>
	^ self add: FASTFortran2kNumericalConstant new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newOpenStatement [

	<generated>
	^ self add: FASTFortran2kOpenStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newOptionsStatement [

	<generated>
	^ self add: FASTFortran2kOptionsStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newPTVariable [

	<generated>
	^ self add: FASTFortran2kPTVariable new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newParameterStatement [

	<generated>
	^ self add: FASTFortran2kParameterStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newPauseStatement [

	<generated>
	^ self add: FASTFortran2kPauseStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newPointerAssignmentStatement [

	<generated>
	^ self add: FASTFortran2kPointerAssignmentStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newPointerVariable [

	<generated>
	^ self add: FASTFortran2kPointerVariable new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newPragmaStatement [

	<generated>
	^ self add: FASTFortran2kPragmaStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newPrintStatement [

	<generated>
	^ self add: FASTFortran2kPrintStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newPrivateStatement [

	<generated>
	^ self add: FASTFortran2kPrivateStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newProcedure [

	<generated>
	^ self add: FASTFortran2kProcedure new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newProgramFile [

	<generated>
	^ self add: FASTFortran2kProgramFile new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newProgramMain [

	<generated>
	^ self add: FASTFortran2kProgramMain new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newProgramUnit [

	<generated>
	^ self add: FASTFortran2kProgramUnit new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newPublicStatement [

	<generated>
	^ self add: FASTFortran2kPublicStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newReadStatement [

	<generated>
	^ self add: FASTFortran2kReadStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newRealLiteral [

	<generated>
	^ self add: FASTFortran2kRealLiteral new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newRealType [

	<generated>
	^ self add: FASTFortran2kRealType new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newReturnStatement [

	<generated>
	^ self add: FASTFortran2kReturnStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newRewindStatement [

	<generated>
	^ self add: FASTFortran2kRewindStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newSaveStatement [

	<generated>
	^ self add: FASTFortran2kSaveStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newScalarVariable [

	<generated>
	^ self add: FASTFortran2kScalarVariable new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newSourceCodeString [

	<generated>
	^ self add: FASTFortran2kSourceCodeString new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newStatementBlock [

	<generated>
	^ self add: FASTFortran2kStatementBlock new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newStaticStatement [

	<generated>
	^ self add: FASTFortran2kStaticStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newStopStatement [

	<generated>
	^ self add: FASTFortran2kStopStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newSubprogram [

	<generated>
	^ self add: FASTFortran2kSubprogram new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newSubroutine [

	<generated>
	^ self add: FASTFortran2kSubroutine new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newSubstring [

	<generated>
	^ self add: FASTFortran2kSubstring new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newTargetVariable [

	<generated>
	^ self add: FASTFortran2kTargetVariable new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newType [

	<generated>
	^ self add: FASTFortran2kType new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newTypeBoundProcedure [

	<generated>
	^ self add: FASTFortran2kTypeBoundProcedure new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newTypePBFinal [

	<generated>
	^ self add: FASTFortran2kTypePBFinal new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newUnaryExpression [

	<generated>
	^ self add: FASTFortran2kUnaryExpression new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newUnionStatement [

	<generated>
	^ self add: FASTFortran2kUnionStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newUseNoRenamedStatement [

	<generated>
	^ self add: FASTFortran2kUseNoRenamedStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newUseOnlyStatement [

	<generated>
	^ self add: FASTFortran2kUseOnlyStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newUseRenamedStatement [

	<generated>
	^ self add: FASTFortran2kUseRenamedStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newUseStatement [

	<generated>
	^ self add: FASTFortran2kUseStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newUserDefinedType [

	<generated>
	^ self add: FASTFortran2kUserDefinedType new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newVariable [

	<generated>
	^ self add: FASTFortran2kVariable new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newVariableDeclarationStatement [

	<generated>
	^ self add: FASTFortran2kVariableDeclarationStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newVariableDeclarator [

	<generated>
	^ self add: FASTFortran2kVariableDeclarator new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newVirtualStatement [

	<generated>
	^ self add: FASTFortran2kVirtualStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newVolatileStatement [

	<generated>
	^ self add: FASTFortran2kVolatileStatement new
]

{ #category : 'entity creation' }
FASTFortran2kTEntityCreator >> newWriteStatement [

	<generated>
	^ self add: FASTFortran2kWriteStatement new
]
