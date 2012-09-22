use lib "../lib/";
use Test::More (tests => 3);
use Test::Exception;

use_ok('OddsConverter');

dies_ok { OddsConverter->new(probability => 1e1) } 'Exponential form greater than 1';
subtest 'no chance 2' => sub {
    my $oc = new_ok('OddsConverter' => [probability => 0.0e100]);
    is($oc->decimal_odds, 'Inf.', 'No chance decimal odds are infinite');
    is($oc->roi,          'Inf.', 'No chance ROI is infinite');
};
