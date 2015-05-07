package org.eclipse.xtext.xtext.ui.wizard.project

import org.eclipse.core.resources.IProject
import org.eclipse.xtext.ui.util.IProjectFactoryContributor.IFileCreator
import static org.eclipse.xtext.xtext.ui.wizard.project.XtextProjectInfo.*

/**
 * Contributes Web parts to an *.web project<br>
 * <b>WIP:</b> Most of the content will be generated with the web generator fragment.
 * 
 * @author Dennis Huebner - Initial contribution and API
 * @since 2.9
 */
class WebProjectContributor extends DefaultProjectFactoryContributor {

	XtextProjectInfo projectInfo

	new(XtextProjectInfo projectInfo) {
		this.projectInfo = projectInfo
	}

	override contributeFiles(IProject project, IFileCreator fc) {
		contributeGradleFiles(fc)
		contributeXtendCode(fc)
		contributeWebFiles(fc)

		'''
			To build this project you need to install Gradle.
			https://gradle.org/docs/current/userguide/installation.html
			
			The following tasks are available:
			 eclipse - generates Eclipse metadata like .project and .classpath
			 jettyRun - starts a server with an example editor
			
			While the server is running, point your web browser to http://localhost:8080
			to test the editor for your language.
		'''.writeToFile(fc, 'readme.txt')
	}

	def contributeWebFiles(IFileCreator fc) {
		'''
			<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Strict//EN" "http://www.w3.org/TR/html4/strict.dtd">
			<html>
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
				<meta http-equiv="Content-Language" content="en-us">
				<meta http-equiv="Cache-Control" content="no-store" />
				<title>Example Web Editor</title>
				<link rel="stylesheet" type="text/css" href="style.css" />
				<script src="http://requirejs.org/docs/release/2.1.17/minified/require.js"></script>
				<script type="text/javascript">
					require.config({
						bundles: {
							"orion-edit": ["orion/Deferred", "orion/keyBinding", "orion/editor/editorFeatures",
								"orion/editor/textStyler", "orion/editor/textModel", "orion/editor/textTheme",
								"orion/editor/textView", "orion/editor/contentAssist", "orion/editor/editor",
								"orion/editor/projectionTextModel"]
						},
						paths: {
						   	"jquery": "http://code.jquery.com/jquery-2.1.3.min",
						   	"orion-edit": "http://orionhub.org/edit/edit"
						}
					});
					require(["xtext/xtext"], function(xtext) {
						xtext.createEditor({theme: "https://orionhub.org/edit/edit.css"});
					});
				</script>
			</head>
			<body>
			
			<div class="container">
				<div class="header">
					<h1>Example �projectInfo.languageNameAbbreviation� Web Editor</h1>
				</div>
				<div class="content">
					<div class="xtext-editor" data-editor-lang="�projectInfo.fileExtension�"></div>
				</div>
			</div>
			
			</body>
			</html>
		'''.writeToFile(fc, 'src/main/webapp/index.html')

		'''
			html {
				height: 100%;
			}
			
			body {
				width: 100%;
				height: 100%;
				overflow: hidden;
				font: 16px Helvetica,sans-serif;
			}
			
			a {
				color: #22a;
				text-decoration: none;
			}
			
			a:hover {
				text-decoration: underline;
			}
			
			.container {
				display: block;
				position: absolute;
				   top: 0;
				   bottom: 0;
				   left: 0;
				   right: 0;
				margin: 20px;
			}
			
			.header {
				display: block;
				position: absolute;
				background-color: #e8e8e8;
				top: 0;
				left: 0;
				right: 0;
				height: 60px;
				padding: 10px;
			}
			
			.content {
				display: block;
				position: absolute;
				top: 90px;
				bottom: 0;
				left: 0;
				   width: 640px;
			}
			
			.xtext-editor {
				display: block;
				position: absolute;
				   top: 0;
				   bottom: 0;
				   left: 0;
				   right: 0;
				padding: 4px;
				border: 1px solid #aaa;
			}
			
			.contentassist .proposal-default {
				color: #888;
			}
			
			.contentassist .proposal-name {
				color: #000;
				padding-right: 12px;
			}
		'''.writeToFile(fc, 'src/main/webapp/style.css')

	}

