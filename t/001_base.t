use Test::More tests => 9;
use strict;
use warnings;

use_ok 'Net::HTTP::Client';

my $res = Net::HTTP::Client->request(POST => 'ashley.laurelmail.net:3335/foo', 'Content-Type' => 'application/json', '{"bar":["tequila","islay scotch"]}');
test_res($res);

my $client = Net::HTTP::Client->new(Host => 'ashley.laurelmail.net:3335', KeepAlive => 0);

$res = $client->request(POST => '/foo', 'fizz buzz');
test_res($res);

$res = $client->request(GET => 'ashley.laurelmail.net:3335/baz');	# a new connection
test_res($res);

$res = $client->request(POST => '/bar', 'foo');				# original connection
test_res($res);

sub test_res {
    my ($res) = @_;
    is $res->status_line, '200 OK', 'status_line';
    is $res->content, '{"status":"OK"}', 'content';
}