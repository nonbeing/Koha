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
use C4::Koha;

use Email::Send;
use Email::Send::Gmail;
use Email::Simple::Creator;


sub sendGmail {
    my ($name, $email_address, $phone, $subject, $message) = @_;

    my $body = "Dear Librarian,\nThis Message was received from the OPAC Contact Us page:\n\n\n" .
      "ENQUIRER'S NAME: \n$name\n\n\nENQUIRER'S EMAIL: \n$email_address\n\n\nENQUIRER'S PHONE: \n$phone" .
      "\n\n\nENQUIRER'S MESSAGE: \n$message\n\n\n";

    my $email = Email::Simple->create(
      header => [
          From    => 'LibraryContactUs@gmail.com',
          #To      => 'ambarseksena@gmail.com',
          To      => 'library@vvmvp.org',
          Subject => $subject,
      ],
      body => $body,
    );

    my $sender = Email::Send->new(
      {   mailer      => 'Gmail',
          mailer_args => [
              username => 'LibraryContactUs@gmail.com',
              password => 'JGDkohaAOL13may',
          ]
      }
    );

    eval { $sender->send($email) };
    die "Error sending email: $@" if $@;
}

my $query        = new CGI;
my $op           = $query->param('op') || '';

my ( $template, $loggedinuser, $cookie );
my ( $name, $email_address, $phone, $subject, $message);


if ( $op eq "do_submit" ) {
    ( $template, $loggedinuser, $cookie ) = get_template_and_user(
        {
            template_name   => "opac-contact-us-submitted.tmpl",
            query           => $query,
            type            => 'opac',
            authnotrequired => 1,
            debug           => 1,
        }
    );

    $name = $query->param('Name');
    $email_address = $query->param('Email');
    $phone = $query->param('Phone');
    $subject = $query->param('Subject');
    $message = $query->param('Message');

    if ( defined($email_address)) {
        sendGmail($name, $email_address, $phone, $subject, $message);
    }
}
else {
    ( $template, $loggedinuser, $cookie ) = get_template_and_user(
            {
                template_name   => "opac-contact-us.tmpl",
                query           => $query,
                type            => 'opac',
                authnotrequired => ( C4::Context->preference("OpacPublic") ? 1 : 0 ),
                debug           => 1,
            }
        );
}
# Print the page
output_html_with_http_headers $query, $cookie, $template->output;




