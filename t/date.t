#! /usr/bin/perl

use strict;
use warnings;

use FindBin qw($Bin);
use lib "$Bin/../lib";

use Test::Most;

use VHandler::Date;

subtest 'Get month name from number', sub {
    plan tests => 12;

    is VHandler::Date::get_month_name_by_number('01'), 'January', '01 is January';
    is VHandler::Date::get_month_name_by_number('02'), 'February', '02 is February';
    is VHandler::Date::get_month_name_by_number('03'), 'March', '03 is March';
    is VHandler::Date::get_month_name_by_number('04'), 'April', '04 is April';
    is VHandler::Date::get_month_name_by_number('05'), 'May', '05 is May';
    is VHandler::Date::get_month_name_by_number('06'), 'June', '06 is June';
    is VHandler::Date::get_month_name_by_number('07'), 'July', '07 is July';
    is VHandler::Date::get_month_name_by_number('08'), 'August', '08 is August';
    is VHandler::Date::get_month_name_by_number('09'), 'September', '09 is September';
    is VHandler::Date::get_month_name_by_number('10'), 'October', '10 is October';
    is VHandler::Date::get_month_name_by_number('11'), 'November', '11 is November';
    is VHandler::Date::get_month_name_by_number('12'), 'December', '12 is December';
};

done_testing();
