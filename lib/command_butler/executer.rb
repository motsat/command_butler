require 'command_butler/mediator'
module CommandButler
  class Executer < Thor
    # default_task :execute
    desc :filename, "commands list file"
    option :val_file, :type => :string
    def execute(file_name)
      Mediator.new.execute(file_name, options)
    end
  end
end

