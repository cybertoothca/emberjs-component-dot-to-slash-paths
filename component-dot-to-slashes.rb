# make sure to place this script at the root of your emberjs application; same level as your package.json
files = File.join('{app,tests}', '**', '*.{hbs,js}')

Dir.glob(files) do |file_name|
  puts "Scanning #{file_name}"
  contents = File.read(file_name)
  # scan the js/hbs file using the following regex (tested here https://regex101.com/r/KaPP9l/8)
  to_replace = contents.scan(/\{\{[\#|\/]?[a-z]*[\-]+[a-z|\-|\.]*/)

  # if no dot-notation components or helpers are found move on to the next file
  next if to_replace.empty?

  new_contents = String.new(contents)
  # for each component/helper with dot-notation, turn it to slash-notation and replace in a copy of the file's contents
  to_replace.each do |dot_name|
    slash_name = dot_name.gsub('.', '/')
    puts "\tReplacing: #{dot_name} => #{slash_name}"
    new_contents = new_contents.gsub(dot_name, slash_name)
  end
  # save the file with the altered contents
  File.open(file_name, 'w') { |file| file.puts new_contents }
end
