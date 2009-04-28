<?xml version='1.0' encoding='utf-8'?>

<!-- XHTML-to-Memoir converter by Fletcher Penney
	specifically designed for use with MultiMarkdown created XHTML

	Uses the LaTeX memoir class for output with the twoside option
	
	Format as 6.0in x 9.0in page size
	
	Code blocks display in poetry mode
	
	MultiMarkdown Version 2.0.b5
	
	$Id: 6x9book-poetry.xslt 479 2008-01-12 23:04:13Z fletcher $
-->

<!-- 
# Copyright (C) 2005-2008  Fletcher T. Penney <fletcher@fletcherpenney.net>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the
#    Free Software Foundation, Inc.
#    59 Temple Place, Suite 330
#    Boston, MA 02111-1307 USA
-->

	
<xsl:stylesheet
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:html="http://www.w3.org/1999/xhtml"
	version="1.0">

	<xsl:import href="6x9book.xslt"/>
	
	<xsl:template match="/">
		<xsl:apply-templates select="html:html/html:head"/>
		<xsl:apply-templates select="html:html/html:body"/>
		<xsl:call-template name="latex-footer"/>
	</xsl:template>


	<!-- code block => Now it's poetry -->
	<xsl:template match="html:pre[child::html:code]">
		<xsl:text>\begin{adjustwidth}{4em}{4em}
\setverbatimfont{\normalfont}
\begin{verbatim}

</xsl:text>
		<xsl:value-of select="."/>
		<xsl:text>
\end{verbatim}
\end{adjustwidth}

</xsl:text>
	</xsl:template>


</xsl:stylesheet>