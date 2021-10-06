# systemd Vulnerabilities

Curated vulnerability data for the Freedesktop systemd

# The Build ![YML & Editorial Checkers](https://github.com/VulnerabilityHistoryProject/systemd-vulnerabilities/workflows/YML%20&%20Editorial%20Checkers/badge.svg)

# For SWEN 331 students

Please see your course website for instructions. This README is more for people managing this data.

# Testing project locally

1. You'll need Ruby 2.4+
2. Run `gem install bundler` (if you don't already have bundler)
3. `cd` to the root of this repo, run `bundle install`
4. Run `bundle exec rake`

If the output has no *failures*, then it checks out!

# Cloning the source repo

To clone the repo into this folder, use this command:

```
git clone https://github.com/systemd/systemd.git tmp/src
```

# Populating New CVEs

We do this manually... at the moment.


# Merge Student CVE assignment

Here's how you merge in student data once the assignment is finished.

1. Make sure the current `dev` branch is updated and works with the build
2. Switch `vulnerability-history` locally to pull from `dev` instead of `master`.
3. Squash and merge the student pull req into `dev`
4. Run `rails data:systemd` locally. When it says "Loading data version " and then a git hash, make sure that matches up with the latest merge you just made (so you know you are pulling the latest chromium-vulnerabilities data). Alternatively, you can do `rails data:clear data:systemd:load_only` which goes quicker.
5. If all is well, then do any spot-checks of their data to make sure everything got tagged just fine.
6. If all is not well:
  * You may need to merge their changes with any of your changes. This might be on GitHub itself, or locally.
  * You may need to correct their YML structure to make it compatible with the loader. Make the change locally and push back to `dev` to fix it and re-run.
  * If things fail on an exception, you can always put in this snippet somewhere to figure out what file failed and use byebug to figure out the problem:
  ```
  begin
    # code where things when wrong
  rescue
    byebug
  end
  ```
  * You can always do `rails data:systemd:nogit` to reload things without hitting GitHub - helpful for quicker debugging.

# After Merging in New CVEs

After we merge in a bunch of PRs, here's a checklist of what needs updating, and in what order:

  * Add mentioned commits (default options should be good enough)
  * Generate weeklies (skip existing)
