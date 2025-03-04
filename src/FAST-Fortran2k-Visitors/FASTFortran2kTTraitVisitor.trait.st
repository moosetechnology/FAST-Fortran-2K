Trait {
	#name : 'FASTFortran2kTTraitVisitor',
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> acceptMeIfNotNil: aFamixEntity [
	<generated>

	^aFamixEntity ifNil: [ nil ] ifNotNil: [ aFamixEntity accept: self ]

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kAbstractExpression: aFASTFortran2kAbstractExpression [
	<generated>

	self visitFASTTExpression: aFASTFortran2kAbstractExpression.
	self acceptMeIfNotNil: aFASTFortran2kAbstractExpression parentArrayDimensionDeclarator.
	self acceptMeIfNotNil: aFASTFortran2kAbstractExpression parentArrayExpression.
	self acceptMeIfNotNil: aFASTFortran2kAbstractExpression parentDataStatement.
	self acceptMeIfNotNil: aFASTFortran2kAbstractExpression variableDeclaratorOwner.
	self acceptMeIfNotNil: aFASTFortran2kAbstractExpression assignementExpressionOwner.
	self acceptMeIfNotNil: aFASTFortran2kAbstractExpression parentGotoComputedStatement.
	self acceptMeIfNotNil: aFASTFortran2kAbstractExpression parentGotoAssignedStatement.
	self acceptMeIfNotNil: aFASTFortran2kAbstractExpression parentConditionalStatement.
	self acceptMeIfNotNil: aFASTFortran2kAbstractExpression parentLoopControlIncrement.
	self acceptMeIfNotNil: aFASTFortran2kAbstractExpression parentLoopControlLimit.
	self acceptMeIfNotNil: aFASTFortran2kAbstractExpression parentTypeSize.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kAbstractIOStatement: aFASTFortran2kAbstractIOStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kAbstractIOStatement.
	self visitList: aFASTFortran2kAbstractIOStatement ioParameters.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kAbstractLiteral: aFASTFortran2kAbstractLiteral [
	<generated>

	self visitFASTFortran2kAbstractExpression: aFASTFortran2kAbstractLiteral.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kAbstractStatement: aFASTFortran2kAbstractStatement [
	<generated>

	self visitFASTTStatement: aFASTFortran2kAbstractStatement.
	self acceptMeIfNotNil: aFASTFortran2kAbstractStatement parentIfStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kAcceptStatement: aFASTFortran2kAcceptStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kAcceptStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kAmpersand: aFASTFortran2kAmpersand [
	<generated>

	self visitFASTTCharacterLiteral: aFASTFortran2kAmpersand.
	self visitFASTFortran2kAbstractLiteral: aFASTFortran2kAmpersand.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kArrayRange: aFASTFortran2kArrayRange [
	<generated>

	self visitFASTFortran2kAbstractExpression: aFASTFortran2kArrayRange.
	self acceptMeIfNotNil: aFASTFortran2kArrayRange upperBound.
	self acceptMeIfNotNil: aFASTFortran2kArrayRange lowerBound.
	self acceptMeIfNotNil: aFASTFortran2kArrayRange parentVariableDeclarator.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kArrayVariable: aFASTFortran2kArrayVariable [
	<generated>

	self visitFASTFortran2kVariable: aFASTFortran2kArrayVariable.
	self visitList: aFASTFortran2kArrayVariable indices.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kAssignmentExpression: aFASTFortran2kAssignmentExpression [
	<generated>

	self visitFASTFortran2kTIOParameter: aFASTFortran2kAssignmentExpression.
	self visitFASTTAssignment: aFASTFortran2kAssignmentExpression.
	self visitFASTFortran2kAbstractExpression: aFASTFortran2kAssignmentExpression.
	self acceptMeIfNotNil: aFASTFortran2kAssignmentExpression parentLoopControlInitialization.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kAssignmentStatement: aFASTFortran2kAssignmentStatement [
	<generated>

	self visitFASTTAssignment: aFASTFortran2kAssignmentStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kAssignmentStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kAsterisk: aFASTFortran2kAsterisk [
	<generated>

	self visitFASTFortran2kTEntryArgument: aFASTFortran2kAsterisk.
	self visitFASTFortran2kIntegerLiteral: aFASTFortran2kAsterisk.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kAutomaticStatement: aFASTFortran2kAutomaticStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kAutomaticStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kBackspaceStatement: aFASTFortran2kBackspaceStatement [
	<generated>

	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kBackspaceStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kBinaryExpression: aFASTFortran2kBinaryExpression [
	<generated>

	self visitFASTTBinaryExpression: aFASTFortran2kBinaryExpression.
	self visitFASTFortran2kAbstractExpression: aFASTFortran2kBinaryExpression.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kBlockData: aFASTFortran2kBlockData [
	<generated>

	self visitFASTFortran2kSubprogram: aFASTFortran2kBlockData.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kBooleanLiteral: aFASTFortran2kBooleanLiteral [
	<generated>

	self visitFASTTBooleanLiteral: aFASTFortran2kBooleanLiteral.
	self visitFASTFortran2kAbstractLiteral: aFASTFortran2kBooleanLiteral.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kByteType: aFASTFortran2kByteType [
	<generated>

	self visitFASTFortran2kType: aFASTFortran2kByteType.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kCallStatement: aFASTFortran2kCallStatement [
	<generated>

	self visitFASTTWithArguments: aFASTFortran2kCallStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kCallStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kCharacterLiteral: aFASTFortran2kCharacterLiteral [
	<generated>

	self visitFASTFortran2kTFormat: aFASTFortran2kCharacterLiteral.
	self visitFASTTCharacterLiteral: aFASTFortran2kCharacterLiteral.
	self visitFASTFortran2kAbstractLiteral: aFASTFortran2kCharacterLiteral.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kCharacterType: aFASTFortran2kCharacterType [
	<generated>

	self visitFASTFortran2kType: aFASTFortran2kCharacterType.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kClassDeclarationStatement: aFASTFortran2kClassDeclarationStatement [
	<generated>

	self visitFASTFortran2kVariableDeclarationStatement: aFASTFortran2kClassDeclarationStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kCloseStatement: aFASTFortran2kCloseStatement [
	<generated>

	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kCloseStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kComment: aFASTFortran2kComment [
	<generated>

	self visitFASTTComment: aFASTFortran2kComment.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kComment.
	self acceptMeIfNotNil: aFASTFortran2kComment derivedTypeDefinition.
	self acceptMeIfNotNil: aFASTFortran2kComment derivedTypeComponent.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kCommonGroup: aFASTFortran2kCommonGroup [
	<generated>

	self visitFASTFortran2kTWithDeclarators: aFASTFortran2kCommonGroup.
	self visitFASTTNamedEntity: aFASTFortran2kCommonGroup.
	self acceptMeIfNotNil: aFASTFortran2kCommonGroup parentCommonStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kCommonStatement: aFASTFortran2kCommonStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kCommonStatement.
	self visitList: aFASTFortran2kCommonStatement groups.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kComplexLiteral: aFASTFortran2kComplexLiteral [
	<generated>

	self visitFASTFortran2kNumericalConstant: aFASTFortran2kComplexLiteral.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kComplexType: aFASTFortran2kComplexType [
	<generated>

	self visitFASTFortran2kType: aFASTFortran2kComplexType.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kConditionalStatement: aFASTFortran2kConditionalStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kConditionalStatement.
	self acceptMeIfNotNil: aFASTFortran2kConditionalStatement condition.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kContinueStatement: aFASTFortran2kContinueStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kContinueStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDataGroup: aFASTFortran2kDataGroup [
	<generated>

	self visitFASTFortran2kTVariableGroup: aFASTFortran2kDataGroup.
	self visitList: aFASTFortran2kDataGroup dataConstants.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDataStatement: aFASTFortran2kDataStatement [
	<generated>

	self visitFASTFortran2kTWithVariableGroups: aFASTFortran2kDataStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kDataStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDecodeStatement: aFASTFortran2kDecodeStatement [
	<generated>

	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kDecodeStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDerivedTypeAbstractField: aFASTFortran2kDerivedTypeAbstractField [
	<generated>

	self visitFASTFortran2kVariableDeclarationStatement: aFASTFortran2kDerivedTypeAbstractField.
	self acceptMeIfNotNil: aFASTFortran2kDerivedTypeAbstractField parentDerivedType.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDerivedTypeComponent: aFASTFortran2kDerivedTypeComponent [
	<generated>

	self visitFASTFortran2kDerivedTypeAbstractField: aFASTFortran2kDerivedTypeComponent.
	self visitList: aFASTFortran2kDerivedTypeComponent derivedTypeComponentDimensions.
	self acceptMeIfNotNil: aFASTFortran2kDerivedTypeComponent comment.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDerivedTypeComponentAccess: aFASTFortran2kDerivedTypeComponentAccess [
	<generated>

	self visitFASTFortran2kVariable: aFASTFortran2kDerivedTypeComponentAccess.
	self acceptMeIfNotNil: aFASTFortran2kDerivedTypeComponentAccess instance.
	self acceptMeIfNotNil: aFASTFortran2kDerivedTypeComponentAccess field.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDerivedTypeComponentDimension: aFASTFortran2kDerivedTypeComponentDimension [
	<generated>

	self visitFASTTNamedEntity: aFASTFortran2kDerivedTypeComponentDimension.
	self visitFASTFortran2kAbstractExpression: aFASTFortran2kDerivedTypeComponentDimension.
	self acceptMeIfNotNil: aFASTFortran2kDerivedTypeComponentDimension derivedTypeComponent.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDerivedTypeDeclaration: aFASTFortran2kDerivedTypeDeclaration [
	<generated>

	self visitFASTFortran2kVariableDeclarationStatement: aFASTFortran2kDerivedTypeDeclaration.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDerivedTypeDefinition: aFASTFortran2kDerivedTypeDefinition [
	<generated>

	self visitFASTTNamedEntity: aFASTFortran2kDerivedTypeDefinition.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kDerivedTypeDefinition.
	self visitList: aFASTFortran2kDerivedTypeDefinition fields.
	self visitList: aFASTFortran2kDerivedTypeDefinition typeBoundProcedures.
	self acceptMeIfNotNil: aFASTFortran2kDerivedTypeDefinition comment.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDerivedTypeParameter: aFASTFortran2kDerivedTypeParameter [
	<generated>

	self visitFASTFortran2kDerivedTypeAbstractField: aFASTFortran2kDerivedTypeParameter.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDimensionStatement: aFASTFortran2kDimensionStatement [
	<generated>

	self visitFASTFortran2kTWithDeclarators: aFASTFortran2kDimensionStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kDimensionStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDoStatement: aFASTFortran2kDoStatement [
	<generated>

	self visitFASTFortran2kTWithLabelReferences: aFASTFortran2kDoStatement.
	self visitFASTFortran2kTWithLoopControl: aFASTFortran2kDoStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kDoStatement.
	self acceptMeIfNotNil: aFASTFortran2kDoStatement statementBlock.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDoWhileStatement: aFASTFortran2kDoWhileStatement [
	<generated>

	self visitFASTFortran2kConditionalStatement: aFASTFortran2kDoWhileStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDoubleComplexLiteral: aFASTFortran2kDoubleComplexLiteral [
	<generated>

	self visitFASTFortran2kNumericalConstant: aFASTFortran2kDoubleComplexLiteral.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDoubleComplexType: aFASTFortran2kDoubleComplexType [
	<generated>

	self visitFASTFortran2kType: aFASTFortran2kDoubleComplexType.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDoublePrecisionLiteral: aFASTFortran2kDoublePrecisionLiteral [
	<generated>

	self visitFASTFortran2kNumericalConstant: aFASTFortran2kDoublePrecisionLiteral.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kDoublePrecisionType: aFASTFortran2kDoublePrecisionType [
	<generated>

	self visitFASTFortran2kType: aFASTFortran2kDoublePrecisionType.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kElseStatement: aFASTFortran2kElseStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kElseStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kEncodeStatement: aFASTFortran2kEncodeStatement [
	<generated>

	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kEncodeStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kEndFileStatement: aFASTFortran2kEndFileStatement [
	<generated>

	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kEndFileStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kEntity: aFASTFortran2kEntity [
	<generated>


]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kEntryStatement: aFASTFortran2kEntryStatement [
	<generated>

	self visitFASTTNamedEntity: aFASTFortran2kEntryStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kEntryStatement.
	self visitList: aFASTFortran2kEntryStatement entryArguments.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kEquivalenceGroup: aFASTFortran2kEquivalenceGroup [
	<generated>

	self visitFASTFortran2kTVariableGroup: aFASTFortran2kEquivalenceGroup.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kEquivalenceStatement: aFASTFortran2kEquivalenceStatement [
	<generated>

	self visitFASTFortran2kTWithVariableGroups: aFASTFortran2kEquivalenceStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kEquivalenceStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kExitStatement: aFASTFortran2kExitStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kExitStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kExternalStatement: aFASTFortran2kExternalStatement [
	<generated>

	self visitFASTTNamedEntity: aFASTFortran2kExternalStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kExternalStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kFieldAccess: aFASTFortran2kFieldAccess [
	<generated>

	self visitFASTFortran2kVariable: aFASTFortran2kFieldAccess.
	self acceptMeIfNotNil: aFASTFortran2kFieldAccess pointer.
	self acceptMeIfNotNil: aFASTFortran2kFieldAccess field.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kFormatStatement: aFASTFortran2kFormatStatement [
	<generated>

	self visitFASTFortran2kTWithFormat: aFASTFortran2kFormatStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kFormatStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kFormattedCodeString: aFASTFortran2kFormattedCodeString [
	<generated>

	self visitFASTFortran2kSourceCodeString: aFASTFortran2kFormattedCodeString.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kFunction: aFASTFortran2kFunction [
	<generated>

	self visitFASTFortran2kTDeclaredType: aFASTFortran2kFunction.
	self visitFASTFortran2kProcedure: aFASTFortran2kFunction.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kFunctionCall: aFASTFortran2kFunctionCall [
	<generated>

	self visitFASTTWithArguments: aFASTFortran2kFunctionCall.
	self visitFASTFortran2kAbstractExpression: aFASTFortran2kFunctionCall.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kFunctionReturnStatement: aFASTFortran2kFunctionReturnStatement [
	<generated>

	self visitFASTTNamedEntity: aFASTFortran2kFunctionReturnStatement.
	self visitFASTTReturnStatement: aFASTFortran2kFunctionReturnStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kFunctionStatement: aFASTFortran2kFunctionStatement [
	<generated>

	self visitFASTTNamedEntity: aFASTFortran2kFunctionStatement.
	self visitFASTTWithParameters: aFASTFortran2kFunctionStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kFunctionStatement.
	self acceptMeIfNotNil: aFASTFortran2kFunctionStatement expression.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kFunctionTypeDeclarationStatement: aFASTFortran2kFunctionTypeDeclarationStatement [
	<generated>

	self visitFASTFortran2kTDeclaredType: aFASTFortran2kFunctionTypeDeclarationStatement.
	self visitFASTTNamedEntity: aFASTFortran2kFunctionTypeDeclarationStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kFunctionTypeDeclarationStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kGoToAssignedStatement: aFASTFortran2kGoToAssignedStatement [
	<generated>

	self visitFASTFortran2kTWithLabelReferences: aFASTFortran2kGoToAssignedStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kGoToAssignedStatement.
	self acceptMeIfNotNil: aFASTFortran2kGoToAssignedStatement selectorExpression.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kGoToComputedStatement: aFASTFortran2kGoToComputedStatement [
	<generated>

	self visitFASTFortran2kTWithLabelReferences: aFASTFortran2kGoToComputedStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kGoToComputedStatement.
	self acceptMeIfNotNil: aFASTFortran2kGoToComputedStatement selectorExpression.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kGoToStatement: aFASTFortran2kGoToStatement [
	<generated>

	self visitFASTFortran2kTWithLabelReferences: aFASTFortran2kGoToStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kGoToStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kIModuleProcedureSummary: aFASTFortran2kIModuleProcedureSummary [
	<generated>

	self visitFASTFortran2kInterfaceProcedure: aFASTFortran2kIModuleProcedureSummary.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kIOParameter: aFASTFortran2kIOParameter [
	<generated>

	self visitFASTFortran2kTIOParameter: aFASTFortran2kIOParameter.
	self visitFASTTNamedEntity: aFASTFortran2kIOParameter.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kIfArithmeticStatement: aFASTFortran2kIfArithmeticStatement [
	<generated>

	self visitFASTFortran2kConditionalStatement: aFASTFortran2kIfArithmeticStatement.
	self acceptMeIfNotNil: aFASTFortran2kIfArithmeticStatement lessLabel.
	self acceptMeIfNotNil: aFASTFortran2kIfArithmeticStatement equalLabel.
	self acceptMeIfNotNil: aFASTFortran2kIfArithmeticStatement greaterLabel.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kIfBlockStatement: aFASTFortran2kIfBlockStatement [
	<generated>

	self visitFASTFortran2kConditionalStatement: aFASTFortran2kIfBlockStatement.
	self acceptMeIfNotNil: aFASTFortran2kIfBlockStatement thenStatementBlock.
	self acceptMeIfNotNil: aFASTFortran2kIfBlockStatement elseStatementBlock.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kIfLogicalStatement: aFASTFortran2kIfLogicalStatement [
	<generated>

	self visitFASTFortran2kConditionalStatement: aFASTFortran2kIfLogicalStatement.
	self acceptMeIfNotNil: aFASTFortran2kIfLogicalStatement statement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kImplicitRange: aFASTFortran2kImplicitRange [
	<generated>

	self acceptMeIfNotNil: aFASTFortran2kImplicitRange parentImplicitRule.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kImplicitStatement: aFASTFortran2kImplicitStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kImplicitStatement.
	self visitList: aFASTFortran2kImplicitStatement typingRules.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kImplicitTypingRule: aFASTFortran2kImplicitTypingRule [
	<generated>

	self acceptMeIfNotNil: aFASTFortran2kImplicitTypingRule parentImplicitStatement.
	self acceptMeIfNotNil: aFASTFortran2kImplicitTypingRule type.
	self visitList: aFASTFortran2kImplicitTypingRule ranges.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kImpliedDoExpression: aFASTFortran2kImpliedDoExpression [
	<generated>

	self visitFASTFortran2kTVariableGroup: aFASTFortran2kImpliedDoExpression.
	self visitFASTFortran2kTWithLoopControl: aFASTFortran2kImpliedDoExpression.
	self visitFASTFortran2kAbstractExpression: aFASTFortran2kImpliedDoExpression.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kImportStatement: aFASTFortran2kImportStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kImportStatement.
	self visitList: aFASTFortran2kImportStatement nameEntities.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kIncludeStatement: aFASTFortran2kIncludeStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kIncludeStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kInquireStatement: aFASTFortran2kInquireStatement [
	<generated>

	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kInquireStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kIntegerLiteral: aFASTFortran2kIntegerLiteral [
	<generated>

	self visitFASTFortran2kTFormat: aFASTFortran2kIntegerLiteral.
	self visitFASTFortran2kNumericalConstant: aFASTFortran2kIntegerLiteral.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kIntegerType: aFASTFortran2kIntegerType [
	<generated>

	self visitFASTFortran2kType: aFASTFortran2kIntegerType.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kInterface: aFASTFortran2kInterface [
	<generated>

	self visitFASTTNamedEntity: aFASTFortran2kInterface.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kInterface.
	self visitList: aFASTFortran2kInterface interfaceProcedures.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kInterfaceProcedure: aFASTFortran2kInterfaceProcedure [
	<generated>

	self visitFASTTNamedEntity: aFASTFortran2kInterfaceProcedure.
	self acceptMeIfNotNil: aFASTFortran2kInterfaceProcedure interface.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kInternalFunction: aFASTFortran2kInternalFunction [
	<generated>

	self visitFASTFortran2kTDeclaredType: aFASTFortran2kInternalFunction.
	self visitFASTFortran2kInternalProcedure: aFASTFortran2kInternalFunction.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kInternalProcedure: aFASTFortran2kInternalProcedure [
	<generated>

	self visitFASTTBehaviouralEntity: aFASTFortran2kInternalProcedure.
	self visitFASTTNamedEntity: aFASTFortran2kInternalProcedure.
	self visitFASTTWithComments: aFASTFortran2kInternalProcedure.
	self acceptMeIfNotNil: aFASTFortran2kInternalProcedure procedure.
	self acceptMeIfNotNil: aFASTFortran2kInternalProcedure programMain.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kInternalSubroutine: aFASTFortran2kInternalSubroutine [
	<generated>

	self visitFASTFortran2kInternalProcedure: aFASTFortran2kInternalSubroutine.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kIntrinsicStatement: aFASTFortran2kIntrinsicStatement [
	<generated>

	self visitFASTFortran2kTVariableGroup: aFASTFortran2kIntrinsicStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kIntrinsicStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kLabelReference: aFASTFortran2kLabelReference [
	<generated>

	self acceptMeIfNotNil: aFASTFortran2kLabelReference parentIfArithmeticLessBranch.
	self acceptMeIfNotNil: aFASTFortran2kLabelReference parentIfArithmeticEqualBranch.
	self acceptMeIfNotNil: aFASTFortran2kLabelReference parentIfArithmeticMoreBranch.
	self acceptMeIfNotNil: aFASTFortran2kLabelReference referencer.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kLogicalType: aFASTFortran2kLogicalType [
	<generated>

	self visitFASTFortran2kType: aFASTFortran2kLogicalType.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kLoopControlExpression: aFASTFortran2kLoopControlExpression [
	<generated>

	self acceptMeIfNotNil: aFASTFortran2kLoopControlExpression parentLoop.
	self acceptMeIfNotNil: aFASTFortran2kLoopControlExpression init.
	self acceptMeIfNotNil: aFASTFortran2kLoopControlExpression increment.
	self acceptMeIfNotNil: aFASTFortran2kLoopControlExpression limit.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kMapStatement: aFASTFortran2kMapStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kMapStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kModule: aFASTFortran2kModule [
	<generated>

	self visitFASTFortran2kProgramUnit: aFASTFortran2kModule.
	self visitList: aFASTFortran2kModule procedures.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kNameEntity: aFASTFortran2kNameEntity [
	<generated>

	self visitFASTTNamedEntity: aFASTFortran2kNameEntity.
	self acceptMeIfNotNil: aFASTFortran2kNameEntity importStatement.
	self acceptMeIfNotNil: aFASTFortran2kNameEntity publicStatement.
	self acceptMeIfNotNil: aFASTFortran2kNameEntity privateStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kNameListStatement: aFASTFortran2kNameListStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kNameListStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kNumericalConstant: aFASTFortran2kNumericalConstant [
	<generated>

	self visitFASTTNumericalLiteral: aFASTFortran2kNumericalConstant.
	self visitFASTFortran2kAbstractLiteral: aFASTFortran2kNumericalConstant.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kOpenStatement: aFASTFortran2kOpenStatement [
	<generated>

	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kOpenStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kOptionsStatement: aFASTFortran2kOptionsStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kOptionsStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kPTVariable: aFASTFortran2kPTVariable [
	<generated>

	self visitFASTFortran2kVariable: aFASTFortran2kPTVariable.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kParameterStatement: aFASTFortran2kParameterStatement [
	<generated>

	self visitFASTFortran2kTWithDeclarators: aFASTFortran2kParameterStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kParameterStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kPauseStatement: aFASTFortran2kPauseStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kPauseStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kPointerAssignmentStatement: aFASTFortran2kPointerAssignmentStatement [
	<generated>

	self visitFASTFortran2kTPointerAssignment: aFASTFortran2kPointerAssignmentStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kPointerVariable: aFASTFortran2kPointerVariable [
	<generated>

	self visitFASTFortran2kPTVariable: aFASTFortran2kPointerVariable.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kPragmaStatement: aFASTFortran2kPragmaStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kPragmaStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kPrintStatement: aFASTFortran2kPrintStatement [
	<generated>

	self visitFASTFortran2kTWithFormat: aFASTFortran2kPrintStatement.
	self visitFASTTWithArguments: aFASTFortran2kPrintStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kPrintStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kPrivateStatement: aFASTFortran2kPrivateStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kPrivateStatement.
	self visitList: aFASTFortran2kPrivateStatement nameEntities.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kProcedure: aFASTFortran2kProcedure [
	<generated>

	self visitFASTTWithParameters: aFASTFortran2kProcedure.
	self visitFASTFortran2kSubprogram: aFASTFortran2kProcedure.
	self visitList: aFASTFortran2kProcedure internalProcedures.
	self acceptMeIfNotNil: aFASTFortran2kProcedure module.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kProgramFile: aFASTFortran2kProgramFile [
	<generated>

	self visitFASTFortran2kTWithDeclarations: aFASTFortran2kProgramFile.
	self visitFASTTWithComments: aFASTFortran2kProgramFile.
	self visitList: aFASTFortran2kProgramFile programUnits.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kProgramMain: aFASTFortran2kProgramMain [
	<generated>

	self visitFASTFortran2kProgramUnit: aFASTFortran2kProgramMain.
	self visitList: aFASTFortran2kProgramMain internalProcedures.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kProgramUnit: aFASTFortran2kProgramUnit [
	<generated>

	self visitFASTFortran2kTWithDeclarations: aFASTFortran2kProgramUnit.
	self visitFASTTBehaviouralEntity: aFASTFortran2kProgramUnit.
	self visitFASTTNamedEntity: aFASTFortran2kProgramUnit.
	self visitFASTTWithComments: aFASTFortran2kProgramUnit.
	self acceptMeIfNotNil: aFASTFortran2kProgramUnit programFile.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kPublicStatement: aFASTFortran2kPublicStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kPublicStatement.
	self visitList: aFASTFortran2kPublicStatement nameEntities.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kReadStatement: aFASTFortran2kReadStatement [
	<generated>

	self visitFASTTWithArguments: aFASTFortran2kReadStatement.
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kReadStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kRealLiteral: aFASTFortran2kRealLiteral [
	<generated>

	self visitFASTFortran2kNumericalConstant: aFASTFortran2kRealLiteral.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kRealType: aFASTFortran2kRealType [
	<generated>

	self visitFASTFortran2kType: aFASTFortran2kRealType.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kReturnStatement: aFASTFortran2kReturnStatement [
	<generated>

	self visitFASTTReturnStatement: aFASTFortran2kReturnStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kReturnStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kRewindStatement: aFASTFortran2kRewindStatement [
	<generated>

	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kRewindStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kSaveStatement: aFASTFortran2kSaveStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kSaveStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kScalarVariable: aFASTFortran2kScalarVariable [
	<generated>

	self visitFASTFortran2kVariable: aFASTFortran2kScalarVariable.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kSourceCodeString: aFASTFortran2kSourceCodeString [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kSourceCodeString.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kSpecialIntrinsicType: aFASTFortran2kSpecialIntrinsicType [

	self visitFASTFortran2kType: aFASTFortran2kSpecialIntrinsicType

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kStatementBlock: aFASTFortran2kStatementBlock [
	<generated>

	self visitFASTTStatementBlock: aFASTFortran2kStatementBlock.
	self visitFASTTWithComments: aFASTFortran2kStatementBlock.
	self acceptMeIfNotNil: aFASTFortran2kStatementBlock parentDoStatement.
	self acceptMeIfNotNil: aFASTFortran2kStatementBlock parentIfBlock.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kStaticStatement: aFASTFortran2kStaticStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kStaticStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kStopStatement: aFASTFortran2kStopStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kStopStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kSubprogram: aFASTFortran2kSubprogram [
	<generated>

	self visitFASTFortran2kProgramUnit: aFASTFortran2kSubprogram.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kSubroutine: aFASTFortran2kSubroutine [
	<generated>

	self visitFASTFortran2kProcedure: aFASTFortran2kSubroutine.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kSubstring: aFASTFortran2kSubstring [
	<generated>

	self visitFASTFortran2kAbstractExpression: aFASTFortran2kSubstring.

]

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTDeclaration: aFASTFortran2kTDeclaration [
	<generated>

	self acceptMeIfNotNil: aFASTFortran2kTDeclaration fortranDeclarationOwner.

]

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTDeclaredType: aFASTFortran2kTDeclaredType [
	<generated>

	self acceptMeIfNotNil: aFASTFortran2kTDeclaredType declaredType.

]

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTEntityCreator: aFASTFortran2kTEntityCreator [
	<generated>


]

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTEntryArgument: aFASTFortran2kTEntryArgument [
	<generated>

	self acceptMeIfNotNil: aFASTFortran2kTEntryArgument entryStatement.

]

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTFormat: aFASTFortran2kTFormat [
	<generated>

	self visitFASTFortran2kTIOParameter: aFASTFortran2kTFormat.
	self acceptMeIfNotNil: aFASTFortran2kTFormat parentFormatedStatement.

]

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTHasBindingAttribute: aFASTFortran2kTHasBindingAttribute [
	<generated>


]

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTIOParameter: aFASTFortran2kTIOParameter [
	<generated>

	self acceptMeIfNotNil: aFASTFortran2kTIOParameter parentIOStatement.

]

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTPointerAssignment: aFASTFortran2kTPointerAssignment [
	<generated>

	self visitFASTTExpression: aFASTFortran2kTPointerAssignment.
	self acceptMeIfNotNil: aFASTFortran2kTPointerAssignment variable.
	self acceptMeIfNotNil: aFASTFortran2kTPointerAssignment expression.

]

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTVariableGroup: aFASTFortran2kTVariableGroup [
	<generated>

	self visitList: aFASTFortran2kTVariableGroup variables.
	self acceptMeIfNotNil: aFASTFortran2kTVariableGroup withVariableGroups.

]

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTWithDeclarations: aFASTFortran2kTWithDeclarations [
	<generated>

	self visitList: aFASTFortran2kTWithDeclarations declarations.

]

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTWithDeclarators: aFASTFortran2kTWithDeclarators [
	<generated>

	self visitList: aFASTFortran2kTWithDeclarators declarators.

]

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTWithFormat: aFASTFortran2kTWithFormat [
	<generated>

	self acceptMeIfNotNil: aFASTFortran2kTWithFormat format.

]

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTWithLabelReferences: aFASTFortran2kTWithLabelReferences [
	<generated>

	self visitList: aFASTFortran2kTWithLabelReferences labelReferences.

]

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTWithLoopControl: aFASTFortran2kTWithLoopControl [
	<generated>

	self acceptMeIfNotNil: aFASTFortran2kTWithLoopControl loopControl.

]

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTWithVariableGroups: aFASTFortran2kTWithVariableGroups [
	<generated>

	self visitList: aFASTFortran2kTWithVariableGroups variableGroups.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTargetVariable: aFASTFortran2kTargetVariable [
	<generated>

	self visitFASTFortran2kPTVariable: aFASTFortran2kTargetVariable.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kType: aFASTFortran2kType [
	<generated>

	self acceptMeIfNotNil: aFASTFortran2kType parentDeclaration.
	self acceptMeIfNotNil: aFASTFortran2kType parentImplicitRule.
	self acceptMeIfNotNil: aFASTFortran2kType size.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTypeBoundProcedure: aFASTFortran2kTypeBoundProcedure [
	<generated>

	self visitFASTTNamedEntity: aFASTFortran2kTypeBoundProcedure.
	self acceptMeIfNotNil: aFASTFortran2kTypeBoundProcedure derivedTypeDefinition.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kTypePBFinal: aFASTFortran2kTypePBFinal [
	<generated>

	self visitFASTFortran2kTypeBoundProcedure: aFASTFortran2kTypePBFinal.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kUnaryExpression: aFASTFortran2kUnaryExpression [
	<generated>

	self visitFASTTUnaryExpression: aFASTFortran2kUnaryExpression.
	self visitFASTFortran2kAbstractExpression: aFASTFortran2kUnaryExpression.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kUnionStatement: aFASTFortran2kUnionStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kUnionStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kUseNoRenamedStatement: aFASTFortran2kUseNoRenamedStatement [
	<generated>

	self visitFASTTNamedEntity: aFASTFortran2kUseNoRenamedStatement.
	self acceptMeIfNotNil: aFASTFortran2kUseNoRenamedStatement useOnlyStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kUseOnlyStatement: aFASTFortran2kUseOnlyStatement [
	<generated>

	self visitFASTFortran2kUseStatement: aFASTFortran2kUseOnlyStatement.
	self visitList: aFASTFortran2kUseOnlyStatement useNoRenamedStatements.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kUseRenamedStatement: aFASTFortran2kUseRenamedStatement [
	<generated>

	self visitFASTTNamedEntity: aFASTFortran2kUseRenamedStatement.
	self acceptMeIfNotNil: aFASTFortran2kUseRenamedStatement useStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kUseStatement: aFASTFortran2kUseStatement [
	<generated>

	self visitFASTTNamedEntity: aFASTFortran2kUseStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kUseStatement.
	self visitList: aFASTFortran2kUseStatement useRenamedStatements.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kUserDefinedType: aFASTFortran2kUserDefinedType [
	<generated>

	self visitFASTTNamedEntity: aFASTFortran2kUserDefinedType.
	self visitFASTFortran2kType: aFASTFortran2kUserDefinedType.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kVariable: aFASTFortran2kVariable [
	<generated>

	self visitFASTFortran2kTEntryArgument: aFASTFortran2kVariable.
	self visitFASTFortran2kTFormat: aFASTFortran2kVariable.
	self visitFASTTVariableEntity: aFASTFortran2kVariable.
	self visitFASTFortran2kAbstractExpression: aFASTFortran2kVariable.
	self acceptMeIfNotNil: aFASTFortran2kVariable pointerIn.
	self acceptMeIfNotNil: aFASTFortran2kVariable fieldIn.
	self acceptMeIfNotNil: aFASTFortran2kVariable parentVariableGroup.
	self acceptMeIfNotNil: aFASTFortran2kVariable instanceIn.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kVariableDeclarationStatement: aFASTFortran2kVariableDeclarationStatement [
	<generated>

	self visitFASTFortran2kTDeclaredType: aFASTFortran2kVariableDeclarationStatement.
	self visitFASTFortran2kTWithDeclarators: aFASTFortran2kVariableDeclarationStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kVariableDeclarationStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kVariableDeclarator: aFASTFortran2kVariableDeclarator [
	<generated>

	self visitFASTTNamedEntity: aFASTFortran2kVariableDeclarator.
	self visitList: aFASTFortran2kVariableDeclarator dimensions.
	self acceptMeIfNotNil: aFASTFortran2kVariableDeclarator parentDeclaration.
	self acceptMeIfNotNil: aFASTFortran2kVariableDeclarator expression.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kVirtualStatement: aFASTFortran2kVirtualStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kVirtualStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kVolatileStatement: aFASTFortran2kVolatileStatement [
	<generated>

	self visitFASTFortran2kAbstractStatement: aFASTFortran2kVolatileStatement.

]

{ #category : 'visiting' }
FASTFortran2kTTraitVisitor >> visitFASTFortran2kWriteStatement: aFASTFortran2kWriteStatement [
	<generated>

	self visitFASTTWithArguments: aFASTFortran2kWriteStatement.
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kWriteStatement.

]

{ #category : 'visiting - traits' }
FASTFortran2kTTraitVisitor >> visitList: aCollection [
	<generated>

	^aCollection collect: [ :each | each accept: self ]

]
