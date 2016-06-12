use strict;
use Test::More;
use Math::Trig;
use Image::SVG::Transform;
use lib 'lib', '../lib';

my $transform = Image::SVG::Transform->new();
$transform->extract_transforms('scale(2)');
use_ok 'SVG::Estimate::Polygon';

my $points =  [ ##Cross shape with unit steps
        [2, 0],
        [2, 1],
        [1, 1],
        [1, 2],
        [2, 2],
        [2, 3],
        [3, 3],
        [3, 2],
        [4, 2],
        [4, 1],
        [3, 1],
        [3, 0],
];

my $points_string = '2,0 2,1 1,1 1,2 2,2 2,3 3,3 3,2 4,2 4,1 3,1 3,0';

my $polygon = SVG::Estimate::Polygon->new(
    start_point => [0,0],
    transform   => $transform,
    points  => $points_string,
);

is_deeply $polygon->draw_start, [4,0], 'polygon start point, dead north';
is_deeply $polygon->draw_end,   [4,0], 'end point, same as the start';
cmp_ok $polygon->shape_length,  '==', 24, 'polygon length';

is $polygon->min_x, 2, 'min_x';
is $polygon->max_x, 8, 'max_x';
is $polygon->min_y, 0, 'min_y';
is $polygon->max_y, 6, 'max_y';

done_testing();
