require_relative "./spec_helper_lite"

describe "spec_helper_lite" do
  it "know when directory is rails root" do
    root_dir = File.expand_path(File.dirname(__FILE__) + "/../")
    is_root?(root_dir).should be_true
  end

  it "know when directory is not rails root" do
    not_root_dir = File.dirname(__FILE__) 
    is_root?(not_root_dir).should be_false 
  end

  it "goes on level back to find the root" do
    current_directory = File.dirname(__FILE__)
    root_dir = find_rails_root(current_directory)
    is_root?(root_dir).should be_true
  end

  it "goes back as many level as needed to find the root" do
    current_directory = File.expand_path(File.dirname(__FILE__) + "/../app/models/") 
    root_dir = find_rails_root(current_directory)
    is_root?(root_dir).should be_true
  end
end
