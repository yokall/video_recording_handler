package VHandler::Date;

use strict;
use warnings;

use Time::localtime;

sub get_current_date {
    my $tm = localtime;

    my $day = $tm->mday;
    my $month = sprintf("%02d", ($tm->mon + 1));
    my $year = $tm->year + 1900;

    return ($day, $month, $year);
}

sub get_current_time {
    my $tm = localtime;

    my $hour = sprintf("%02d", $tm->hour);
    my $min = sprintf("%02d", $tm->min);

    return ($hour, $min);
}

my %month_names = (
    '1' => 'January',
    '2' => 'February',
    '3' => 'March',
    '4' => 'April',
    '5' => 'May',
    '6' => 'June',
    '7' => 'July',
    '8' => 'August',
    '9' => 'September',
    '10' => 'October',
    '11' => 'November',
    '12' => 'December',
);

sub get_month_name_by_number {
    my $month_number = shift;

    $month_number =~ s/^0+//;

    return $month_names{$month_number};
}

1;
