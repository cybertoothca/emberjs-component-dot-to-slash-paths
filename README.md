# emberjs-component-dot-to-slash-paths
A simple Ruby script that converts EmberJS dot-notation component names to slash-notation.

This is hack script that is not supported or guaranteed.  It was written in an hour
and has managed to save me hours of time converting my EmberJS applications.  
It may work for you, it may not.  Fork it.  Read the script.  Read the regex.
Enjoy.

## Get Me Started

I wrote this quick script to plow through my large EmberJS applications that were
using dot-notation for component and helpers that are nested inside directories.
This is necessary for your application to work properly with the new Glimmer2
engine beginning in Ember-2.10.  _Feel free to fork this repo; I am by no means a
regex-expert, this can probably be done with greater efficiently._

**This script works for me because I made a conscious decision to place my nested
components inside a folder that has at least one dash.  Add to that, none of the
properties on my models, controllers, or routes have dashes in them; another
reason this little conversion script works for me.**

### Requirements

You need Ruby.  I install [Ruby](https://www.ruby-lang.org/en/downloads/) 
using [RVM](https://rvm.io/), but you can get it through any number of 
channels.  Figure it out.

### How To Use

1. Clone this repository to a directory on your machine:

        $ git clone git@github.com:cybertoothca/emberjs-component-dot-to-slash-paths.git

1. Copy the `component-dot-to-slashes.rb` file found in the cloned repo
to the root of your EmberJS application.
1. From a terminal, navigate to the root of your EmberJS application.
1. Consider creating a clean branch of your EmberJS application so that you
can easily do a diff on your files after this script has been run.
1. Execute the Ruby script:

        $ ruby component-dot-to-slashes

1. Review the files changed in your EmberJS application.  Run your ember unit
tests to make sure everything is still working.  Run your application and do
some spot checks on the routes that had components/helpers replaced.
1. Commit the changes if satisfied.
1. Delete the `component-dot-to-slashes.rb` file from the root of your EmberJS
application.

### Note

1. As best I can tell, you can run this script against your EmberJS application
repeatedly if need be.
1. The regex I used is only smart enough to replace components and helpers
that have a dash in their first folder name. 

## Additional Information

### Who Is This Script For?

EmberJS application developers that need to convert _component_ and _helper_
invocations that are using dot-notation instead of the now standard 
slash-notation.

### What Does This Script Do?

This Ruby script will look inside an EmberJS application's `app` 
and `tests` folders for _.js_ and _.hbs_ files.  Each file found 
will be scanned with a [regular expression](https://regex101.com/r/KaPP9l/8) 
that seeks out _component_ or _helper_ invocations using dot-notation 
paths.  Each component or helper suffering from a dot-notation 
path is converted to the slash-notation and re-saved.  For example:

    {{some-component.in-a-folder}} => {{some-component/in-a-folder}}
    {{or-another.likeThis}} => {{or-another/likeThis}}
    {{#nested-folder.with-block}}Some Block{{/nested-folder.with-block}} => {{#nested-folder/with-block}}Some Block{{/nested-folder/with-block}}

### Where Do You Use This Script?

You copy this script to the root of your EmberJS application, where your
`package.json` is located, and then you simply run the script from your
terminal.

### When Do You Use This Script?

You may want to use this script if you have a large number of component 
and helper modules that are nested inside of folders and whose usages 
are invoked with a dot-notation path.


### Why Does This Script Exist?

Upgrading to EmberJS-2.10's Glimmer2 engine necessitates that your components
(and helpers) do not use dot-notation paths for modules that are nested inside
of directories.

If you have been using a JetBrains IDE and the [exceptional 
EmberJS plugin](https://plugins.jetbrains.com/idea/plugin/8049-ember-js) from 
[Tobias Bieniek](https://github.com/turbo87/) then you may have noticed that
your components and helpers are auto-completed using the dot-notation.  There
is an []open issue to correct this behaviour](https://github.com/Turbo87/intellij-emberjs/issues/113) 
so the plugin works according to the new Glimmer2 guidelines.
