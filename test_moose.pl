{ 
    package Test;
    use Moose;
    use MooseX::Attribute::TypeConstraint::CustomizeFatal;
    use namespace::autoclean;

    has 'a' => (
        is => 'rw',
        isa => 'Int',
        default => sub { 12 },
        traits => ['MooseX::Attribute::TypeConstraint::CustomizeFatal' ],
        on_typeconstraint_failure => 'default',
        );
    1;
}

package main;
use strict;
use warnings;
use Test;
use Try::Tiny;

my $test = Test->new();
try {
    $test->a( 13.3 );
} catch {
    print "Caught the error : $_\n";
    # this is giving me 12 when I'm throwing an exception
    # I don't know why, because code under eval should
    # fail & I should get 13.3, not 12
    print "a : ".$test->a."\n";
};

# This is giving me 13.3, when I'm throwing a warning
# which makes sense
print "a : ".$test->a."\n";
