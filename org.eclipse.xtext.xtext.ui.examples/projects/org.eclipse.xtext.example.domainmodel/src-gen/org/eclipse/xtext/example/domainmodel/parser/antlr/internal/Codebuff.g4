/*
 * generated by Xtext
 */
grammar Codebuff;
options {contextSuperClass=org.antlr.v4.runtime.RuleContextWithAltNum;}

// Rule DomainModel
ruleDomainModel:
	ruleXImportSection
	?
	ruleAbstractElement
	*
;

// Rule AbstractElement
ruleAbstractElement:
	(
		rulePackageDeclaration
		    |
		ruleEntity
	)
;

// Rule PackageDeclaration
rulePackageDeclaration:
	'package'
	ruleQualifiedName
	'{'
	ruleAbstractElement
	*
	'}'
;

// Rule Entity
ruleEntity:
	'entity'
	ruleValidID
	(
		'extends'
		ruleJvmParameterizedTypeReference
	)?
	'{'
	ruleFeature
	*
	'}'
;

// Rule Feature
ruleFeature:
	(
		ruleProperty
		    |
		ruleOperation
	)
;

// Rule Property
ruleProperty:
	ruleValidID
	':'
	ruleJvmTypeReference
;

// Rule Operation
ruleOperation:
	'op'
	ruleValidID
	'('
	(
		ruleFullJvmFormalParameter
		(
			','
			ruleFullJvmFormalParameter
		)*
	)?
	')'
	(
		':'
		ruleJvmTypeReference
	)?
	ruleXBlockExpression
;

// Rule XExpression
ruleXExpression:
	ruleXAssignment
;

// Rule XAssignment
ruleXAssignment:
	(
		ruleFeatureCallID
		ruleOpSingleAssign
		ruleXAssignment
		    |
		ruleXOrExpression
		(
			(
				ruleOpMultiAssign
			)
			ruleXAssignment
		)?
	)
;

// Rule OpSingleAssign
ruleOpSingleAssign:
	'='
;

// Rule OpMultiAssign
ruleOpMultiAssign:
	(
		'+='
		    |
		'-='
		    |
		'*='
		    |
		'/='
		    |
		'%='
		    |
		'<'
		'<'
		'='
		    |
		'>'
		'>'?
		'>='
	)
;

// Rule XOrExpression
ruleXOrExpression:
	ruleXAndExpression
	(
		(
			ruleOpOr
		)
		ruleXAndExpression
	)*
;

// Rule OpOr
ruleOpOr:
	'||'
;

// Rule XAndExpression
ruleXAndExpression:
	ruleXEqualityExpression
	(
		(
			ruleOpAnd
		)
		ruleXEqualityExpression
	)*
;

// Rule OpAnd
ruleOpAnd:
	'&&'
;

// Rule XEqualityExpression
ruleXEqualityExpression:
	ruleXRelationalExpression
	(
		(
			ruleOpEquality
		)
		ruleXRelationalExpression
	)*
;

// Rule OpEquality
ruleOpEquality:
	(
		'=='
		    |
		'!='
		    |
		'==='
		    |
		'!=='
	)
;

// Rule XRelationalExpression
ruleXRelationalExpression:
	ruleXOtherOperatorExpression
	(
		(
			'instanceof'
		)
		ruleJvmTypeReference
		    |
		(
			ruleOpCompare
		)
		ruleXOtherOperatorExpression
	)*
;

// Rule OpCompare
ruleOpCompare:
	(
		'>='
		    |
		'<'
		'='
		    |
		'>'
		    |
		'<'
	)
;

// Rule XOtherOperatorExpression
ruleXOtherOperatorExpression:
	ruleXAdditiveExpression
	(
		(
			ruleOpOther
		)
		ruleXAdditiveExpression
	)*
;

// Rule OpOther
ruleOpOther:
	(
		'->'
		    |
		'..<'
		    |
		'>'
		'..'
		    |
		'..'
		    |
		'=>'
		    |
		'>'
		(
			(
				'>'
				'>'
			)
			    |
			'>'
		)
		    |
		'<'
		(
			(
				'<'
				'<'
			)
			    |
			'<'
			    |
			'=>'
		)
		    |
		'<>'
		    |
		'?:'
	)
;

// Rule XAdditiveExpression
ruleXAdditiveExpression:
	ruleXMultiplicativeExpression
	(
		(
			ruleOpAdd
		)
		ruleXMultiplicativeExpression
	)*
;

// Rule OpAdd
ruleOpAdd:
	(
		'+'
		    |
		'-'
	)
;

// Rule XMultiplicativeExpression
ruleXMultiplicativeExpression:
	ruleXUnaryOperation
	(
		(
			ruleOpMulti
		)
		ruleXUnaryOperation
	)*
