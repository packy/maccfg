#!/usr/bin/perl


my $test = "a string"
    . "just"
    . " for"
    . "test";

{
    {
        my $test = "a string"
            . "just"
                . " for"
                    . "test";
    }
}

$issue->add_component({
    something => {
    }
});

$something->create('sphere', sub {
                       my ($c, @args) = @_;
                   });

