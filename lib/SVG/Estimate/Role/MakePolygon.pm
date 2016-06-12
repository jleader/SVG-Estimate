package SVG::Estimate::Role::MakePolygon;

use strict;
use Moo::Role;
use Image::SVG::Transform;

=head2 make_polygon ( $args )

Class method.

Make an SVG::Estimate::Polygon out of a set of point approximating the consumer's shape.

Requires that the consumer provide a C<this_point> method.

=cut

sub make_polygon {
    my ($class, $args) = @_;
    my @points;
    for (my $t = 0.0; $t <= 1.0; $t += 1/12) {
        my $point = $class->this_point($args, $t);
        $point = $args->{transform}->transform($point);
        push @points, $point;
    }
    my $polygon_points = join ' ', map { join ',', @{ $_ } } @points;
    ##Have to send in an empty transform object
    my $littleT = Image::SVG::Transform->new();
    warn $polygon_points;
    return SVG::Estimate::Polygon->new(points => $polygon_points, transform => $littleT, start_point => $args->{start_point}, );
}


1;

