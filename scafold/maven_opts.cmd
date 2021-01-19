


@set MAVEN_OPTS=-ea -Xss1536k -Xmx8g --add-opens=java.base/java.io=ALL-UNNAMED
@set MAVEN_OPTS=%MAVEN_OPTS% --add-opens=java.base/java.lang.invoke=ALL-UNNAMED
@set MAVEN_OPTS=%MAVEN_OPTS% --add-opens=java.base/java.lang.reflect=ALL-UNNAMED
@set MAVEN_OPTS=%MAVEN_OPTS% --add-opens=java.base/java.lang=ALL-UNNAMED
@set MAVEN_OPTS=%MAVEN_OPTS% --add-opens=java.base/java.net=ALL-UNNAMED
@set MAVEN_OPTS=%MAVEN_OPTS% --add-opens=java.base/java.util.concurrent=ALL-UNNAMED
@set MAVEN_OPTS=%MAVEN_OPTS% --add-opens=java.base/java.util=ALL-UNNAMED
@set MAVEN_OPTS=%MAVEN_OPTS% --add-opens=java.base/sun.net=ALL-UNNAMED
@set MAVEN_OPTS=%MAVEN_OPTS% --add-opens=java.management/com.sun.jmx.mbeanserver=ALL-UNNAMED
@set MAVEN_OPTS=%MAVEN_OPTS% --add-opens=java.management/java.lang.management=ALL-UNNAMED
@set MAVEN_OPTS=%MAVEN_OPTS% --add-opens=java.management/sun.management=ALL-UNNAMED

echo %MAVEN_OPTS%

@rem my %categories = ('Core Deploy Tests' => 'com.electriccloud.spec.categories.CoreDeployTests', 
@rem                  'Core Environment Tests' => 'com.electriccloud.spec.categories.CoreEnvironmentTests',
@rem                  'Core Flow Integration' => 'com.electriccloud.spec.categories.CoreFlowIntegrationTests',
@rem		  'Pipeline Tests' => 'com.electriccloud.spec.categories.PipelineTests',
@rem		  'Release Tests' => 'com.electriccloud.spec.categories.ReleaseTests',
@rem		  'ec-groovy Tests' => 'com.electriccloud.spec.categories.EcGroovyTests',
@rem		  'Platform Tests' => 'com.electriccloud.spec.categories.PlatformTests',
@rem                  'Retry Tests' => 'com.electriccloud.spec.categories.RetryTests',
@rem                  'Microservice Tests' => 'com.electriccloud.spec.categories.MicroservicesTests',
@rem                  'Portfolio Tests' => 'com.electriccloud.spec.categories.PortfolioTests',
@rem                  'Stage Artifact Tests' => 'com.electriccloud.spec.categories.StageArtifactTests');

@rem --batch-mode ^
timethis ^
  mvn ^
	-DBUILDNUMBER=144909 ^
    -Dworkers=1 ^
	--errors ^
	--fail-at-end ^
	-DCOMMANDER_SECURE="1" ^
	-Denforcer.fail=false ^
	-Dtags=com.electriccloud.spec.categories.PlatformTests  ^
	--file "./commander/commander-specs-tests/pom.xml" ^
	test
@rem 	install -DskipTests
@rem	--file "./commander/commander-specs-tests/pom.xml" ^
@rem	-Dtags=com.electriccloud.spec.categories.CoreDeployTests ^

exit /B
	
@rem	SRCTOP="N:/chronic3build/commander-git-main-full-sqlserver2017.144909-202012211207/nimbus"
@rem	MVN_REPO="C:/maven-repo/i686_win32"
@rem  MVN_WORKSPACE_REPO="file:N:/chronic3build/commander-git-main-full-sqlserver2017.144909-202012211207/out/i686_win32/maven-repo" TOOLS="O:/tools" 



rem sh O:/tools/common/apache-maven-3.5.3/bin/mvn --errors --strict-checksums --settings "N:/chronic3build/commander-git-main-full-sqlserver2017.144909-202012211207/nimbus/config/maven-settings.xml" -DBUILDNUMBER=144909 -DoutDir="N:/chronic3build/commander-git-main-full-sqlserver2017.144909-202012211207/out/i686_win32/nimbus/commander/commander-server" -Dworkers=1 --batch-mode \
rem --errors \
rem	--file "../../commander/commander-specs-tests/pom.xml" \
rem	--fail-at-end \
rem	-DCOMMANDER_SERVER="localhost" \
rem	-DCOMMANDER_PORT="8005" \
rem	-DCOMMANDER_SECURE="1" \
rem -DEC_LOG_ROOT="N:\chronic3build\commander-git-main-full-sqlserver2017.144909-202012211207/out/i686_win32/nimbus/systemtest/commander-specs-tests-com.electriccloud.spec.categories.MicroservicesTests.log" \
rem	-Dtags=com.electriccloud.spec.categories.MicroservicesTests \
rem	-Denforcer.fail=false \
rem	-Dcom.athaydes.spockframework.report.outputDir="N:/chronic3build/commander-git-main-full-sqlserver2017.144909-202012211207/out/i686_win32/nimbus/commander/commander-specs-tests/ec-spec-test-reports" \


@echo on