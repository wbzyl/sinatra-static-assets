path = File.expand_path(File.join(File.dirname(__FILE__), "../lib"))
$:.unshift(path) unless $:.include?(path)

def asset_timestamp(source)
  File.mtime("./test/public/#{source}").to_i.to_s
end