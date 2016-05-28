# Halation

[![Gem Version](https://badge.fury.io/rb/halation.svg)](https://badge.fury.io/rb/halation)
[![Coverage Status](https://coveralls.io/repos/github/amclain/halation/badge.svg?branch=master)](https://coveralls.io/github/amclain/halation?branch=master)
[![API Documentation](https://img.shields.io/badge/docs-api-blue.svg)](http://www.rubydoc.info/gems/halation)
[![MIT License](https://img.shields.io/badge/license-MIT-yellowgreen.svg)](https://github.com/amclain/halation/blob/master/LICENSE)

Add Exif metadata to film photographs.

## Issues, Bugs, Feature Requests

Any bugs and feature requests should be reported on the GitHub issue tracker:

https://github.com/amclain/halation/issues


**Pull requests are preferred via GitHub.**

Mercurial users can use [Hg-Git](http://hg-git.github.io/) to interact with
GitHub repositories.

## Installation

Halation is available as a Ruby gem.

1. Install [Ruby](https://www.ruby-lang.org) 2.1 or higher.
    * Windows: Use [RubyInstaller](http://rubyinstaller.org/downloads/).
    * Mac: Use [homebrew](https://www.ruby-lang.org/en/documentation/installation/#homebrew).
    * Linux: Use [rbenv](https://github.com/sstephenson/rbenv#basic-github-checkout).
    * [Additional installation instructions](https://www.ruby-lang.org/en/documentation/installation)

2. Install [ExifTool](http://www.sno.phy.queensu.ca/~phil/exiftool/).

3. Open the [command line](http://www.addictivetips.com/windows-tips/windows-7-elevated-command-prompt-in-context-menu/)
    and type:
    
```
    gem install halation
```

## Configuration

Halation stores its global configuration data in `.halation` in the system's
user directory. This is typically `~/.halation` on Mac and *nix-based systems,
or `C:\Users\.halation` on Windows.

>Halation uses the [YAML syntax](http://www.yaml.org/spec/1.2/spec.html#Preview)
for its configuration files.

By default Halation uses a global configuration file, `~/.halation/config.yml`.
This is where your generic settings are stored, like your name, copyright info,
and information about your cameras.

```yaml
---
artist: "Example User"
copyright: "2016 Example User"
cameras:
  - tag: "rz67"
    make: "Mamiya"
    model: "Mamiya RZ67 Pro II"
    lenses:
      - tag: 65
        model: "M65mm f/4L-A"
        focal_length: 65
      - tag: 110
        model: "Z110mm f/2.8W"
        focal_length: 110
      - tag: 180
        model: "Z180mm f/4.5W-N"
        focal_length: 180
      - tag: 250
        model: "M65mm f/4L-A"
        focal_length: 250
```
