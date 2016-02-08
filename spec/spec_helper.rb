require 'deps/OtpErlang.jar'
require 'lib/erlang/jinterface'
Dir["spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10
  config.order = :random

  Kernel.srand config.seed
  
  config.before(:suite) do
    @erl_pid = start_node
  end

  config.after(:suite) do
    stop_node(@erl_pid)
  end
end
