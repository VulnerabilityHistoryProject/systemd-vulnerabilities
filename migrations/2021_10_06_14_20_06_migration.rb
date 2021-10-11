require 'yaml'

# MIGRATION STATUS: Not done yet.
# raise 'Migration already performed.' # Don't run this migration. Kept for posterity

def initial_cves_to_cwes
# Copied from: https://www.cvedetails.com/vulnerability-list/vendor_id-7971/product_id-38088/Freedesktop-Systemd.html
# We'll curate from there but this is our starting point
  {
    "CVE-2021-33910" =>	'770',
    "CVE-2020-13776" =>	'20',
    "CVE-2020-13529" =>	'290',
    "CVE-2020-1712" =>	'416',
    "CVE-2019-20386" =>	'772',
    "CVE-2019-15718" =>	'',
    "CVE-2019-6454" =>	'119',
    "CVE-2019-3844" =>	'268',
    "CVE-2019-3843" =>	'266',
    "CVE-2018-21029" =>	'295',
    "CVE-2018-20839" =>	'200',
    "CVE-2018-16888" =>	'20',
    "CVE-2018-16866" =>	'125',
    "CVE-2018-16865" =>	'770',
    "CVE-2018-16864" =>	'770',
    "CVE-2018-15688" =>	'119',
    "CVE-2018-15687" =>	'362',
    "CVE-2018-15686" =>	'502',
    "CVE-2018-6954" =>	'',
    "CVE-2018-1049" =>	'362',
    "CVE-2017-1000082" =>	'20',
    "CVE-2017-18078" =>	'59',
    "CVE-2017-15908" =>	'835',
    "CVE-2017-9445" =>	'787',
    "CVE-2017-9217" =>	'20',
    "CVE-2015-7510" =>	'119',
    "CVE-2013-4394" =>	'276',
    "CVE-2013-4393" =>	'',
    "CVE-2013-4392" =>	'59',
    "CVE-2013-4391" =>	'190',
    "CVE-2013-4327" =>	'',
    "CVE-2012-1101" =>	'',
  }
end

def cves_to_pub_dates
  {
    "CVE-2021-33910" => 	"2021-7-20",
    "CVE-2020-13776" => 	"2020-6-3",
    "CVE-2020-13529" => 	"2021-5-10",
    "CVE-2020-1712" => 	"2020-3-31",
    "CVE-2019-20386" => 	"2020-1-21",
    "CVE-2019-15718" => "2019-9-4",
    "CVE-2019-6454" => 	 "2019-3-21",
    "CVE-2019-3844" => 	"2019-4-26",
    "CVE-2019-3843" => 	"2019-4-26",
    "CVE-2018-21029" => 	"2019-10-30",
    "CVE-2018-20839" => "2019-5-17",
    "CVE-2018-16888" => 	"2019-1-14",
    "CVE-2018-16866" => 	"2019-1-11",
    "CVE-2018-16865" => "2019-1-11",
    "CVE-2018-16864" => 	"2019-1-11",
    "CVE-2018-15688" => 		"2018-10-26",
    "CVE-2018-15687" => 	"2018-10-26",
    "CVE-2018-15686" => 	"2018-10-26",
    "CVE-2018-6954" => "2018-2-13",
    "CVE-2018-1049" => 			"2018-2-16",
    "CVE-2017-1000082" => 	"2017-7-7",
    "CVE-2017-18078" => 			"2018-1-29",
    "CVE-2017-15908" => 	"2017-10-26",
    "CVE-2017-9445" => 	"2017-6-28",
    "CVE-2017-9217" => 	"2017-5-24",
    "CVE-2015-7510" => 			"2017-9-25",
    "CVE-2013-4394" => 			"2013-10-28",
    "CVE-2013-4393" => 			"2013-10-28",
    "CVE-2013-4392" => 	"2013-10-28",
    "CVE-2013-4391" => 	 "2013-10-28",
    "CVE-2013-4327" => 			"2013-10-3",
    "CVE-2012-1101" => 			"2020-3-11",
  }
end

initial_cves_to_cwes.each do |cve, cwe|
  skel = YAML.load(File.open('skeletons/cve.yml', 'r').read)
  h = YAML.load(File.open("cves/#{cve}.yml", 'r').read)

  # Add in CWE
  skel['CVE'] = cve
  skel['CWE'] = Array(cwe) unless cwe.empty?
  skel['published_date'] = cves_to_pub_dates[cve]
  skel['fixes'] = h['fixes']

  out_h = skel

  # Generate the new YML, clean it up, write it out.
  File.open("cves/#{cve}.yml", "w+") do |file|
    yml_txt = out_h.to_yaml(BestWidth: 80, UseFold: true)[4..-1] # strip off ---\n
    stripped_yml = ""
    yml_txt.each_line do |line|
      stripped_yml += "#{line.rstrip}\n" # strip trailing whitespace
    end
    file.write(stripped_yml)
    print '.'
  end
end
puts 'Done!'
