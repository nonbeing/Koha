#!/usr/bin/env perl

use CGI;
use CGI::Carp qw(fatalsToBrowser);

use C4::Auth;
use C4::Output;

use File::Copy qw( copy );
use File::Spec::Functions qw( catfile );


my $input = new CGI;

my $title    = $input->param('title');
my $author   = $input->param('author');
my $barcode  = $input->param('barcode');



$output_file = './print.bat';
open(OUTPUT_FILE, "> $output_file") or die "Couldn't open $output_file for writing!";

print OUTPUT_FILE "perl C:\\printArgox.pl --title \"$title\" --author \"$author\" --barcode $barcode"; 

close(OUTPUT_FILE);



sub start_download {
    my ($cgi, $dir, $file) = @_;

    my $path = catfile($dir, $file);

    open my $fh, '<:raw', $path
        or die "Cannot open '$path': $!";

    print $cgi->header(
        -type => 'application/bat',
        -attachment => $file,
    );

    binmode STDOUT, ':raw';

    copy $fh => \*STDOUT, 8_192;

    close $fh
        or die "Cannot close '$path': $!";

    return;
}

my $cgi = CGI->new;
my $dir = '.';
my $file = 'print.bat';
start_download($cgi, $dir, $file);


#my ( $template, $loggedinuser, $cookie ) = get_template_and_user(
#    {   
#        template_name   => "catalogue/print_barcode.tt",
#        query           => $input,
#        type            => "intranet",
#        authnotrequired => 0,
#        flagsrequired   => { editcatalogue => '*' },
#    }   
#);
#
#$template->param(
#    title        => $title,
#    author        => $author,
#    barcode            => $barcode,
#);
#
#output_html_with_http_headers $input, $cookie, $template->output;

