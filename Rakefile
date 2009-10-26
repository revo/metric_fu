require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'lib/metric_fu'

desc "Run all specs in spec directory"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
   t.rcov = true
   t.rcov_opts = ['--exclude', 'spec,config,Library,usr/lib/ruby']
   t.rcov_dir = File.join(File.dirname(__FILE__), "tmp")
end

MetricFu::Configuration.run do |config|
  config.template_class = AwesomeTemplate
end

task :default => [:"metrics:all"]

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "metric_fu"
    gemspec.summary = "A fistful of code metrics, with awesome templates and graphs"
    gemspec.description = "Code metrics from Flog, Flay, RCov, Saikuro, Churn, Reek, Roodi and Rails' stats task"
    gemspec.email = "jake.scruggs@gmail.com"
    gemspec.homepage = "http://metric-fu.rubyforge.org/"
    gemspec.authors = ["Jake Scruggs", "Sean Soper", "Andre Arko", "Petrik de Heus", "Grant McInnes", "Nick Quaranto", "Édouard Brière"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
