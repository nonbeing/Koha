<script>$(document).ready(function(){
    $("input[name=q]:eq(0)").focus();
});</script>

<div class="gradient">
<h1 id="logo"><a href="/cgi-bin/koha/mainpage.pl">[% LibraryName %]</a></h1><!-- Begin Cataloging Resident Search Box --> 
<div id="header_search">
<div id="addbooks_search" class="residentsearch">
    <p class="tip">Search the catalog and the reservoir:</p>
    <form name="search" action="addbooks.pl">
        <input type="text" name="q" size="40" />
        <input type="submit" class="submit" value="Submit" />
    </form>
</div>
    [% INCLUDE 'patron-search-box.inc' %]
[% IF ( CAN_user_catalogue ) %]
<div id="google_books_search" class="residentsearch">
    <p class="tip">Enter Author/Title/ISBN:</p>
    <form action="/cgi-bin/koha/cataloguing/google_books_search.pl" id="google-books-search-block">
        <input type="text" name="q" id="google-books-search-form" size="40" accesskey="q" class="formtext" />
        <input type="submit" class="submit" value="Submit"/>
    </form>
</div>
[% END %]
            <ul>
            <li><a href="#addbooks_search">Cataloging search</a></li>
            [% IF ( CAN_user_circulate ) %]<li><a href="#circ_search">Check out</a></li>[% END %]
            [% IF ( CAN_user_catalogue ) %]<li><a href="#google_books_search">Google Books search</a></li>[% END %]
            </ul>   
</div><!-- /header_search --> 
</div><!-- /gradient --> 
<!-- End Cataloging Resident Search Box --> 