	def contributeGradleFiles(IFileCreator fc) {
		'''
			apply plugin: 'eclipse'
			apply plugin: 'war'
			
			sourceSets {
				main.java.srcDir 'src/main/xtend-gen'
			}
			
			dependencies {
				compile group: 'org.eclipse.xtend', name: 'org.eclipse.xtend.lib', version: '2.9.+'
				compile group: 'org.eclipse.xtext', name: 'org.eclipse.xtext.web.servlet', version: '2.9.+'
				compile project(':�projectInfo.projectName�')
				compile project(':�projectInfo.ideProjectName�')
				providedCompile group: 'org.eclipse.jetty', name: 'jetty-annotations', version: '9.2.+'
				providedCompile group: 'org.slf4j', name: 'slf4j-log4j12', version: '1.7.+'
			}
			
			task jettyRun(type:JavaExec) {
				dependsOn(sourceSets.main.runtimeClasspath)
				classpath = sourceSets.main.runtimeClasspath.filter{it.exists()}
				main = "�projectInfo.basePackage�.�WEB�.ServerLauncher"
			}
			
			allprojects {
				repositories { 
					jcenter()
					mavenLocal()
					maven {
						url "https://oss.sonatype.org/content/repositories/snapshots/"
					}
				}
			}
			
			subprojects {
				apply plugin: 'java'
				sourceSets.main.java.srcDirs = ['src', 'src-gen', 'xtend-gen']
				sourceSets.main.resources.srcDirs = ['src', 'src-gen']
			}
			
			configure(project(':�projectInfo.projectName�')) {
				dependencies {
					compile group: 'org.eclipse.xtext', name: 'org.eclipse.xtext.common.types', version: '2.9.+'
				}
			}
			
			configure(project(':�projectInfo.ideProjectName�')) {
				dependencies { 
					compile project(':�projectInfo.projectName�')
					compile group: 'org.eclipse.xtext', name: 'org.eclipse.xtext.ide', version: '2.9.+' 
				}
			}
		'''.writeToFile(fc, 'build.gradle')

		'''
			includeFlat '�projectInfo.projectName�'
			includeFlat '�projectInfo.ideProjectName�'
		'''.writeToFile(fc, 'settings.gradle')

	}

