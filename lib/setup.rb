require 'tar'
include Util::Tar
module Setup

   def bundle_and_tar
      io = Util::Tar::tar('template')
      f =  File.open('compress_template', 'w+')
      f.binmode
      f.write io.read
      f.close
   end	

   def unbundle_and_untar(path, projectname)
   	 f = File.open(path.concat('compress_template'), 'r')
   	 puts "Writing #{File.expand_path(f)} To:: #{projectname}.... "
   	 b = f.read
   	 ba = StringIO.new(b)
   	 Util::Tar::untar(ba,projectname)
   end

   def scaffold
   	  puts "Adding Directory Structure"
   	  Dir.mkdir("reports2")
   	  FileUtils::mkdir_p "/tests/spec"
   	  FileUtils::mkdir_p("#{dir_name}/reports") \
   	  		unless File.exists?('reports') 
   end

   def cml_options
		options={}
		#ruby.about.com/od/advancedruby/a/optionparser.htm
		optparse = OptionParser.new do |opts|

		   opts.banner = "Usage: runregress [options]"

		   opts.on("-h", "--help", "Display this screen") do |h|
		      puts opts
		      exit
		   end

		   opts.on('-n', '--new PROJECTNAME','Create new project')do |projectname|
		      options[:projectname] = projectname
		   end

		   opts.on('-r', '--test_list FILENAME', 'File with Tests for this regression') do |file|
		      options[:regression_file] = file
		      puts "\nRunning Regression with Test_List from: #{file} \n"
		   end

		   opts.on('-t', '--test test1,test2', Array, 'tests to run') do |tests|
		      options[:testlist] = tests
		      puts "Running Tests: #{options[:testlist]}"
		   end
		end.parse!
		options
	end   
end