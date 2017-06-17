use utf8;
use strict;
use warnings;

for my $i (4..100){
    print "INSERT INTO restaurant VALUES($i, 'Yasumiko-Tei${i}', $i, 'french', 1000, 2000, 1, 4.3, 'ayu is good', 'http://www.google.com', 'yasuko', '2015-01-01', '2017-01-01');";
}
