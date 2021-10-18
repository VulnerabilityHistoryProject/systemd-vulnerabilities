require 'yaml'
require 'csv'
require 'set'

# MIGRATION STATUS: Not done yet.
# raise 'Migration already performed.' # Don't run this migration. Kept for posterity

Dir['cves/*.yml'].each do |yml_file|
  yml = YAML.load(File.open(yml_file, 'r').read)

  vcc_set = Set.new
  begin 
  yml['fixes'].each do |fix|
    sha = fix['commit']
    unless sha.to_s.empty?
      Dir.chdir 'c:\code\archeogit' do 
        str = `archeogit --config-file C:\\code\\systemd-vulnerabilities\\migrations\\archeogit.json blame --csv c:\\code\\systemd #{sha}`
        CSV.parse(str, headers: true, return_headers: false).each do |row|
          vcc_set << row[2]
        end
      end  
    end
  end
rescue 
  require 'byebug'; byebug
end

  yml['vccs'] = vcc_set.map do |vcc|
    {'commit' => vcc, note: 'Discovered automatically by archeogit.' }
  end
  # require 'byebug'; byebug

  # Generate the new YML, clean it up, write it out.
  File.open(yml_file, "w+") do |file|
    yml_txt = yml.to_yaml[4..-1] # strip off ---\n
    stripped_yml = ""
    yml_txt.each_line do |line|
      stripped_yml += "#{line.rstrip}\n" # strip trailing whitespace
    end
    file.write(stripped_yml)
    print '.'
  end
end
puts 'Done!'
