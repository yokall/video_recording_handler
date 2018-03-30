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

    move($video_file, $destination_dir);
    say("Video file moved to destination dir");
}
else {
    say('Could not find video file Untitled 01.mp4');
}

say "Press ENTER to exit:";
<STDIN>;
