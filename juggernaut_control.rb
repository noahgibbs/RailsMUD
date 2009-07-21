require 'rubygems'
require 'daemons'

# When using the 'daemons' rubygem, everything gets run from the root
# path of your filesystem.  So you need an absolute pathname for
# juggernaut.yml.  I'm sure there's some cute way to do this in bash, too,
# but I had an easier time doing it in Ruby and using :exec mode in the
# call to Daemons.run.
#
jugfile = File.join(File.expand_path(File.dirname(__FILE__)), "juggernaut.yml")
cmdline = `which juggernaut`.chomp + " -c " + jugfile

print "Cmd line: #{cmdline}\n"

Daemons.run(cmdline, :dir_mode => :normal, :dir => ".",
            :mode => :exec)
