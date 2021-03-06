/*******************************************************************************
 * Copyright (c) 2011 itemis AG (http://www.itemis.eu) and others.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package org.eclipse.xtext.ui.editor.outline.impl;

/**
 * @author Jan Koehnlein - Initial contribution and API
 * @since 2.2
 */
public class OutlineMode {

	private String id;

	private String description;

	public OutlineMode(String id, String description) {
		super();
		this.description = description;
		this.id = id;
	}

	public String getDescription() {
		return description;
	}
	
	public String getId() {
		return id;
	}
}
