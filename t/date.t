#! /usr/bin/perl

use strict;
use warnings;

use FindBin qw($Bin);
use lib "$Bin/../lib";

use Test::MockTime;
use Test::Most;

use VHandler::Date;

subtest 'Get current date', sub {
	plan tests => 6;

	Test::MockTime::set_absolute_time('2017-11-01T00:00:00Z');

	my ($day, $month, $year) = VHandler::Date::get_current_date();

	is $year, '2017', 'Year is 2017';
	is $month, '11', 'Month is 2017';
	is $day, '01', 'Day is 2017';

	Test::MockTime::set_absolute_time('2202-9-11T00:00:00Z');

	($day, $month, $year) = VHandler::Date::get_current_date();

	is $year, '2202', 'Year is 2202';
	is $month, '09', 'Month is 09';
	is $day, '11', 'Day is 11';

	Test::MockTime::restore();
};

subtest 'Get current time', sub {
	plan tests => 4;

	Test::MockTime::set_fixed_time('2018-02-06T13:05:00 GMT', '%Y-%m-%dT%H:%M:%S %Z');

	my ($hour, $min) = VHandler::Date::get_current_time();

	is $hour, '13', 'Hour is 14';
	is $min, '05', 'Minute is 05';

	Test::MockTime::set_fixed_time('2018-04-06T08:45:00 GMT', '%Y-%m-%dT%H:%M:%S %Z');

	($hour, $min) = VHandler::Date::get_current_time();

	is $hour, '09', 'Hour is 09';
	is $min, '45', 'Minute is 45';

	Test::MockTime::restore();
};

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
