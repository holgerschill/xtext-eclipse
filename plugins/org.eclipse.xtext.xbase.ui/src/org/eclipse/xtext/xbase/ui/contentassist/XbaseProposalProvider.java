/*
* generated by Xtext
*/
package org.eclipse.xtext.xbase.ui.contentassist;

import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.Assignment;
import org.eclipse.xtext.ui.editor.contentassist.ContentAssistContext;
import org.eclipse.xtext.ui.editor.contentassist.ICompletionProposalAcceptor;
/**
 * see http://www.eclipse.org/Xtext/documentation/latest/xtext.html#contentAssist on how to customize content assistant
 */
public class XbaseProposalProvider extends AbstractXbaseProposalProvider {
	
	@Override
	public void completeJvmParameterizedTypeReference_Type(EObject model, Assignment assignment,
			ContentAssistContext context, ICompletionProposalAcceptor acceptor) {
	}
	
	@Override
	public void completeXTypeLiteral_Type(EObject model, Assignment assignment, ContentAssistContext context,
			ICompletionProposalAcceptor acceptor) {
	}
}
