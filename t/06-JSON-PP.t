use strict;
use warnings;

use Test::More 0.88;
eval "use JSON::Any qw(PP)";
plan skip_all => "JSON::PP not installed: $@" if $@;

diag("Testing JSON::PP backend");
my ( $js, $obj );

ok(my $json_obj = JSON::Any->new());
isa_ok($json_obj, 'JSON::Any');
isa_ok($json_obj->handler, 'JSON::PP');

$js  = q|{}|;
$obj = $json_obj->jsonToObj($js);
$js  = $json_obj->objToJson($obj);
is($js,'{}');

$js  = q|[]|;
$obj = $json_obj->jsonToObj($js);
$js  = $json_obj->objToJson($obj);
is($js,'[]');

$js  = q|{"foo":"bar"}|;
$obj = $json_obj->jsonToObj($js);
is($obj->{foo},'bar');
$js = $json_obj->objToJson($obj);
is($js,'{"foo":"bar"}');

$js  = q|{"foo":""}|;
$obj = $json_obj->jsonToObj($js);
$js = $json_obj->objToJson($obj);
is($js,'{"foo":""}');

$js  = q|{"foo":" "}|;
$obj = $json_obj->jsonToObj($js);
$js = $json_obj->objToJson($obj);
is($js,'{"foo":" "}');


$js  = q|{}|;
$obj = JSON::Any->jsonToObj($js);
$js  = JSON::Any->objToJson($obj);
is($js,'{}');

$js  = q|[]|;
$obj = JSON::Any->jsonToObj($js);
$js  = JSON::Any->objToJson($obj);
is($js,'[]');

$js  = q|{"foo":"bar"}|;
$obj = JSON::Any->jsonToObj($js);
is($obj->{foo},'bar');
$js = JSON::Any->objToJson($obj);
is($js,'{"foo":"bar"}');

$js  = q|{"foo":""}|;
$obj = JSON::Any->jsonToObj($js);
$js = JSON::Any->objToJson($obj);
is($js,'{"foo":""}');

$js  = q|{"foo":" "}|;
$obj = JSON::Any->jsonToObj($js);
$js = JSON::Any->objToJson($obj);
is($js,'{"foo":" "}');

# testing the truth
$obj = { foo => JSON::Any->true };
$js = JSON::Any->objToJson($obj);
is($js,'{"foo":true}');

$obj = { foo => JSON::Any->false };
$js = JSON::Any->objToJson($obj);
is($js,'{"foo":false}');

$obj = { foo => $json_obj->true };
$js = $json_obj->objToJson($obj);
is($js,'{"foo":true}');

$obj = { foo => $json_obj->false };
$js = $json_obj->objToJson($obj);
is($js,'{"foo":false}');

done_testing;
