require 'yaml'

# MIGRATION STATUS: Not done yet.
# raise 'Migration already performed.' # Don't run this migration. Kept for posterity

def order_of_keys
  # This is just an example - edit to your liking.
  # To get the latest from your skeleton, run this in your console:
  # puts YAML.load(File.open('skeletons/cve.yml',).read).keys.join("\n")
  %w(
    CVE
    yaml_instructions
    curated_instructions
    curation_level
    reported_instructions
    reported_date
    announced_instructions
    announced_date
    published_instructions
    published_date
    description_instructions
    description
    bounty_instructions
    bounty
    reviews
    bugs_instructions
    bugs
    fixes_instructions
    fixes
    vcc_instructions
    vccs
    upvotes_instructions
    upvotes
    unit_tested
    discovered
    autodiscoverable
    specification
    subsystem
    interesting_commits
    i18n
    sandbox
    ipc
    discussion
    vouch
    stacktrace
    forgotten_check
    order_of_operations
    lessons
    mistakes
    CWE_instructions
    CWE
    CWE_note
    nickname_instructions
    nickname
  )
end

class CustomEncode
  def initialize(**opts)
    @opts = opts
  end

  def encode_with(coder)
    @opts.each { |k,v| coder.public_send :"#{k}=", v }
  end
end

class VHPHash < Hash
  def encode_with(coder)
    coder.style = Psych::Nodes::Scalar::LITERAL
    coder.tag = nil
    coder.map = self     
  end
end

def dump_nice_yaml(h)
  # On the console, to test this out
  h = YAML.load(File.open('skeletons/cve.yml', 'r').read)
  print Psych.dump(h)
end

ymls = Dir['cves/*.yml']
skel = YAML.load(File.open('skeletons/cve.yml', 'r').read)
ymls.each do |yml_file|
  h = YAML.load(File.open(yml_file, 'r').read)

  # Do stuff to your hash here.
  h['curated_instructions'] = skel['curated_instructions']
  h['discussion']           = skel['discussion']
  h['autodiscoverable']     = skel['autodiscoverable']
  h['order_of_operations']  = skel['order_of_operations']
  h['mistakes']             = skel['mistakes']

  # Reconstruct the hash in the order we specify
  out_h = VHPHash.new
  order_of_keys.each do |key|
    out_h[key] = h[key]
  end

  yml_txt = out_h.to_yaml[4..-1] # strip off ---\n
  yml_txt = Psych.dump(CustomEncode.new map: out_h, style: Psych::Nodes::Scalar::LITERAL, tag: nil)
  File.open(yml_file, "w") do |file|
    stripped_yml = ""
    yml_txt.each_line do |line|
      stripped_yml += "#{line.rstrip}\n" # strip trailing whitespace
    end
    file.write(stripped_yml)
    print '.'
  end
end
puts 'Done!'
