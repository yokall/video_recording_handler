#! /usr/bin/perl

use strict;
use warnings;

use FindBin qw($Bin);
use lib "$Bin/../lib";

use VHandler::File;

use File::Copy 'move';
use File::Path 'rmtree';
use File::Touch;
use Test::Most;

my $TEST_DIR = "/tmp/test";

subtest 'Check file exists', sub {
	plan tests => 1;

	prepare_test_dir();

	my $source_file = $TEST_DIR.'/Untitled 01.mp4';

	touch($source_file);

	ok VHandler::File::exists($source_file), "File exists";
};

subtest 'Move file', sub {
	plan tests => 1;

	prepare_test_dir();

	my $source_file = $TEST_DIR.'/Untitled 01.mp4';
	my $destination_file = $TEST_DIR.'/Untitled 01.mp4';

	touch($source_file);
	move($source_file, $destination_file);

	ok file_exists($destination_file), "File moved";
};

subtest 'Create date dir hierarchy', sub {
	plan tests => 2;

	prepare_test_dir();

	my $root = $TEST_DIR;
	my $year = '2018';
	my $month = '03';

	VHandler::File::create_date_dir_hierarchy($root, $year, $month);

	ok dir_exists($TEST_DIR.'/2018'), 'Year directory created';
	ok dir_exists($TEST_DIR.'/2018/March'), 'Month directory created';
};

subtest 'Get date filename', sub {
	plan tests => 2;

	my $year = '2018';
	my $month = '03';
	my $day = '03';
	my $time = '1300';

	is VHandler::File::get_date_filename($year, $month, $day, $time), '03-03-18m.mp4', 'Morning datetime';

	$time = '2015';

	is VHandler::File::get_date_filename($year, $month, $day, $time), '03-03-18e.mp4', 'Evening datetime';
};

done_testing();

sub prepare_test_dir {
	rmtree($TEST_DIR);
	mkdir($TEST_DIR);
}

sub file_exists {
	my $file = shift;

	if (-e $file) {
		return 1;
	}

	return 0;
}

sub dir_exists {
	my $dir = shift;

	if (-e $dir && -d $dir) {
		return 1;
	}

	return 0;
}
