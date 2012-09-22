package OddsConverter;

=head1 NAME

OddsConverter

=head1 SYNOPSIS

    my $oc = OddsConverter->new(probability => 0.5);
    print $oc->decimal_odds;    # '2.00' (always to 2 decimal places)
    print $oc->roi;             # '100%' (always whole numbers or 'Inf.')

=cut

use warnings;

sub new {
	my $class = shift;
	my %hash = @_;
	my $probability = $hash{probability};
	$probability = sprintf("%.10g", $probability) if $probability =~ m/\d{1}\.?\d*e-?\d+/;
#	print $probability."\n";
	die unless (defined $probability && $probability =~ m/\d+\.?\d*/ && $probability <= 1 && $probability >= 0);
	my $self = {probability => $probability};	
	bless $self, $class;
	return $self;
}

sub decimal_odds {
	my $self = shift;
	my $probability = $self->{probability};
	return "Inf." if ($probability == 0 || $probability =~ m/^0\.?0+$/);
	return sprintf("%.2f",(1/$probability));
}

sub roi {
	my $self = shift;
        my $probability = $self->{probability};
        return "Inf." if ($probability) == 0;    
        my $roi = int((((1/$probability) - 1))*100 + 0.5);
	return "$roi\%";
}
1;

