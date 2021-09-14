function out = runtests
  % runtests Run all the tests in mlxshake
  %
  % rslt = mlxshake.test.runtests
  %
  % Runs all the tests in mlxshake, presenting results on the command
  % line and producing results output files.
  %
  % The results output files are
  % created in a directory named "test-output" under the current directory.
  % Output files:
  % test-output/
  %   junit/
  %     mlxshake/
  %       results.xml     - JUnit XML format test results
  %   cobertura/
  %     coverage.xml      - Cobertura format code coverage report
  %
  % Examples:
  % mlxshake.test.runtests
  
  import matlab.unittest.TestSuite
  import matlab.unittest.TestRunner
  import matlab.unittest.plugins.CodeCoveragePlugin
  import matlab.unittest.plugins.codecoverage.CoberturaFormat
  import matlab.unittest.plugins.XMLPlugin;
  
  baseDir = pwd;
  testOutDir = [baseDir '/test-output'];
  if exist(testOutDir, 'dir')
      rmdir(testOutDir, 's');
  end
  mkdir(testOutDir);
  
  suite = TestSuite.fromPackage('janklab.mlxshake.test', 'IncludingSubpackages', true);
  
  runner = TestRunner.withTextOutput;
  mkdir([testOutDir '/cobertura']);
  coberturaOutFile = [testOutDir '/cobertura/coverage.xml'];
  coveragePlugin = CodeCoveragePlugin.forPackage('mlxshake', ...
      'Producing',CoberturaFormat(coberturaOutFile ), ...
      'IncludingSubpackages', true);
  runner.addPlugin(coveragePlugin);
  mkdir([testOutDir '/junit/mlxshake']);
  junitXmlPlugin = XMLPlugin.producingJUnitFormat(...
      [testOutDir '/junit/mlxshake/results.xml']);
  runner.addPlugin(junitXmlPlugin);
  
  out = runner.run(suite);
  
  end
  