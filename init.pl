#!/usr/bin/env perl

use strict;
use warnings;

use File::Basename;


sub init() { 
	my $path = dirname(__FILE__) . "/";

	my $configHash = {};
	my $line;
	my $currentSection = "";
	my %databases = ();

	open CONFIGFILE, $path . "base.cfg";

	while ($line = <CONFIGFILE>) {
	        chomp $line;
	        #comment line in ini file
	        if ($line =~ m/^#/) { 
	                next;
	        }
	        #section header
	        if ($line =~ /\[(.*)\]/) { 
	                $currentSection = $1;
	                next;
	        }
	        #value
        if ($line =~ /(.*?)=(.*)/) { 
	                my $value = $2;
	                my $key = $1;
	                $value =~ s/"//g;
	                #trim whitespace off ends
	                $value =~ s/^\s+//;
	                $value =~ s/\s+$//;
	                $key =~ s/^\s+//;
	                $key =~ s/\s+$//;
	                #no section yet
	                if($currentSection !~ m/.+/) { 
	                        $configHash->{$key} = $value;
                }
	                #section;
	                else { 
	                        $configHash->{$currentSection}->{$key} = $value;
	                }
	        }
	} #read per line
	
	
	close CONFIGFILE;
	#pass $configHash to conf, this will put it into the static array
	configure($configHash);
	
	#destory $configHash, $line, and $currentSection, freeing memory
	undef $configHash;
	undef $line;
	undef $currentSection;
} 

#make $conf in-accessable without using configure
BEGIN { 
        my $conf = {};
        sub configure {
                        my $param = shift;
                        my $clobber = shift;
                        if (ref($param) eq 'HASH') {
                                #check if param is hashref, if so we are setting values
                                #set values if not there, or clobber set, if trying to replace
                                #without clobber set, die
                                while ((my $key, my $val) = each(%{$param})) {
                                        if (ref($val) eq 'HASH') {
                                                while ((my $key2, my $val2) = each(%{$val})) {
                                                        if (exists($conf->{$key}->{$key2}) and not $clobber) {
                                                                die "Trying to clobber '$key->$key2'.";
                                                        } #end clobber check
                                                        #write value to array
                                                        $conf->{$key}->{$key2} = $val2; 
                                                }
                                        }
                                        else {
                                                if (exists($conf->{$key}) and not $clobber) {
                                                        die "Trying to clobber '$key'.";
                                                } #end clobber check
                                                $conf->{$key} = $val;
                                        }
                                }
                        } #end setting vals
                        else {
                                #if param isn't a hashref, then return the request, if returning hash,
                                #copy it to a new one so that conf values can't be changed from outside
                                #the conf function
                                if (ref($conf->{$param}) eq 'HASH') {
                                        return %{$conf->{$param}};
                                } #return hash val
                                else {
                                        return $conf->{$param};
                                } #return normal val
                        } #end getting vals
        } #end configure sub
} #end begin

# read_config($filename)
# This reads in a config file from the specified filename and returns a hash
# of hotness with the results
sub read_config() {

        my $configHash = {};
        my $currentSection = "";
        my $line;
        my $filename = shift;

        open CONFIGFILE, $filename;

        while ($line = <CONFIGFILE>) {
                chomp $line;
                #comment line in ini file
                if ($line =~ m/^;/) {
                        next;
                }
                #section header
                if ($line =~ /\[(.*)\]/) {
                        $currentSection = $1;
                        next;
                }
                #value
                if ($line =~ /(.*?)=(.*)/) {
                        my $value = $2;
                        my $key = $1;
                        $value =~ s/"//g;
                        #trim whitespace off ends
                        $value =~ s/^\s+//;
                        $value =~ s/\s+$//;
                        $key =~ s/^\s+//;
                        $key =~ s/\s+$//;
                        #no section yet
                        if($currentSection !~ m/.+/) {
                                $configHash->{$key} = $value;
                        }
                        #section;
                        else {
                                $configHash->{$currentSection}->{$key} = $value;
                        }
                }
        } #read per line

        close CONFIGFILE;

        return $configHash;

} # End read_config sub

1; 
