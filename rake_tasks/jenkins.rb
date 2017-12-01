namespace :jenkins do
  task :all do
    base = ENV['BUNDLE_GEMFILE'].nil? ? 'rake' : "#{ENV['BUNDLE_BIN_PATH']} exec rake"
    failed_tasks = []
    JENKINS_TASKS.each do |target|
      # puts "Executing '#{base} #{target}'"
      failed_tasks << target unless system("#{base} #{target}")
    end
    unless failed_tasks.empty?
      warn "The following targets failed: #{failed_tasks.join(', ')}"
      exit(1)
    end
  end
end

desc "Run all jenkins tasks (#{JENKINS_TASKS.join(', ')})"
task jenkins: ['jenkins:all']
