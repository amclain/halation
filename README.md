# Halation

[![Gem Version](https://badge.fury.io/rb/halation.svg)](https://badge.fury.io/rb/halation)
[![Coverage Status](https://coveralls.io/repos/github/amclain/halation/badge.svg?branch=master)](https://coveralls.io/github/amclain/halation?branch=master)
[![API Documentation](https://img.shields.io/badge/docs-api-blue.svg)](http://www.rubydoc.info/gems/halation)
[![MIT License](https://img.shields.io/badge/license-MIT-yellowgreen.svg)](https://github.com/amclain/halation/blob/master/LICENSE)

Add Exif metadata to film photographs.

## Installation

Halation is available as a Ruby gem.

1. Install [Ruby](https://www.ruby-lang.org) 2.1 or higher.
    * Windows: Use [RubyInstaller](http://rubyinstaller.org/downloads/).
    * Mac: Use [homebrew](https://www.ruby-lang.org/en/documentation/installation/#homebrew).
    * Linux: Use [asdf](https://github.com/asdf-vm/asdf) or [rbenv](https://github.com/sstephenson/rbenv#basic-github-checkout).
    * [Additional installation instructions](https://www.ruby-lang.org/en/documentation/installation)

2. Install [ExifTool](http://www.sno.phy.queensu.ca/~phil/exiftool/).

3. Open the [command line](http://www.addictivetips.com/windows-tips/windows-7-elevated-command-prompt-in-context-menu/)
    and type:
    
```text
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
# Example config.yml
---
artist: "Example User"
copyright: "{{ year_captured }} Example User"
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
        model: "Z250mm f/4.5W"
        focal_length: 250
```

### Templating

Templated values are supported within the YAML files using the moustache
`{{` `}}` syntax.

- `year_captured` - Available within the `copyright` field to substitute the year
the image was captured.

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
frame, all we have to do is specify the tag and Halation will fill in the
correct Exif data for that lens when the image file is processed.

```yaml
frames:
  - number: 1
    lens: 110
  - number: 2
    lens: 65
  - number: 3
    lens: 110
```

## Processing A Roll

Halation requires all of the image files for a roll of film to be in the same
directory. The images should be named in ascending alphabetical order, with the
first frame of the roll at the start of the list and the last frame at the end.
This is typically the default when scanners save files. Halation will scan for
tiff files (`.tif`, `.tiff`), which is the ideal format, as well as jpeg files
(`.jpg`, `.jpeg`).

This directory should also contain a `roll.yml` file, which specifies the data
for each frame (image file) on the roll of film. A new `roll.yml` file can be
generated in the current directory with the following command:

```text
    halation --new-roll
```

The data for the roll can then be entered into the file:

```yaml
# Example roll.yml
---
date: "2016-01-01"
camera: "rz67"
lens: 110
iso: 100
frames:
  - number: 1
    shutter: "1/125"
    aperture: 8
  - number: 2
    shutter: "2"
    lens: 65
    aperture: 16
  - number: 3
    lens: 65
    shutter: "0.5"
    aperture: 16
  - number: 4
    lens: 65
    shutter: "0.5"
    aperture: 16
  - number: 5
    shutter: "1/250"
    aperture: 4
  - number: 6
    shutter: "1/125"
    aperture: 8
  - number: 7
    shutter: "1/125"
    aperture: 8
  - number: 8
    shutter: "1/60"
    aperture: 22
  - number: 9
    date: "2016-01-02"
    shutter: "1/400"
    aperture: 8
    flash: yes
  - number: 10
    date: "2016-01-02"
    shutter: "1/400"
    aperture: 8
    flash: yes
```

Default values can be set at the beginning of the file so that these settings
don't have to be specified for each frame. For example, the roll of film has
one ISO speed for all of the frames, so this can be specified at the top instead
of for each individual frame.

Values like the date are a little different, because maybe the whole roll was
shot during the same day, or maybe it was shot over the course of several days.
This is where the `roll.yml` file provides flexibility. Specifying `date` at the
beginning of the file will make it the default date for all of the frames on the
roll. If not all of the frames were shot on the same day, `date` can then be
specified for each of the frames that have a different date (`9` and `10` in
the example above). This concept works for most of the values.

>A complete list of keywords are available in the [Halation API documentation](http://www.rubydoc.info/gems/halation),
as well as in the [sample files](https://github.com/amclain/halation/tree/master/spec/samples).

After all of the necessary values are entered into `roll.yml`, the images can
be processed by running the following command:

```text
    halation
```
