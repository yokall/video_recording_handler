package VHandler::File;

use strict;
use warnings;

use feature 'say';

use VHandler::Date;

sub exists {
	my $file = shift;

	if (-e $file) {
		return 1;
	}

	return 0;
}

sub create_date_dir_hierarchy {
	my $root = shift;
	my $year = shift;
	my $month = shift;

	mkdir($root.'/'.$year);
	mkdir($root.'/'.$year.'/'.VHandler::Date::get_month_name_by_number($month));

	return $root.'/'.$year.'/'.VHandler::Date::get_month_name_by_number($month);
}

sub get_date_filename {
	my $year = shift;
	my $month = shift;
	my $day = shift;
	my $time = shift;

	$year =~ s/^20+//;

	my $filename = $day.'-'.$month.'-'.$year;

	if ($time >= 1900) {
		$filename .= 'e';
	}
	else {
		$filename .= 'm';
	}

	unless (VHandler::Date::get_current_day_name() eq 'Sunday') {
		say('Meeting name? eg Harvest');
		my $meeting_name = <STDIN>;
		chomp $meeting_name;

		if ($meeting_name) {
			$filename .= '_'.$meeting_name;
		}
	}

	return $filename.'.mp4';
}

1;
