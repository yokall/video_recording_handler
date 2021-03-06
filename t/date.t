#! /usr/bin/perl

use strict;
use warnings;

use FindBin qw($Bin);
use lib "$Bin/../lib";

use Test::MockTime;
use Test::Most;

use VHandler::Date;

subtest 'Get current date', sub {
	plan tests => 8;

	Test::MockTime::set_absolute_time('2017-11-01T00:00:00Z');

	my ($day_name, $day, $month, $year) = VHandler::Date::get_current_date();

	is $year, '2017', 'Year is 2017';
	is $month, '11', 'Month is 2017';
	is $day, '01', 'Day is 2017';
	is $day_name, 'Wednesday', 'Day name is Wednesday';

	Test::MockTime::set_absolute_time('2202-9-11T00:00:00Z');

	($day_name, $day, $month, $year) = VHandler::Date::get_current_date();

	is $year, '2202', 'Year is 2202';
	is $month, '09', 'Month is 09';
	is $day, '11', 'Day is 11';
	is $day_name, 'Saturday', 'Day name is Saturday';

	Test::MockTime::restore();
};

subtest 'Get current time', sub {
	plan tests => 4;

	# Keep dates out of daylight saving time to prevent errors on build server

	Test::MockTime::set_fixed_time('2018-02-06T13:05:00Z');

	my ($hour, $min) = VHandler::Date::get_current_time();

	is $hour, '13', 'Hour is 13';
	is $min, '05', 'Minute is 05';

	Test::MockTime::set_fixed_time('2018-02-06T08:45:00Z');

	($hour, $min) = VHandler::Date::get_current_time();

	is $hour, '08', 'Hour is 08';
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

subtest 'Get month name 2 months ago', sub {
	plan tests => 12;

	is VHandler::Date::get_month_name_2_months_ago('01'), 'November', '01 is November';
	is VHandler::Date::get_month_name_2_months_ago('02'), 'December', '02 is December';
	is VHandler::Date::get_month_name_2_months_ago('03'), 'January', '03 is January';
	is VHandler::Date::get_month_name_2_months_ago('04'), 'February', '04 is February';
	is VHandler::Date::get_month_name_2_months_ago('05'), 'March', '05 is March';
	is VHandler::Date::get_month_name_2_months_ago('06'), 'April', '06 is April';
	is VHandler::Date::get_month_name_2_months_ago('07'), 'May', '07 is May';
	is VHandler::Date::get_month_name_2_months_ago('08'), 'June', '08 is June';
	is VHandler::Date::get_month_name_2_months_ago('09'), 'July', '09 is July';
	is VHandler::Date::get_month_name_2_months_ago('10'), 'August', '10 is August';
	is VHandler::Date::get_month_name_2_months_ago('11'), 'September', '11 is September';
	is VHandler::Date::get_month_name_2_months_ago('12'), 'October', '12 is October';
};

done_testing();
