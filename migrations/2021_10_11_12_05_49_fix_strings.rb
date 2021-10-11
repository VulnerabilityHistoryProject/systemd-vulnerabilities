require 'yaml'

# MIGRATION STATUS: Not done yet.
# raise 'Migration already performed.' # Don't run this migration. Kept for posterity

# These are string replacements that are formatted weird. 
def string_replacements
end

ymls = Dir['cves/*.yml'] 
ymls.each do |yml_file|
  yml_string = File.open(yml_file, 'r').read
  

  wrong = <<-EOS
curated_instructions: "If you are manually editing this file, then you are \\"curating\\"
  it. \\n\\nSet the version number that you were given in the instructions. \\n \\nThis
  will enable additional editorial checks on this file to make sure you \\nfill everything
  out properly. If you are a student, we cannot accept your work\\nas finished unless
  curated is set to true.\\n"
EOS
  right = <<-EOS
curated_instructions: |
  If you are manually editing this file, then you are "curating" it. 
  
  Set the version number that you were given in the instructions. 
   
  This will enable additional editorial checks on this file to make sure you 
  fill everything out properly. If you are a student, we cannot accept your work
  as finished unless curated is set to true.  
EOS
  yml_string = yml_string.gsub(wrong, right)

  wrong = <<-EOS
bugs_instructions: "What bugs and/or pull requests are involved in this vulnerability?
  \\n\\nFor systemd, this is typically their GitHub issues, but could also include \\nbugs
  from other databases. Put a URL instead of a single number.\\n"
EOS
  right = <<-EOS
bugs_instructions: |
  What bugs and/or pull requests are involved in this vulnerability? 

  For systemd, this is typically their GitHub issues, but could also include 
  bugs from other databases. Put a URL instead of a single number.  
EOS
  yml_string = yml_string.gsub(wrong, right)

  wrong = <<-EOS
vcc_instructions: "The vulnerability-contributing commits.\\n\\nThese are found by our
  tools by traversing the Git Blame history, where we \\ndetermine which commit(s)
  introduced the functionality. \\n\\nLook up these VCC commits and verify that they
  are not simple refactorings, \\nand that they are, in fact introducing the vulnerability
  into the system. \\nOften, introducing the file or function is where the VCC is,
  but VCCs can be \\nanything. \\n\\nPlace any notes you would like to make in the notes
  field.\\n"
EOS
  right = <<-EOS
vcc_instructions: |
  The vulnerability-contributing commits.
  
  These are found by our tools by traversing the Git Blame history, where we 
  determine which commit(s) introduced the functionality. 
  
  Look up these VCC commits and verify that they are not simple refactorings, 
  and that they are, in fact introducing the vulnerability into the system. 
  Often, introducing the file or function is where the VCC is, but VCCs can be 
  anything. 

  Place any notes you would like to make in the notes field.
EOS
  yml_string = yml_string.gsub(wrong, right)
  wrong = <<-EOS
  question: "Was there any part of the fix that involved one person vouching for \\nanother's
    work?\\n\\nThis can include:\\n  * signing off on a commit message\\n  * mentioning
    a discussion with a colleague checking the work\\n  * upvoting a solution on a
    pull request\\n\\nAnswer must be true or false.\\nWrite a note about how you came
    to the conclusions you did, regardless of what your answer was.\\n"
EOS
  right = <<-EOS
  question: |
    Was there any part of the fix that involved one person vouching for 
    another's work?

    This can include:
      * signing off on a commit message
      * mentioning a discussion with a colleague checking the work
      * upvoting a solution on a pull request

    Answer must be true or false.
    Write a note about how you came to the conclusions you did, regardless of what your answer was.
EOS
  yml_string = yml_string.gsub(wrong, right)
  wrong = <<-EOS
  question: "Are there any stacktraces in the bug reports? \\n\\nSecondly, if there
    is a stacktrace, is the fix in the same file that the \\nstacktrace points to?
    \\n\\nIf there are no stacktraces, then both of these are false - but be sure to\\nmention
    where you checked in the note.\\n\\nAnswer must be true or false.\\nWrite a note
    about how you came to the conclusions you did, regardless of\\nwhat your answer
    was.\\n"
