def require_relative_to_root(file_path)
  rails_root = find_rails_root(File.dirname(__FILE__))
  require(File.expand_path("#{rails_root}/#{file_path}"))
end

def find_rails_root(dir)
  return dir if is_root?(dir)
  find_rails_root(File.expand_path(dir + "/../"))
end

def is_root?(dir) 
  entries = Dir.entries(dir)
  return entries.include?("app") &&
         entries.include?("config") &&
         entries.include?("spec") &&
         entries.include?("db")
end
