require 'yaml'

# MIGRATION STATUS: Not done yet.
# raise 'Migration already performed.' # Don't run this migration. Kept for posterity

def weird_formatted_keys
  %w(
    
  )
end

ymls = Dir['cves/*.yml'] 
ymls.each do |yml_file|
  yml_string = File.open(yml_file, 'r').read
  h = YAML.load(yml_string)

  yml_string = yml_string.gsub('\n', "\n")

  # Do stuff to your hash here.

  # Reconstruct the hash in the order we specify
  # out_h = {}
  # order_of_keys.each do |key|
  #   out_h[key] = h[key]
  # end

  # Generate the new YML, clean it up, write it out.
  File.open(yml_file, "w+") do |file|
    
    # yml_txt = out_h.to_yaml[4..-1] # strip off ---\n
    stripped_yml = ""
    yml_string.each_line do |line|
      stripped_yml += "#{line.rstrip}\n" # strip trailing whitespace
    end
    file.write(stripped_yml)
    print '.'
  end
end
puts 'Done!'
