require 'rspec/core/rake_task'

task :default => :spec

desc "Run tests"
RSpec::Core::RakeTask.new(:spec)

desc "Builds gem"
task :build_gem do
  puts %s{gem build square_graph.gemspec}
  output = `gem build square_graph.gemspec`
  puts output
  print %s{Do you want to install the gem (y|n)? }
  while !%w{y n}.include?(inputs = STDIN.gets[0])
    print %s{Please use either y or n: }
  end
  if inputs == 'y'
    sh %s{gem install }.to_s + output.split.last
  else
    p %s{Alright, peace out.}
  end
end
