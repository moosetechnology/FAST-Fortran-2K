Class {
	#name : 'FASTFortran2kAbstractVisitor',
	#superclass : 'FASTCoreVisitor',
	#category : 'FAST-Fortran2k-Visitors',
	#package : 'FAST-Fortran2k-Visitors'
}

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kAbstractExpression: aFASTFortran2kAbstractExpression [
	<generated>
	self visitFASTTExpression: aFASTFortran2kAbstractExpression.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kAbstractIOStatement: aFASTFortran2kAbstractIOStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kAbstractIOStatement.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kAbstractLiteral: aFASTFortran2kAbstractLiteral [
	<generated>
	self visitFASTFortran2kAbstractExpression: aFASTFortran2kAbstractLiteral.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kAbstractStatement: aFASTFortran2kAbstractStatement [
	<generated>
	self visitFASTTStatement: aFASTFortran2kAbstractStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kAcceptStatement: aFASTFortran2kAcceptStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kAcceptStatement.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kAmpersand: aFASTFortran2kAmpersand [
	<generated>
	self visitFASTTCharacterLiteral: aFASTFortran2kAmpersand.
	self visitFASTFortran2kAbstractLiteral: aFASTFortran2kAmpersand.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kArrayRange: aFASTFortran2kArrayRange [
	<generated>
	self visitFASTFortran2kAbstractExpression: aFASTFortran2kArrayRange.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kArrayVariable: aFASTFortran2kArrayVariable [
	<generated>
	self visitFASTFortran2kVariable: aFASTFortran2kArrayVariable.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kAssignmentExpression: aFASTFortran2kAssignmentExpression [
	<generated>
	self visitFASTFortran2kTIOParameter: aFASTFortran2kAssignmentExpression.
	self visitFASTTAssignment: aFASTFortran2kAssignmentExpression.
	self visitFASTFortran2kAbstractExpression: aFASTFortran2kAssignmentExpression.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kAssignmentStatement: aFASTFortran2kAssignmentStatement [
	<generated>
	self visitFASTTAssignment: aFASTFortran2kAssignmentStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kAssignmentStatement.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kAsterisk: aFASTFortran2kAsterisk [
	<generated>
	self visitFASTFortran2kTEntryArgument: aFASTFortran2kAsterisk.
	self visitFASTFortran2kIntegerLiteral: aFASTFortran2kAsterisk.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kAutomaticStatement: aFASTFortran2kAutomaticStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kAutomaticStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kBackspaceStatement: aFASTFortran2kBackspaceStatement [
	<generated>
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kBackspaceStatement.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kBinaryExpression: aFASTFortran2kBinaryExpression [

	self visitFASTFortran2kAbstractExpression: aFASTFortran2kBinaryExpression.

	aFASTFortran2kBinaryExpression leftOperand accept: self.
	aFASTFortran2kBinaryExpression rightOperand accept: self

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kBlockData: aFASTFortran2kBlockData [
	<generated>
	self visitFASTFortran2kSubprogram: aFASTFortran2kBlockData.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kBooleanLiteral: aFASTFortran2kBooleanLiteral [
	<generated>
	self visitFASTTBooleanLiteral: aFASTFortran2kBooleanLiteral.
	self visitFASTFortran2kAbstractLiteral: aFASTFortran2kBooleanLiteral.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kByteType: aFASTFortran2kByteType [
	<generated>
	self visitFASTFortran2kType: aFASTFortran2kByteType.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kCallStatement: aFASTFortran2kCallStatement [
	<generated>
	self visitFASTTWithArguments: aFASTFortran2kCallStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kCallStatement.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kCharacterLiteral: aFASTFortran2kCharacterLiteral [
	<generated>
	self visitFASTFortran2kTFormat: aFASTFortran2kCharacterLiteral.
	self visitFASTTCharacterLiteral: aFASTFortran2kCharacterLiteral.
	self visitFASTFortran2kAbstractLiteral: aFASTFortran2kCharacterLiteral.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kCharacterType: aFASTFortran2kCharacterType [
	<generated>
	self visitFASTFortran2kType: aFASTFortran2kCharacterType.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kClassDeclarationStatement: aFASTFortran2kClassDeclarationStatement [
	<generated>
	self visitFASTFortran2kVariableDeclarationStatement: aFASTFortran2kClassDeclarationStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kCloseStatement: aFASTFortran2kCloseStatement [
	<generated>
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kCloseStatement.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kComment: aFASTFortran2kComment [
	<generated>
	self visitFASTTComment: aFASTFortran2kComment.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kCommonGroup: aFASTFortran2kCommonGroup [
	<generated>
	self visitFASTFortran2kTWithDeclarators: aFASTFortran2kCommonGroup.
	self visitFASTTNamedEntity: aFASTFortran2kCommonGroup.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kCommonStatement: aFASTFortran2kCommonStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kCommonStatement.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kComplexLiteral: aFASTFortran2kComplexLiteral [
	<generated>
	self visitFASTFortran2kNumericalConstant: aFASTFortran2kComplexLiteral.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kComplexType: aFASTFortran2kComplexType [
	<generated>
	self visitFASTFortran2kType: aFASTFortran2kComplexType.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kConditionalStatement: aFASTFortran2kConditionalStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kConditionalStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kContinueStatement: aFASTFortran2kContinueStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kContinueStatement.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kDataGroup: aFASTFortran2kDataGroup [
	<generated>
	self visitFASTFortran2kTVariableGroup: aFASTFortran2kDataGroup.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kDataStatement: aFASTFortran2kDataStatement [
	<generated>
	self visitFASTFortran2kTWithVariableGroups: aFASTFortran2kDataStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kDataStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kDecodeStatement: aFASTFortran2kDecodeStatement [
	<generated>
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kDecodeStatement.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kDerivedTypeComponent: aFASTFortran2kDerivedTypeComponent [
	<generated>
	self visitFASTFortran2kVariableDeclarationStatement: aFASTFortran2kDerivedTypeComponent.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kDerivedTypeDeclaration: aFASTFortran2kDerivedTypeDeclaration [
	<generated>
	self visitFASTFortran2kVariableDeclarationStatement: aFASTFortran2kDerivedTypeDeclaration.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kDerivedTypeDefinition: aFASTFortran2kDerivedTypeDefinition [
	<generated>
	self visitFASTTNamedEntity: aFASTFortran2kDerivedTypeDefinition.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kDerivedTypeDefinition.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kDimensionStatement: aFASTFortran2kDimensionStatement [
	<generated>
	self visitFASTFortran2kTWithDeclarators: aFASTFortran2kDimensionStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kDimensionStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kDoStatement: aFASTFortran2kDoStatement [
	<generated>
	self visitFASTFortran2kTWithLabelReferences: aFASTFortran2kDoStatement.
	self visitFASTFortran2kTWithLoopControl: aFASTFortran2kDoStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kDoStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kDoWhileStatement: aFASTFortran2kDoWhileStatement [
	<generated>
	self visitFASTFortran2kConditionalStatement: aFASTFortran2kDoWhileStatement.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kDoubleComplexLiteral: aFASTFortran2kDoubleComplexLiteral [
	<generated>
	self visitFASTFortran2kNumericalConstant: aFASTFortran2kDoubleComplexLiteral.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kDoubleComplexType: aFASTFortran2kDoubleComplexType [
	<generated>
	self visitFASTFortran2kType: aFASTFortran2kDoubleComplexType.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kDoublePrecisionLiteral: aFASTFortran2kDoublePrecisionLiteral [
	<generated>
	self visitFASTFortran2kNumericalConstant: aFASTFortran2kDoublePrecisionLiteral.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kDoublePrecisionType: aFASTFortran2kDoublePrecisionType [
	<generated>
	self visitFASTFortran2kType: aFASTFortran2kDoublePrecisionType.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kElseStatement: aFASTFortran2kElseStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kElseStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kEncodeStatement: aFASTFortran2kEncodeStatement [
	<generated>
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kEncodeStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kEndFileStatement: aFASTFortran2kEndFileStatement [
	<generated>
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kEndFileStatement.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kEntity: aFASTFortran2kEntity [

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kEntryStatement: aFASTFortran2kEntryStatement [
	<generated>
	self visitFASTTNamedEntity: aFASTFortran2kEntryStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kEntryStatement.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kEquivalenceGroup: aFASTFortran2kEquivalenceGroup [
	<generated>
	self visitFASTFortran2kTVariableGroup: aFASTFortran2kEquivalenceGroup.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kEquivalenceStatement: aFASTFortran2kEquivalenceStatement [
	<generated>
	self visitFASTFortran2kTWithVariableGroups: aFASTFortran2kEquivalenceStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kEquivalenceStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kExitStatement: aFASTFortran2kExitStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kExitStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kExternalStatement: aFASTFortran2kExternalStatement [
	<generated>
	self visitFASTTNamedEntity: aFASTFortran2kExternalStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kExternalStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kFormatStatement: aFASTFortran2kFormatStatement [
	<generated>
	self visitFASTFortran2kTWithFormat: aFASTFortran2kFormatStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kFormatStatement.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kFormattedCodeString: aFASTFortran2kFormattedCodeString [
	<generated>
	self visitFASTFortran2kSourceCodeString: aFASTFortran2kFormattedCodeString.

]

{ #category : 'visiting - programUnits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kFunction: aFASTFortran2kFunction [
	<generated>
	self visitFASTFortran2kProcedure: aFASTFortran2kFunction.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kFunctionCall: aFASTFortran2kFunctionCall [
	<generated>
	self visitFASTTWithArguments: aFASTFortran2kFunctionCall.
	self visitFASTFortran2kAbstractExpression: aFASTFortran2kFunctionCall.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kFunctionStatement: aFASTFortran2kFunctionStatement [
	<generated>
	self visitFASTTNamedEntity: aFASTFortran2kFunctionStatement.
	self visitFASTTWithParameters: aFASTFortran2kFunctionStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kFunctionStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kGoToAssignedStatement: aFASTFortran2kGoToAssignedStatement [
	<generated>
	self visitFASTFortran2kTWithLabelReferences: aFASTFortran2kGoToAssignedStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kGoToAssignedStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kGoToComputedStatement: aFASTFortran2kGoToComputedStatement [
	<generated>
	self visitFASTFortran2kTWithLabelReferences: aFASTFortran2kGoToComputedStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kGoToComputedStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kGoToStatement: aFASTFortran2kGoToStatement [
	<generated>
	self visitFASTFortran2kTWithLabelReferences: aFASTFortran2kGoToStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kGoToStatement.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kIModuleProcedureSummary: aFASTFortran2kIModuleProcedureSummary [
	<generated>
	self visitFASTFortran2kInterfaceProcedure: aFASTFortran2kIModuleProcedureSummary.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kIfArithmeticStatement: aFASTFortran2kIfArithmeticStatement [
	<generated>
	self visitFASTFortran2kConditionalStatement: aFASTFortran2kIfArithmeticStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kIfBlockStatement: aFASTFortran2kIfBlockStatement [
	<generated>
	self visitFASTFortran2kConditionalStatement: aFASTFortran2kIfBlockStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kIfLogicalStatement: aFASTFortran2kIfLogicalStatement [
	<generated>
	self visitFASTFortran2kConditionalStatement: aFASTFortran2kIfLogicalStatement.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kImplicitRange: aFASTFortran2kImplicitRange [
	<generated>

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kImplicitStatement: aFASTFortran2kImplicitStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kImplicitStatement.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kImplicitTypingRule: aFASTFortran2kImplicitTypingRule [
	<generated>

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kImpliedDoExpression: aFASTFortran2kImpliedDoExpression [
	<generated>
	self visitFASTFortran2kTVariableGroup: aFASTFortran2kImpliedDoExpression.
	self visitFASTFortran2kTWithLoopControl: aFASTFortran2kImpliedDoExpression.
	self visitFASTFortran2kAbstractExpression: aFASTFortran2kImpliedDoExpression.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kImportStatement: aFASTFortran2kImportStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kImportStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kIncludeStatement: aFASTFortran2kIncludeStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kIncludeStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kInquireStatement: aFASTFortran2kInquireStatement [
	<generated>
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kInquireStatement.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kIntegerLiteral: aFASTFortran2kIntegerLiteral [
	<generated>
	self visitFASTFortran2kTFormat: aFASTFortran2kIntegerLiteral.
	self visitFASTFortran2kNumericalConstant: aFASTFortran2kIntegerLiteral.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kIntegerType: aFASTFortran2kIntegerType [
	<generated>
	self visitFASTFortran2kType: aFASTFortran2kIntegerType.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kInterface: aFASTFortran2kInterface [
	<generated>
	self visitFASTTNamedEntity: aFASTFortran2kInterface.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kInterface.

]

{ #category : 'visiting - programUnits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kInterfaceProcedure: aFASTFortran2kInterfaceProcedure [
	<generated>
	self visitFASTTNamedEntity: aFASTFortran2kInterfaceProcedure.

]

{ #category : 'visiting - programUnits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kInternalFunction: aFASTFortran2kInternalFunction [
	<generated>
	self visitFASTFortran2kInternalProcedure: aFASTFortran2kInternalFunction.

]

{ #category : 'visiting - programUnits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kInternalProcedure: aFASTFortran2kInternalProcedure [
	<generated>
	self visitFASTTBehaviouralEntity: aFASTFortran2kInternalProcedure.
	self visitFASTTNamedEntity: aFASTFortran2kInternalProcedure.
	self visitFASTTWithComments: aFASTFortran2kInternalProcedure.

]

{ #category : 'visiting - programUnits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kInternalSubroutine: aFASTFortran2kInternalSubroutine [
	<generated>
	self visitFASTFortran2kInternalProcedure: aFASTFortran2kInternalSubroutine.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kIntrinsicStatement: aFASTFortran2kIntrinsicStatement [
	<generated>
	self visitFASTFortran2kTVariableGroup: aFASTFortran2kIntrinsicStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kIntrinsicStatement.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kLabelReference: aFASTFortran2kLabelReference [
	<generated>

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kLogicalType: aFASTFortran2kLogicalType [
	<generated>
	self visitFASTFortran2kType: aFASTFortran2kLogicalType.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kLoopControlExpression: aFASTFortran2kLoopControlExpression [
	<generated>

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kMapStatement: aFASTFortran2kMapStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kMapStatement.

]

{ #category : 'visiting - programUnits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kModule: aFASTFortran2kModule [
	<generated>
	self visitFASTFortran2kProgramUnit: aFASTFortran2kModule.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kNameEntity: aFASTFortran2kNameEntity [
	<generated>
	self visitFASTTNamedEntity: aFASTFortran2kNameEntity.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kNameListStatement: aFASTFortran2kNameListStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kNameListStatement.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kNumericalConstant: aFASTFortran2kNumericalConstant [
	<generated>
	self visitFASTTNumericalLiteral: aFASTFortran2kNumericalConstant.
	self visitFASTFortran2kAbstractLiteral: aFASTFortran2kNumericalConstant.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kOpenStatement: aFASTFortran2kOpenStatement [
	<generated>
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kOpenStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kOptionsStatement: aFASTFortran2kOptionsStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kOptionsStatement.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kPTVariable: aFASTFortran2kPTVariable [
	<generated>
	self visitFASTFortran2kVariable: aFASTFortran2kPTVariable.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kParameterStatement: aFASTFortran2kParameterStatement [
	<generated>
	self visitFASTFortran2kTWithDeclarators: aFASTFortran2kParameterStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kParameterStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kPauseStatement: aFASTFortran2kPauseStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kPauseStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kPointerAssignmentStatement: aFASTFortran2kPointerAssignmentStatement [
	<generated>
	self visitFASTFortran2kTPointerAssignment: aFASTFortran2kPointerAssignmentStatement.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kPointerVariable: aFASTFortran2kPointerVariable [
	<generated>
	self visitFASTFortran2kPTVariable: aFASTFortran2kPointerVariable.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kPragmaStatement: aFASTFortran2kPragmaStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kPragmaStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kPrintStatement: aFASTFortran2kPrintStatement [
	<generated>
	self visitFASTFortran2kTWithFormat: aFASTFortran2kPrintStatement.
	self visitFASTTWithArguments: aFASTFortran2kPrintStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kPrintStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kPrivateStatement: aFASTFortran2kPrivateStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kPrivateStatement.

]

{ #category : 'visiting - programUnits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kProcedure: aFASTFortran2kProcedure [
	<generated>
	self visitFASTTWithParameters: aFASTFortran2kProcedure.
	self visitFASTFortran2kSubprogram: aFASTFortran2kProcedure.

]

{ #category : 'visiting - programUnits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kProgramFile: aFASTFortran2kProgramFile [
	<generated>
	self visitFASTTWithComments: aFASTFortran2kProgramFile.

]

{ #category : 'visiting - programUnits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kProgramMain: aFASTFortran2kProgramMain [
	<generated>
	self visitFASTFortran2kProgramUnit: aFASTFortran2kProgramMain.

]

{ #category : 'visiting - programUnits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kProgramUnit: aFASTFortran2kProgramUnit [
	<generated>
	self visitFASTTBehaviouralEntity: aFASTFortran2kProgramUnit.
	self visitFASTTNamedEntity: aFASTFortran2kProgramUnit.
	self visitFASTTWithComments: aFASTFortran2kProgramUnit.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kPublicStatement: aFASTFortran2kPublicStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kPublicStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kReadStatement: aFASTFortran2kReadStatement [
	<generated>
	self visitFASTTWithArguments: aFASTFortran2kReadStatement.
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kReadStatement.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kRealLiteral: aFASTFortran2kRealLiteral [
	<generated>
	self visitFASTFortran2kNumericalConstant: aFASTFortran2kRealLiteral.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kRealType: aFASTFortran2kRealType [
	<generated>
	self visitFASTFortran2kType: aFASTFortran2kRealType.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kReturnStatement: aFASTFortran2kReturnStatement [
	<generated>
	self visitFASTTReturnStatement: aFASTFortran2kReturnStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kReturnStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kRewindStatement: aFASTFortran2kRewindStatement [
	<generated>
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kRewindStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kSaveStatement: aFASTFortran2kSaveStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kSaveStatement.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kScalarVariable: aFASTFortran2kScalarVariable [
	<generated>
	self visitFASTFortran2kVariable: aFASTFortran2kScalarVariable.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kSourceCodeString: aFASTFortran2kSourceCodeString [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kSourceCodeString.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kStatementBlock: aFASTFortran2kStatementBlock [
	<generated>
	self visitFASTTStatementBlock: aFASTFortran2kStatementBlock.
	self visitFASTTWithComments: aFASTFortran2kStatementBlock.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kStaticStatement: aFASTFortran2kStaticStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kStaticStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kStopStatement: aFASTFortran2kStopStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kStopStatement.

]

{ #category : 'visiting - programUnits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kSubprogram: aFASTFortran2kSubprogram [
	<generated>
	self visitFASTFortran2kProgramUnit: aFASTFortran2kSubprogram.

]

{ #category : 'visiting - programUnits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kSubroutine: aFASTFortran2kSubroutine [
	<generated>
	self visitFASTFortran2kProcedure: aFASTFortran2kSubroutine.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kSubstring: aFASTFortran2kSubstring [
	<generated>
	self visitFASTFortran2kAbstractExpression: aFASTFortran2kSubstring.

]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kTEntityCreator: aFASTFortran2kTEntityCreator [
	<generated>

]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kTEntryArgument: aFASTFortran2kTEntryArgument [
	<generated>

]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kTFormat: aFASTFortran2kTFormat [
	<generated>
	self visitFASTFortran2kTIOParameter: aFASTFortran2kTFormat.

]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kTHasBindingAttribute: aFASTFortran2kTHasBindingAttribute [
	<generated>

]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kTIOParameter: aFASTFortran2kTIOParameter [
	<generated>

]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kTPointerAssignment: aFASTFortran2kTPointerAssignment [
	<generated>
	self visitFASTTExpression: aFASTFortran2kTPointerAssignment.

]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kTVariableGroup: aFASTFortran2kTVariableGroup [
	<generated>

]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kTWithDeclarators: aFASTFortran2kTWithDeclarators [
	<generated>

]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kTWithFormat: aFASTFortran2kTWithFormat [
	<generated>

]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kTWithLabelReferences: aFASTFortran2kTWithLabelReferences [
	<generated>

]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kTWithLoopControl: aFASTFortran2kTWithLoopControl [
	<generated>

]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kTWithVariableGroups: aFASTFortran2kTWithVariableGroups [
	<generated>

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kTargetVariable: aFASTFortran2kTargetVariable [
	<generated>
	self visitFASTFortran2kPTVariable: aFASTFortran2kTargetVariable.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kType: aFASTFortran2kType [
	<generated>

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kTypeBoundProcedure: aFASTFortran2kTypeBoundProcedure [
	<generated>
	self visitFASTTNamedEntity: aFASTFortran2kTypeBoundProcedure.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kTypePBFinal: aFASTFortran2kTypePBFinal [
	<generated>
	self visitFASTFortran2kTypeBoundProcedure: aFASTFortran2kTypePBFinal.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kUnaryExpression: aFASTFortran2kUnaryExpression [

	self visitFASTFortran2kAbstractExpression: aFASTFortran2kUnaryExpression.

	aFASTFortran2kUnaryExpression expression accept: self

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kUnionStatement: aFASTFortran2kUnionStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kUnionStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kUseNoRenamedStatement: aFASTFortran2kUseNoRenamedStatement [
	<generated>
	self visitFASTTNamedEntity: aFASTFortran2kUseNoRenamedStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kUseOnlyStatement: aFASTFortran2kUseOnlyStatement [
	<generated>
	self visitFASTFortran2kUseStatement: aFASTFortran2kUseOnlyStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kUseRenamedStatement: aFASTFortran2kUseRenamedStatement [
	<generated>
	self visitFASTTNamedEntity: aFASTFortran2kUseRenamedStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kUseStatement: aFASTFortran2kUseStatement [
	<generated>
	self visitFASTTNamedEntity: aFASTFortran2kUseStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kUseStatement.

]

{ #category : 'visiting' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kUserDefinedType: aFASTFortran2kUserDefinedType [
	<generated>
	self visitFASTTNamedEntity: aFASTFortran2kUserDefinedType.
	self visitFASTFortran2kType: aFASTFortran2kUserDefinedType.

]

{ #category : 'visiting - expressions' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kVariable: aFASTFortran2kVariable [
	<generated>
	self visitFASTFortran2kTEntryArgument: aFASTFortran2kVariable.
	self visitFASTFortran2kTFormat: aFASTFortran2kVariable.
	self visitFASTTVariableEntity: aFASTFortran2kVariable.
	self visitFASTFortran2kAbstractExpression: aFASTFortran2kVariable.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kVariableDeclarationStatement: aFASTFortran2kVariableDeclarationStatement [
	<generated>
	self visitFASTFortran2kTWithDeclarators: aFASTFortran2kVariableDeclarationStatement.
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kVariableDeclarationStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kVariableDeclarator: aFASTFortran2kVariableDeclarator [
	<generated>
	self visitFASTTNamedEntity: aFASTFortran2kVariableDeclarator.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kVirtualStatement: aFASTFortran2kVirtualStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kVirtualStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kVolatileStatement: aFASTFortran2kVolatileStatement [
	<generated>
	self visitFASTFortran2kAbstractStatement: aFASTFortran2kVolatileStatement.

]

{ #category : 'visiting - statements' }
FASTFortran2kAbstractVisitor >> visitFASTFortran2kWriteStatement: aFASTFortran2kWriteStatement [
	<generated>
	self visitFASTTWithArguments: aFASTFortran2kWriteStatement.
	self visitFASTFortran2kAbstractIOStatement: aFASTFortran2kWriteStatement.

]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTFortranTBehaviouralEntity: aFASTFortranTBehaviouralEntity [

	aFASTFortranTBehaviouralEntity statementBlock accept: self
]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTTAssignment: aFASTFortranTAssignment [

	aFASTFortranTAssignment variable accept: self.
	aFASTFortranTAssignment expression accept: self
]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTTWithArguments: aFASTFortran2kTWithArguments [

	aFASTFortran2kTWithArguments arguments do: [ :arg | arg accept: self ]

]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTTWithComments: aFASTTWithComments [

	aFASTTWithComments comments do: [ :arg | arg accept: self ]

]

{ #category : 'visiting - traits' }
FASTFortran2kAbstractVisitor >> visitFASTTWithParameters: aFASTFortran2kTWithParameters [

	aFASTFortran2kTWithParameters parameters do: [ :param | param accept: self ]
]
