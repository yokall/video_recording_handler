package VHandler::File;

use strict;
use warnings;

use feature 'say';

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
	mkdir($root.'/'.$year.'/'.$month);

	return $root.'/'.$year.'/'.$month;
}

sub get_date_filename {
	my $year = shift;
	my $month = shift;
	my $day = shift;
	my $time = shift;
	my $day_name = shift;

	$year =~ s/^20+//;

	my $filename = $day.'-'.$month.'-'.$year;

	if ($time >= 1900) {
		$filename .= 'e';
	}
	else {
		$filename .= 'm';
	}

	unless ($day_name eq 'Sunday') {
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
