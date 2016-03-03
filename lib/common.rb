module Common
	require 'yaml'

	if(File.exists?('config/config.yml'))
		CONFIG = YAML.load_file('config/config.yml') #unless defined? CONFIG
	else
		puts 'WARNING: Config file not found'
	end

	def regression_list(filename)
		filename =  "#{Dir.pwd}" + "/#{filename}"
		puts "searching for #{filename}\n"
		if(File.exists?(filename))
			result = YAML.load_file(filename) #unless defined? CONFIG
		else
			puts "\n\n#{filename} was not found. \nPlease check the file then try again.\n\n"
			exit(1)
		end
		result
	end

	def logfilename
	   time_formatted = Time.now.strftime('%m_%d_%Y_%I_%M_%p') #EXAMPLE: 01_14_2016_11_13_AM
	   filenametime = [time_formatted,'_regression.log'].join
	end

	# todo: request test id from factory or test-id api/application
	def test_id
		return {test_id:CONFIG['testid'], password: CONFIG['password']}
	end

	def config
		return CONFIG
	end

	def env
		CONFIG['env']
	end

	def browser
		CONFIG['browser']
	end

	def dayofweek
		Date.today.strftime("%A")
	end

	# check RUBY_PLATFORM to determine OS. returns string (uppercase)
	def os
		if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
			"WINDOWS"
		elsif (/darwin/ =~ RUBY_PLATFORM) != nil
			"MAC"
		else
			"LINUX"
		end
	end

	################################################################
	# creates the test list for this particular regression run
	# sources of test for tests is -r & test_list or -t options
	################################################################
	def testlist_constructor (regression_test_list = nil)
	  constructor_rspec_testlist = Array.new

	  if (regression_test_list.nil?)
	     spec_dir_content = Dir[Dir.pwd + "/tests/spec/*_spec.rb"]
	     spec_dir_content.each do |test|
	        puts "Adding... #{File.basename(test)}..."
	        constructor_rspec_testlist.push("#{$test_dir_path}" + "#{File.basename(test)}" )         
	     end
	     return constructor_rspec_testlist
	  end

	  # case: tests passed via command line or from a test_list
	  regression_test_list.each do |test|
	        puts "Adding... #{File.basename(test)}..."
	        constructor_rspec_testlist.push("#{$test_dir_path}" + "#{File.basename(test)}" )         
	  end
	  return constructor_rspec_testlist
	end

	def run_acceptance_tests (reportfile)
	  STDOUT.puts "Starting Test Acceptance Tests"
	  result1, err, status = Open3.capture3('cucumber', 'tests/acceptance')

	  # Give user feedback without going into the regression logs
	  if err.length != 0
	     puts "ERROR FOUND, WRITING TO #{reportfile.path}"
	  else
	     puts "NO ERRORS FOUND."
	  end
	  STDOUT.puts "Finished Acceptance Testing"
	end


end
