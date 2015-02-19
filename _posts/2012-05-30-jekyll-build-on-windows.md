---
layout: post
title: "Jekyll Build on Windows"
description: ""
category: lessons
tags: [jekyll, tutorial]
---
{% include JB/setup %}

The following notes were made while building this blog; source code is available
[here](https://github.com/jfisher-usgs/jfisher-usgs.github.com).

## GitHub

If you don't already have one, sign up for a [GitHub](https://github.com) account
[here](https://github.com/signup/free).
Go to your Github Dashboard and create a new repository
named *jfisher-usgs.github.com* (here and elsewhere replace *jfisher-usgs* with
your GitHub *username*). Don't run any of their suggested setup commands.

## Jekyll-Bootstrap

Open a Git Bash window, a command prompt with access to [Git](http://git-scm.com/),
and install Jekyll-Bootstrap:

    $ git clone https://github.com/plusjade/jekyll-bootstrap.git jfisher-usgs.github.com
    $ cd jfisher-usgs.github.com
    $ git remote set-url origin git@github.com:jfisher-usgs/jfisher-usgs.github.com.git
    $ git push origin master

After GitHub has a couple minutes to refresh your blog, it is publicly
available at <http://jfisher-usgs.github.com>.

## Ruby

Install [Ruby](http://www.ruby-lang.org/en/),
available [here](http://rubyinstaller.org/downloads), on your local machine;
the file I downloaded was *rubyinstaller-1.9.3-p194.exe*.

## Twitter-2.0

Install Twitter-2.0 theme packaged for Jekyll-Bootstrap to get a
[responsive design](http://twitter.github.com/bootstrap/scaffolding.html#responsive).

    $ rake theme:install git="https://github.com/gdagley/theme-twitter-2.0"

After the install is successful, the task will ask you if you'd like to switch
to the newly installed theme. Type *y* and enter to switch.

## Pygments

For code highlighting using [pygments](http://pygments.org/), the
following steps are necessary:
Install [Python](http://python.org/), available [here](http://python.org/download/);
the file I downloaded was *python-2.7.3.msi*. Add *C:/Python27* to your
PATH, a system environment variable.

In order to install Pygments through the easy_install command, open a Git Bash window and
install [Distribute](http://pypi.python.org/pypi/distribute#installation-instructions):

    $ curl -O http://python-distribute.org/distribute_setup.py
    $ python distribute_setup.py

Add *C:/Python27/Scripts* to your PATH and install Pygments from the Windows
Command Prompt:

    $ easy_install Pygments

Download *pygments_style.css* from [here](http://pygments.org/demo/35195/?style=tango)
and replace all occurrences of *.syntax* with *.highlight*. Save file as
*/assets/themes/twitter-2.0/css/syntax.css*.
Add the following line to the *default.html* file:

    <link href="/assets/themes/twitter-2.0/css/syntax.css" rel="stylesheet" type="text/css">

A [patch](https://gist.github.com/1185645) is needed if you get the following
error running Pygmentize:

    Liquid error: Bad file descriptor

Open a Git Bash window and install the patch:

    $ cd C:/Ruby193/lib/ruby/gems/1.9.1/gems/albino-1.3.3/lib
    $ wget https://raw.github.com/gist/1185645/0001-albino-windows-refactor.patch
    $ patch -p1 < 0001-albino-windows-refactor.patch

## Ruby Development Kit

Install the Ruby Development Kit on your local machine if you want to
be able to preview your content before publishing.
The development kit is available [here](http://rubyinstaller.org/downloads);
the file I downloaded was *DevKit-tdm-32-4.5.2-20111229-1559-sfx.exe*.
Extract files into *C:/RubyDevKit*.

Open a Git Bash window and install the Jekyll ruby gem:

    $ cd C:/RubyDevKit
    $ ruby dk.rb init
    $ ruby dk.rb install
    $ gem install jekyll

Open a Git Bash window and start a Jekyll Server:

    $ cd D:/Software/jfisher-usgs.github.com
    $ jekyll --server

This will start a local server that will serve up your blog while you are
working locally. See it in your browser at <http://localhost:4000>.
As long as you leave this Git Bash window open you'll have
the server running at that port to test your code locally.

## Providers

I chose [Disqus](http://disqus.com) as a comments provider;
register your site [here](http://disqus.com/admin/register) and
make note of the *short_name*.
[Google](http://www.google.com/analytics/) was chosen for an
analytics provider; make note of your *tracking_id*.

## Configure

Open a text editor and configure the *\_config.yml* file. The following changes
were made:

    title : jfisher-usgs
    tagline: blog
    author :
      name : Jason C Fisher
      email : XXXXXXX@XXXX.XXX
      github : jfisher-usgs

    # Production URL
    production_url : http://jfisher-usgs.github.com

    # Pagination (added this line)
    paginate: 3

    # Settings for comments helper
    comments :
      provider : disqus
        disqus :
          short_name : XXXXXXXXXXX

    # Settings for analytics helper
    analytics :
      provider : google
      google :
        tracking_id : 'XX-XXXXXXXX-X'

## Page and Post

Create a page template:

    $ rake page name="XXXX.md"

Create a post template:

    $ rake post title="XXXX XXXX"

See [Markdown Syntax Guide](http://daringfireball.net/projects/markdown) for
help with content creation in your favorite text editor.

## References

<http://jekyllbootstrap.com/lessons/jekyll-introduction.html>
<http://zolomon.com/tutorial/2012/02/23/setting-up-jekyll-on-windows-7>
<http://twitter.github.com/bootstrap/index.html>
