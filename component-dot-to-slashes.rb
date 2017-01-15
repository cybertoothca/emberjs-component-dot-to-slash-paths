files = File.join('frontend', '{app,tests}', '**', '*.{hbs,js}')

Dir.glob(files) do |file_name|
  puts "Scanning #{file_name}"
  contents = File.read(file_name)
  to_replace = contents.scan(/\{\{[\#|\/]?[a-z]*[\-]+[a-z|\-|\.]*/)

  next if to_replace.empty?

  new_contents = String.new(contents)
  to_replace.each do |dot_name|
    slash_name = dot_name.gsub('.', '/')
    puts "Replacing: #{dot_name} => #{slash_name}"
    new_contents = new_contents.gsub(dot_name, slash_name)
  end
  # puts new_contents
  File.open(file_name, 'w') { |file| file.puts new_contents }
end
