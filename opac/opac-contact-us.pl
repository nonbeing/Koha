#!/usr/bin/perl
# WARNING: 4-character tab stops here

# Copyright 2000-2002 Katipo Communications
#
# This file is part of Koha.
#
# Koha is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.
#
# Koha is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with Koha; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

use strict;
use warnings;

use CGI;
use C4::Auth;

use C4::Context;
use C4::Auth;
use C4::Output;
use C4::AuthoritiesMarc;
use C4::Koha;    # XXX subfield_is_koha_internal_p

my $query        = new CGI;
my $op           = $query->param('op') || '';
my $authtypecode = $query->param('authtypecode') || '';
my $dbh          = C4::Context->dbh;

my ( $template, $loggedinuser, $cookie );

( $template, $loggedinuser, $cookie ) = get_template_and_user(
        {
            #template_name   => "opac-authorities-home.tmpl",
            template_name   => "opac-contact-us.tmpl",
            query           => $query,
            type            => 'opac',
            authnotrequired => ( C4::Context->preference("OpacPublic") ? 1 : 0 ),
            debug           => 1,
        }
    );



# Print the page
output_html_with_http_headers $query, $cookie, $template->output;