EOS
  right = <<-EOS
  question: |
    Are there any stacktraces in the bug reports? 

    Secondly, if there is a stacktrace, is the fix in the same file that the 
    stacktrace points to? 

    If there are no stacktraces, then both of these are false - but be sure to
    mention where you checked in the note.

    Answer must be true or false.
    Write a note about how you came to the conclusions you did, regardless of
    what your answer was.
EOS
  yml_string = yml_string.gsub(wrong, right)
  wrong = <<-EOS
  question: "Does the fix for the vulnerability involve adding a forgotten check?\\n\\nA
    \\"forgotten check\\" can mean many things. It often manifests as the fix \\ninserting
    an entire if-statement or a conditional to an existing \\nif-statement. Or a call
    to a method that checks something.\\n\\nExample of checks can include:\\n  * null
    pointer checks\\n  * check the current role, e.g. root\\n  * boundary checks for
    a number\\n  * consult file permissions\\n  * check a return value\\n\\nAnswer must
    be true or false.\\nWrite a note about how you came to the conclusions you did,
    regardless of\\nwhat your answer was.\\n"
EOS
  right = <<-EOS
  question: |
    Does the fix for the vulnerability involve adding a forgotten check?

    A "forgotten check" can mean many things. It often manifests as the fix 
    inserting an entire if-statement or a conditional to an existing 
    if-statement. Or a call to a method that checks something.

    Example of checks can include:
      * null pointer checks
      * check the current role, e.g. root
      * boundary checks for a number
      * consult file permissions
      * check a return value
    
    Answer must be true or false.
    Write a note about how you came to the conclusions you did, regardless of
    what your answer was.
EOS
  yml_string = yml_string.gsub(wrong, right)
  wrong = <<-EOS
  question: "In your opinion, after all of this research, what mistakes were made
    that\\nled to this vulnerability? Coding mistakes? Design mistakes?\\nMaintainability?
    Requirements? Miscommunications?\\n\\nThere can, and usually are, many mistakes
    behind a vulnerability.\\n\\nRemember that mistake can come in many forms:\\n* slip:
    failing to complete a properly planned step due to inattention\\n          e.g.
    wrong key in the ignition\\n* lapse: failing to complete a properly planned step
    due to memory failure\\n          e.g. forgetting to put car in reverse before
    backing up\\n* mistake: error that occurs when the plan is inadequate\\n          e.g.
    getting stuck in traffic because you didn’t consider the \\n               impact
    of the bridge closing\\n\\nLook at the CWE entry for this vulnerability and examine
    the mitigations\\nthey have written there. Are they doing those? Does the fix look
    proper?\\n\\nWrite a thoughtful entry here that people in the software engineering\\nindustry
    would find interesting.\\n"
EOS
  right = <<-EOS
  question: |
    In your opinion, after all of this research, what mistakes were made that
    led to this vulnerability? Coding mistakes? Design mistakes?
    Maintainability? Requirements? Miscommunications?

    There can, and usually are, many mistakes behind a vulnerability.

    Remember that mistake can come in many forms:
    * slip: failing to complete a properly planned step due to inattention
              e.g. wrong key in the ignition
    * lapse: failing to complete a properly planned step due to memory failure
              e.g. forgetting to put car in reverse before backing up
    * mistake: error that occurs when the plan is inadequate
              e.g. getting stuck in traffic because you didn’t consider the 
                  impact of the bridge closing

    Look at the CWE entry for this vulnerability and examine the mitigations
    they have written there. Are they doing those? Does the fix look proper?

    Write a thoughtful entry here that people in the software engineering
    industry would find interesting.
EOS
  yml_string = yml_string.gsub(wrong, right)


  File.open(yml_file, "w+") { |file| file.write(yml_string)}
  print '.'
end
puts 'Done!'
