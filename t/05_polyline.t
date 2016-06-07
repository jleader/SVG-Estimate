use strict;
use Test::More;
use Math::Trig;
use lib 'lib', '../lib';

use_ok 'SVG::Estimate::Polyline';

my $polyline = SVG::Estimate::Polyline->new(
    start_x => 0,
    start_y => 0,
    points  => [  ##unit staircase
        [5, 3],
        [5, 4],
        [6, 4],
        [6, 5],
        [6, 6],
        [7, 6],
        [7, 7],
    ],
);

is_deeply [$polyline->draw_start], [5,3], 'polyline start point, first point in line definition';
is_deeply [$polyline->draw_end],   [7,7], 'polyline end point, last line';
cmp_ok $polyline->shape_length,  '==',  6.000, 'polyline length';

done_testing();
