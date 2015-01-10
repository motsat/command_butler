# CommandButler

It is a gem that will continue to run the command that was written to a file interactively

## Installation

Add this line to your application's Gemfile:

    gem 'command_butler'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install command_butler

## Usage 
Create a file wrote the run command. format is yml
### command execution only
    $ command_butler execute sample/simple_commands.yml

![Alt Text](https://raw.githubusercontent.com/motsat/command_butler/feature/readme_update/images/command_butler_simple.gif)

### replace value in the command result
    $ command_butler execute sample/set_val.yml

![Alt Text](https://raw.githubusercontent.com/motsat/command_butler/feature/readme_update/images/command_butler_set_val.gif)

### replace value in the configuration file

    $ command_butler execute sample/replace_with_valfile.yml 
    $                           --val_file=sample/val_file/station.yml
    $

![Alt Text](https://raw.githubusercontent.com/motsat/command_butler/feature/readme_update/images/command_butler_replace_val.gif)

## Configuration File
format  : yaml

define a single command in an array of YAML

    [yml]
      - pwd
      - echo 'Hellow World'
      - ls -al

Change of directory is not a cd command to define the Chdir

    [yml]
      - pwd
      -
        chdir: /Users
      - pwd

can use the results to standard output as a parameter
That you use the "set" command
set the parameter name is optional . And parameter names , to match a character string in the command to be replaced

    [yml]

      -
       command: date
       set_val: $DATE_VALUE
      - echo $DATE_VALUE


## Contributing

1. Fork it ( https://github.com/motsat/command_butler/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


