#! /usr/bin/perl

use strict;
use warnings;

use feature 'say';
use File::Copy 'move';

use FindBin qw($Bin);
use lib "$Bin/lib";

use VHandler::Date;
use VHandler::File;

my $home = $ENV{HOME};

my $root = "$home/Documents/video_files";
my $video_file = "$root/Untitled 01.mp4";

if (VHandler::File::exists($video_file)) {
	say('Found video file Untitled 01.mp4');

	my ($day, $month, $year) = VHandler::Date::get_current_date();
	my $destination_dir = VHandler::File::create_date_dir_hierarchy($root, $year, $month);
	say("Dir created at $destination_dir");

	my ($hour, $min) = VHandler::Date::get_current_time();
	my $destination_file = VHandler::File::get_date_filename($year, $month, $day, $hour.$min);

	my $destination = $destination_dir.'/'.$destination_file;
	move($video_file, $destination);
	say("Video file moved to $destination");
}
else {
	say('Could not find video file Untitled 01.mp4');
}
