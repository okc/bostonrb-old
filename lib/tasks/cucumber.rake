$LOAD_PATH.unshift(::Rails.root.to_s + '/vendor/plugins/cucumber/lib') if File.directory?(::Rails.root.to_s + '/vendor/plugins/cucumber/lib')

begin
  gem 'cucumber' #, '=0.3.11'
  require 'cucumber/rake/task'

  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = %w(--format progress)
    t.fork          = true
  end
  task :features => 'db:test:prepare'
rescue LoadError
  desc 'Cucumber rake task not available'
  task :features do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
  end
end
