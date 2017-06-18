use utf8;
use strict;
use warnings;

print "DELETE FROM yashulan.station;\n";
for my $i (1..120){
    print "INSERT INTO yashulan.station VALUES( $i,'根津${i}丁目'); \n";
}