;

// Rule OpMulti
ruleOpMulti:
	(
		'*'
		    |
		'**'
		    |
		'/'
		    |
		'%'
	)
;

// Rule XUnaryOperation
ruleXUnaryOperation:
	(
		ruleOpUnary
		ruleXUnaryOperation
		    |
		ruleXCastedExpression
	)
;

// Rule OpUnary
ruleOpUnary:
	(
		'!'
		    |
		'-'
		    |
		'+'
	)
;

// Rule XCastedExpression
ruleXCastedExpression:
	ruleXPostfixOperation
	(
		(
			'as'
		)
		ruleJvmTypeReference
	)*
;

// Rule XPostfixOperation
ruleXPostfixOperation:
	ruleXMemberFeatureCall
	(
		ruleOpPostfix
	)?
;

// Rule OpPostfix
ruleOpPostfix:
	(
		'++'
		    |
		'--'
	)
;

// Rule XMemberFeatureCall
ruleXMemberFeatureCall:
	ruleXPrimaryExpression
	(
		(
			(
				'.'
				    |
				'::'
			)
			ruleFeatureCallID
			ruleOpSingleAssign
		)
		ruleXAssignment
		    |
		(
			(
				'.'
				    |
				'?.'
				    |
				'::'
			)
		)
		(
			'<'
			ruleJvmArgumentTypeReference
			(
				','
				ruleJvmArgumentTypeReference
			)*
			'>'
		)?
		ruleIdOrSuper
		(
			(
				'('
			)
			(
				(
					ruleXShortClosure
				)
				    |
				ruleXExpression
				(
					','
					ruleXExpression
				)*
			)?
			')'
		)?
		(
			ruleXClosure
		)?
	)*
;

// Rule XPrimaryExpression
ruleXPrimaryExpression:
	(
		ruleXConstructorCall
		    |
		ruleXBlockExpression
		    |
		ruleXSwitchExpression
		    |
		(
			ruleXSynchronizedExpression
		)
		    |
		ruleXFeatureCall
		    |
		ruleXLiteral
		    |
		ruleXIfExpression
		    |
		(
			ruleXForLoopExpression
		)
		    |
		ruleXBasicForLoopExpression
		    |
		ruleXWhileExpression
		    |
		ruleXDoWhileExpression
		    |
		ruleXThrowExpression
		    |
		ruleXReturnExpression
		    |
		ruleXTryCatchFinallyExpression
		    |
		ruleXParenthesizedExpression
	)
;

// Rule XLiteral
ruleXLiteral:
	(
		ruleXCollectionLiteral
		    |
		(
			ruleXClosure
		)
		    |
		ruleXBooleanLiteral
		    |
		ruleXNumberLiteral
		    |
		ruleXNullLiteral
		    |
		ruleXStringLiteral
		    |
		ruleXTypeLiteral
	)
;

// Rule XCollectionLiteral
ruleXCollectionLiteral:
	(
		ruleXSetLiteral
		    |
		ruleXListLiteral
	)
;

// Rule XSetLiteral
ruleXSetLiteral:
	'#'
	'{'
	(
		ruleXExpression
		(
			','
			ruleXExpression
		)*
	)?
	'}'
;

// Rule XListLiteral
ruleXListLiteral:
	'#'
	'['
	(
		ruleXExpression
		(
			','
			ruleXExpression
		)*
	)?
	']'
;

// Rule XClosure
ruleXClosure:
	(
		'['
	)
	(
		(
			ruleJvmFormalParameter
			(
				','
				ruleJvmFormalParameter
			)*
		)?
		'|'
	)?
	ruleXExpressionInClosure
	']'
;

// Rule XExpressionInClosure
ruleXExpressionInClosure:
	(
		ruleXExpressionOrVarDeclaration
		';'?
	)*
;

// Rule XShortClosure
ruleXShortClosure:
	(
		(
			ruleJvmFormalParameter
			(
				','
				ruleJvmFormalParameter
			)*
		)?
		'|'
	)
	ruleXExpression
;

// Rule XParenthesizedExpression
ruleXParenthesizedExpression:
	'('
	ruleXExpression
	')'
;

// Rule XIfExpression
ruleXIfExpression:
	'if'
	'('
	ruleXExpression
	')'
	ruleXExpression
	(
		(
			'else'
		)
		ruleXExpression
	)?
;

// Rule XSwitchExpression
ruleXSwitchExpression:
	'switch'
	(
		(
			'('
			ruleJvmFormalParameter
			':'
		)
		ruleXExpression
		')'
		    |
		(
			ruleJvmFormalParameter
			':'
		)?
		ruleXExpression
	)
	'{'
	ruleXCasePart
	*
	(
		'default'
		':'
		ruleXExpression
	)?
	'}'