	def contributeXtendCode(IFileCreator fc) {
		'''
			package �projectInfo.basePackage�.�WEB�
			
			import java.net.InetSocketAddress
			import org.eclipse.jetty.annotations.AnnotationConfiguration
			import org.eclipse.jetty.server.Server
			import org.eclipse.jetty.webapp.MetaInfConfiguration
			import org.eclipse.jetty.webapp.WebAppContext
			import org.eclipse.jetty.webapp.WebInfConfiguration
			import org.eclipse.jetty.webapp.WebXmlConfiguration
			
			class ServerLauncher {
				def static void main(String[] args) {
					val server = new Server(new InetSocketAddress('localhost', 8080))
					server.handler = new WebAppContext => [
						resourceBase = 'src/main/webapp'
						welcomeFiles = #["index.html"]
						contextPath = "/"
						configurations = #[
							new AnnotationConfiguration,
							new WebXmlConfiguration,
							new WebInfConfiguration,
							new MetaInfConfiguration
						]
						setAttribute(WebInfConfiguration.CONTAINER_JAR_PATTERN, ".*org\\.eclipse\\.xtext\\.web.*|.*�projectInfo.webProjectName.replaceAll('\\.','\\\\\\\\.')�.*")
					]
					server.start
					server.join
				}
			}
		'''.writeToFile(fc, baseWebPackagePath() + '/ServerLauncher.xtend')
		'''
			package �projectInfo.basePackage�.�WEB�
			
			import com.google.inject.Guice
			import java.util.concurrent.ExecutorService
			import java.util.concurrent.Executors
			import javax.servlet.annotation.WebServlet
			import �projectInfo.basePackage�.�projectInfo.languageNameAbbreviation�RuntimeModule
			import �projectInfo.basePackage�.�projectInfo.languageNameAbbreviation�StandaloneSetup
			import org.eclipse.xtext.web.servlet.XtextServlet
			import com.google.inject.Module
			
			@WebServlet(name = "Xtext Services", urlPatterns = "/xtext-service/*")
			class �projectInfo.languageNameAbbreviation�XtextServlet extends XtextServlet {
			
					ExecutorService executorService
			
				override init() {
					super.init()
					executorService = Executors.newCachedThreadPool
					new �projectInfo.languageNameAbbreviation�StandaloneSetup {
						override createInjector() {
							val runtimeModule = new �projectInfo.languageNameAbbreviation�RuntimeModule as Module
							val webModule = new �projectInfo.languageNameAbbreviation�WebModule(executorService)
							return Guice.createInjector(runtimeModule, webModule)
						}
					}.createInjectorAndDoEMFRegistration
				}
			
					override destroy() {
					if (executorService !== null)
						executorService.shutdown()
					executorService = null
					super.destroy()
				}
			
			}
		'''.
			writeToFile(
				fc, '''�baseWebPackagePath�/�projectInfo.languageNameAbbreviation�XtextServlet.xtend''')

		'''
				package �projectInfo.basePackage�.�WEB�
				
				import com.google.inject.Binder
				import com.google.inject.name.Names
				import java.util.concurrent.ExecutorService
				import org.eclipse.xtend.lib.annotations.Accessors
				import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor
				import org.eclipse.xtext.ide.LexerIdeBindings
				import org.eclipse.xtext.ide.editor.contentassist.antlr.IContentAssistParser
				import org.eclipse.xtext.ide.editor.contentassist.antlr.internal.Lexer
				import org.eclipse.xtext.service.AbstractGenericModule
				import �projectInfo.basePackage�.ide.contentassist.antlr.�projectInfo.languageNameAbbreviation�Parser
				import �projectInfo.basePackage�.ide.contentassist.antlr.internal.Internal�projectInfo.languageNameAbbreviation�Lexer
				import org.eclipse.xtext.web.server.persistence.IResourceBaseProvider
				
				@Accessors
				@FinalFieldsConstructor
				class �projectInfo.languageNameAbbreviation�WebModule extends AbstractGenericModule {
				
						val ExecutorService executorService
				
						IResourceBaseProvider resourceBaseProvider
				
						def configureExecutorService(Binder binder) {
						binder.bind(ExecutorService).toInstance(executorService)
					}
				
						def configureContentAssistLexer(Binder binder) {
						binder.bind(Lexer).annotatedWith(Names.named(LexerIdeBindings.CONTENT_ASSIST)).to(Internal�projectInfo.languageNameAbbreviation�Lexer)
					}
				
						def Class<? extends IContentAssistParser> bindIContentAssistParser() {
						�projectInfo.languageNameAbbreviation�Parser
					}
				
				//	def Class<? extends IServerResourceHandler> bindIServerResourceHandler() {
				//		FileResourceHandler
				//	}
				
						def configureResourceBaseProvider(Binder binder) {
						if (resourceBaseProvider !== null)
							binder.bind(IResourceBaseProvider).toInstance(resourceBaseProvider)
					}
				
				}
			'''.writeToFile(fc, '''�baseWebPackagePath�/�projectInfo.languageNameAbbreviation�WebModule.xtend''')

		}

		def baseWebPackagePath() {
			return 'src/main/java/' + projectInfo.basePackagePath + '/' + WEB
		}

	}