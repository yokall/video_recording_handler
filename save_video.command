#! /usr/bin/perl

use strict;
use warnings;

use feature 'say';
use File::Copy 'move';
use File::Copy::Recursive 'dircopy';
use File::Path 'rmtree';

use FindBin qw($Bin);
use lib "$Bin/lib";

use VHandler::Date;
use VHandler::File;

my $home = $ENV{HOME};
my $root = "$home/Documents/video_files";

save_video_file();
archive_old_video_files();

sub save_video_file {
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
}

sub archive_old_video_files {
	my ($day, $month, $year) = VHandler::Date::get_current_date();

	my $old_month_name = VHandler::Date::get_month_name_2_months_ago($month);
	if ($old_month_name eq 'November' || $old_month_name eq 'December') {
		$year--;
	}
	my $source_dir = "$root/$year/$old_month_name";

	if (VHandler::File::exists($source_dir)) {
		say("Old video dir found at $source_dir");

		my $archive_root = '/Volumes/SeagateExpansion/video_files';
		my $destination_dir = VHandler::File::create_date_dir_hierarchy($archive_root, $year, ($month - 2));
		say("Archive dir created at $destination_dir");

		# we copy rather than move so that any files already copied across aren't lost
		$File::Copy::Recursive::CPRFComp = 1;
		dircopy($source_dir.'/*', $destination_dir) or die $!;
		rmtree($source_dir);
		say("Old video dir archived at $destination_dir");
	}
	else {
		say('No video files to be archived');
	}
}