;

// Rule XCasePart
ruleXCasePart:
	ruleJvmTypeReference
	?
	(
		'case'
		ruleXExpression
	)?
	(
		':'
		ruleXExpression
		    |
		','
	)
;

// Rule XForLoopExpression
ruleXForLoopExpression:
	(
		'for'
		'('
		ruleJvmFormalParameter
		':'
	)
	ruleXExpression
	')'
	ruleXExpression
;

// Rule XBasicForLoopExpression
ruleXBasicForLoopExpression:
	'for'
	'('
	(
		ruleXExpressionOrVarDeclaration
		(
			','
			ruleXExpressionOrVarDeclaration
		)*
	)?
	';'
	ruleXExpression
	?
	';'
	(
		ruleXExpression
		(
			','
			ruleXExpression
		)*
	)?
	')'
	ruleXExpression
;

// Rule XWhileExpression
ruleXWhileExpression:
	'while'
	'('
	ruleXExpression
	')'
	ruleXExpression
;

// Rule XDoWhileExpression
ruleXDoWhileExpression:
	'do'
	ruleXExpression
	'while'
	'('
	ruleXExpression
	')'
;

// Rule XBlockExpression
ruleXBlockExpression:
	'{'
	(
		ruleXExpressionOrVarDeclaration
		';'?
	)*
	'}'
;

// Rule XExpressionOrVarDeclaration
ruleXExpressionOrVarDeclaration:
	(
		ruleXVariableDeclaration
		    |
		ruleXExpression
	)
;

// Rule XVariableDeclaration
ruleXVariableDeclaration:
	(
		'var'
		    |
		'val'
	)
	(
		(
			ruleJvmTypeReference
			ruleValidID
		)
		    |
		ruleValidID
	)
	(
		'='
		ruleXExpression
	)?
;

// Rule JvmFormalParameter
ruleJvmFormalParameter:
	ruleJvmTypeReference
	?
	ruleValidID
;

// Rule FullJvmFormalParameter
ruleFullJvmFormalParameter:
	ruleJvmTypeReference
	ruleValidID
;

// Rule XFeatureCall
ruleXFeatureCall:
	(
		'<'
		ruleJvmArgumentTypeReference
		(
			','
			ruleJvmArgumentTypeReference
		)*
		'>'
	)?
	ruleIdOrSuper
	(
		(
			'('
		)
		(
			(
				ruleXShortClosure
			)
			    |
			ruleXExpression
			(
				','
				ruleXExpression
			)*
		)?
		')'
	)?
	(
		ruleXClosure
	)?
;

// Rule FeatureCallID
ruleFeatureCallID:
	(
		ruleValidID
		    |
		'extends'
		    |
		'static'
		    |
		'import'
		    |
		'extension'
	)
;

// Rule IdOrSuper
ruleIdOrSuper:
	(
		ruleFeatureCallID
		    |
		'super'
	)
;

// Rule XConstructorCall
ruleXConstructorCall:
	'new'
	ruleQualifiedName
	(
		(
			'<'
		)
		ruleJvmArgumentTypeReference
		(
			','
			ruleJvmArgumentTypeReference
		)*
		'>'
	)?
	(
		(
			'('
		)
		(
			(
				ruleXShortClosure
			)
			    |
			ruleXExpression
			(
				','
				ruleXExpression
			)*
		)?
		')'
	)?
	(
		ruleXClosure
	)?
;

// Rule XBooleanLiteral
ruleXBooleanLiteral:
	(
		'false'
		    |
		'true'
	)
;

// Rule XNullLiteral
ruleXNullLiteral:
	'null'
;

// Rule XNumberLiteral
ruleXNumberLiteral:
	ruleNumber
;

// Rule XStringLiteral
ruleXStringLiteral:
	RULE_STRING
;

// Rule XTypeLiteral
ruleXTypeLiteral:
	'typeof'
	'('
	ruleQualifiedName
	ruleArrayBrackets
	*
	')'
;

// Rule XThrowExpression
ruleXThrowExpression:
	'throw'
	ruleXExpression
;

// Rule XReturnExpression
ruleXReturnExpression:
	'return'
	(
		ruleXExpression
	)?
;

// Rule XTryCatchFinallyExpression
ruleXTryCatchFinallyExpression:
	'try'
	ruleXExpression
	(
		(
			ruleXCatchClause
		)+
		(
			(
				'finally'
			)
			ruleXExpression
		)?
		    |
		'finally'
		ruleXExpression
	)
;

// Rule XSynchronizedExpression
ruleXSynchronizedExpression:
	(
		'synchronized'
		'('
	)
	ruleXExpression
	')'
	ruleXExpression
