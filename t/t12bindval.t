#!/usr/bin/perl -w
#
#   @(#)$Id: t12bindval.t,v 2003.3 2003/01/04 00:36:38 jleffler Exp $
#
#   Test handling of bind_param for DBD::Informix
#
#   Copyright 2000    Informix Software Inc
#   Copyright 2002-03 IBM

use strict;
use DBD::Informix::TestHarness;

# Test install...
my ($dbh) = connect_to_test_database;

stmt_note "1..9\n";
stmt_ok;
my ($table) = "dbd_ix_bind_param";

# Create table for testing
stmt_test $dbh, qq{
CREATE TEMP TABLE $table
(
	Col01	SERIAL(1000) NOT NULL,
	Col02	CHAR(20) NOT NULL,
	Col03	INTEGER NOT NULL,
	Col04	DATETIME YEAR TO FRACTION(5) NOT NULL,
	Col05   DECIMAL(10,9) NOT NULL
)
};

my ($select) = "SELECT * FROM $table";

# Prepare the select statement...
my $sel = $dbh->prepare($select) or &stmt_fail;
&stmt_ok;

# Insert a row of values.
my ($sth) = $dbh->prepare("INSERT INTO $table VALUES(0, ?, ?, ?, ?)");
&stmt_fail() unless $sth;
&stmt_ok;

# Expected results.
my $row1 = { 'col01' => 1000,
			 'col02' => 'Another value',
			 'col03' => 987654321,
			 'col04' => '1997-02-28 00:11:22.55555',
			 'col05' => 2.718281828
		   };
my $row2 = { 'col01' => 1001,
		     'col02' => 'Another value',
		     'col03' => 987654321,
		     'col04' => '1997-02-28 00:11:22.55555',
		     'col05' => 2.718281828
		   };
my $row3 = { 'col01' => 1002,
		     'col02' => 'Some other data',
		     'col03' => 987654321,
		     'col04' => '1997-02-28 00:11:22.55555',
		     'col05' => 3.141592654
		   };
my $row4 = { 'col01' => 1003,
		     'col02' => 'Some other data',
		     'col03' => 123456789,
		     'col04' => '2000-02-29 23:59:59.99999',
		     'col05' => 3.141592654
		   };
my $res1 = { 1000 => $row1 };
my $res2 = { 1000 => $row1, 1001 => $row2 };
my $res3 = { 1000 => $row1, 1001 => $row2, 1002 => $row3 };
my $res4 = { 1000 => $row1, 1001 => $row2, 1002 => $row3, 1003 => $row4 };

$sth->bind_param(1, 'Another value');
$sth->bind_param(2, 987654321);
$sth->bind_param(3, '1997-02-28 00:11:22.55555');
$sth->bind_param(4, 2.718281828);
&stmt_fail() unless $sth->execute;

# Check that there is one row of data
$sel->execute ? validate_unordered_unique_data($sel, 'col01', $res1) : &stmt_nok;

# Insert almost duplicate row...
&stmt_fail() unless $sth->execute;

# Check that there are now two rows of data, substantially the same
$sel->execute ? validate_unordered_unique_data($sel, 'col01', $res2) : &stmt_nok;

# Try some new bind values
$sth->bind_param(1, 'Some other data');
$sth->bind_param(4, 3.141592654);
&stmt_fail() unless $sth->execute;

# Check that there are now three rows of data
$sel->execute ? validate_unordered_unique_data($sel, 'col01', $res3) : &stmt_nok;

# Try some more new bind values
$sth->bind_param(2, 123456789);
$sth->bind_param(3, '2000-02-29 23:59:59.99999');
&stmt_fail() unless $sth->execute;

# Check that there are now four rows of data 
$sel->execute ? validate_unordered_unique_data($sel, 'col01', $res4) : &stmt_nok;

$dbh->disconnect ? &stmt_ok : &stmt_nok;

&all_ok();
