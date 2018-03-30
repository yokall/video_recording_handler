package VHandler::File;

use strict;
use warnings;

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

    mkdir($root . '/' . $year);
    mkdir($root . '/' . $year . '/' . VHandler::Date::get_month_name_by_number($month));

    return $root . '/' . $year . '/' . VHandler::Date::get_month_name_by_number($month);
}

1;
