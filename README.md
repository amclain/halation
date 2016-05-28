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

## Tags

Tags are user-defined values that serve as a quick and simple way to reference
complex information.

Why is this important? Let's say you shot a roll of ten images with several
different lenses. It would be cumbersome to have to specify a model number
like `Z110mm f/2.8W` (and all the other lens information) on each of the frames.
Even more importantly, if you're processing batches of images over a long period
of time (months, years), you're bound to make mistakes in the spelling of the
model number. This is important because any software that catalogs images based
on Exif data (Lightroom, Flickr) doesn't know how to deal with these
inconsistencies. This means `Z110mm f/2.8W` and `Z110mm f/2.8 W` will be
considered two different lenses by the software (did you see the difference?),
even though we as humans understand they're the same thing. If you try to filter
by lens in Lightroom, some of the images will be under one spelling and some
will be under the other, even though they were both shot with the same
110mm lens.

Tags solve this problem by letting us define all of the complex,
infrequently-changing data in one place. We can then reference that complex
data by its `tag`. For example, if we have a 65mm lens and a 110mm lens we can
define their information once and tag them as `65` and `110` respectively (we
choose the tag names).

```yaml
lenses:
  - tag: 65
    model: "M65mm f/4L-A"
    focal_length: 65
  - tag: 110
    model: "Z110mm f/2.8W"
    focal_length: 110
```

Now when we want to reference which lens was used when capturing a particular
frame, all we have to do is specify the tag and Halation will fill
in the correct Exif data for that lens.

```yaml
frames:
  - number: 1
    lens: 110
  - number: 2
    lens: 65
  - number: 3
    lens: 110
```
