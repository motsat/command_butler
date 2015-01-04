require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
describe CommandButler::CommandObject do

  before do
    @original_command = "hello REPLACE_STRING"
  end

  subject (:command) do
    command = CommandButler::CommandObject.new({"command"=> @original_command})
    command.replace_command(val:{"REPLACE_STRING"=>"world"})
    command
  end

  it "replaced? changed" do
    is_expected.to be_replaced
  end

  it "command string changed" do
    expect(command.command).to eq("hello world")
  end

  it "original command is no change" do
    expect(command.original_command).to eq(@original_command)
  end

end

