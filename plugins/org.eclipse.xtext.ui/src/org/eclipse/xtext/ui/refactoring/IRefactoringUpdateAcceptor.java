/*******************************************************************************
 * Copyright (c) 2010 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.ui.refactoring;

import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.emf.common.util.URI;
import org.eclipse.ltk.core.refactoring.Change;
import org.eclipse.text.edits.TextEdit;
import org.eclipse.xtext.ui.refactoring.impl.IRefactoringDocument;
import org.eclipse.xtext.ui.refactoring.impl.RefactoringUpdateAcceptor;
import org.eclipse.xtext.ui.refactoring.impl.StatusWrapper;

import com.google.inject.ImplementedBy;

/**
 * Aggregates document updates as {@link Change Changes} or {@link TextEdits}. Clients can report issues to the
 * refactoring status.
 * 
 * @author Jan Koehnlein - Initial contribution and API
 */
@ImplementedBy(RefactoringUpdateAcceptor.class)
public interface IRefactoringUpdateAcceptor {

	void accept(URI resourceURI, TextEdit textEdit);

	void accept(URI resourceURI, Change change);

	StatusWrapper getRefactoringStatus();
	
	IRefactoringDocument getDocument(URI resourceURI);
	
	/**
	 * Returns a composite change of all accepted updates.
	 */
	Change createCompositeChange(String name, IProgressMonitor monitor);

}