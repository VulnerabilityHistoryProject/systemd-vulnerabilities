require 'byebug'
require 'require_all'
require 'rspec/core/rake_task'

desc 'Run the specs by default'
task default: :spec

RSpec::Core::RakeTask.new(:spec)

namespace :pull do

  # Commented out for travis build
  # desc 'Initialize CVE ymls from Tomcat website'
  # task :cves do
  #   PullLatestCVEs.new.run
  # end

  desc 'Clone all the Tomcat source repos'
  task :repo do
    Dir.chdir("tmp/") do
      `git clone https://github.com/systemd/systemd.git`
    end
  end
end

namespace :curate do
  desc 'List all CVEs with a fix and not curated'
  task :ready do
    CurateReady.new.print_readiness(true)
  end

  desc 'List all CVEs without a fix and not curated'
  task :not_ready do
    CurateReady.new.print_readiness(false)
  end
end
