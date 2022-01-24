use JSON;
use strict;
use Data::Dumper;
use feature 'say';

my $tree = decode_json(join('',<>));

sub collapse_tree {
    my ($tree, $label) = @_;
    my ($root, $subtree) = @$tree;
    $root = "[$label] $root" if $label;
    return [$root] unless $subtree;
    my @out = ($root);
    for my $k (sort(keys(%$subtree))) {
        push @out, collapse_tree($subtree->{$k}, $k);
    }
    return \@out;
}

sub printree {
  my $tree = shift;
  my $prefix = shift // '';
  my $prefix1 = shift // $prefix;
  my $root = shift @$tree;
  say "$prefix1$root";
  for my $i (0..$#$tree) {
    my $subtree = $tree->[$i];
    if ($i == $#$tree) {
      printree($subtree, "$prefix   ", "$prefix └─");
    } else {
      printree($subtree, "$prefix │ ", "$prefix ├─");
    }
  }
}

printree(collapse_tree($tree));