;

// Rule XCatchClause
ruleXCatchClause:
	(
		'catch'
	)
	'('
	ruleFullJvmFormalParameter
	')'
	ruleXExpression
;

// Rule QualifiedName
ruleQualifiedName:
	ruleValidID
	(
		(
			'.'
		)
		ruleValidID
	)*
;

// Rule Number
ruleNumber:
	(
		RULE_HEX
		    |
		(
			RULE_INT
			    |
			RULE_DECIMAL
		)
		(
			'.'
			(
				RULE_INT
				    |
				RULE_DECIMAL
			)
		)?
	)
;

// Rule JvmTypeReference
ruleJvmTypeReference:
	(
		ruleJvmParameterizedTypeReference
		(
			ruleArrayBrackets
		)*
		    |
		ruleXFunctionTypeRef
	)
;

// Rule ArrayBrackets
ruleArrayBrackets:
	'['
	']'
;

// Rule XFunctionTypeRef
ruleXFunctionTypeRef:
	(
		'('
		(
			ruleJvmTypeReference
			(
				','
				ruleJvmTypeReference
			)*
		)?
		')'
	)?
	'=>'
	ruleJvmTypeReference
;

// Rule JvmParameterizedTypeReference
ruleJvmParameterizedTypeReference:
	ruleQualifiedName
	(
		(
			'<'
		)
		ruleJvmArgumentTypeReference
		(
			','
			ruleJvmArgumentTypeReference
		)*
		'>'
		(
			(
				'.'
			)
			ruleValidID
			(
				(
					'<'
				)
				ruleJvmArgumentTypeReference
				(
					','
					ruleJvmArgumentTypeReference
				)*
				'>'
			)?
		)*
	)?
;

// Rule JvmArgumentTypeReference
ruleJvmArgumentTypeReference:
	(
		ruleJvmTypeReference
		    |
		ruleJvmWildcardTypeReference
	)
;

// Rule JvmWildcardTypeReference
ruleJvmWildcardTypeReference:
	'?'
	(
		ruleJvmUpperBound
		ruleJvmUpperBoundAnded
		*
		    |
		ruleJvmLowerBound
		ruleJvmLowerBoundAnded
		*
	)?
;

// Rule JvmUpperBound
ruleJvmUpperBound:
	'extends'
	ruleJvmTypeReference
;

// Rule JvmUpperBoundAnded
ruleJvmUpperBoundAnded:
	'&'
	ruleJvmTypeReference
;

// Rule JvmLowerBound
ruleJvmLowerBound:
	'super'
	ruleJvmTypeReference
;

// Rule JvmLowerBoundAnded
ruleJvmLowerBoundAnded:
	'&'
	ruleJvmTypeReference
;

// Rule QualifiedNameWithWildcard
ruleQualifiedNameWithWildcard:
	ruleQualifiedName
	'.'
	'*'
;

// Rule ValidID
ruleValidID:
	RULE_ID
;

// Rule XImportSection
ruleXImportSection:
	ruleXImportDeclaration
	+
;

// Rule XImportDeclaration
ruleXImportDeclaration:
	'import'
	(
		'static'
		'extension'
		?
		ruleQualifiedNameInStaticImport
		(
			'*'
			    |
			ruleValidID
		)
		    |
		ruleQualifiedName
		    |
		ruleQualifiedNameWithWildcard
	)
	';'?
;

// Rule QualifiedNameInStaticImport
ruleQualifiedNameInStaticImport:
	(
		ruleValidID
		'.'
	)+
;

RULE_HEX : ('0x'|'0X') ('0'..'9'|'a'..'f'|'A'..'F'|'_')+ ('#' (('b'|'B') ('i'|'I')|('l'|'L')))?;

RULE_INT : '0'..'9' ('0'..'9'|'_')*;

RULE_DECIMAL : RULE_INT (('e'|'E') ('+'|'-')? RULE_INT)? (('b'|'B') ('i'|'I'|'d'|'D')|('l'|'L'|'d'|'D'|'f'|'F'))?;

RULE_ID : '^'? ('a'..'z'|'A'..'Z'|'$'|'_') ('a'..'z'|'A'..'Z'|'$'|'_'|'0'..'9')*;

RULE_STRING : ('"' ('\\' .|~('\\'|'"'))* '"'?|'\'' ('\\' .|~('\\'|'\''))* '\''?);

RULE_ML_COMMENT : '/*' *?'*/' -> channel(HIDDEN);

RULE_SL_COMMENT : '//' ~('\n'|'\r')* ('\r'? '\n')? -> channel(HIDDEN);

RULE_WS : (' '|'\t'|'\r'|'\n')+ -> channel(HIDDEN);

RULE_ANY_OTHER : .;