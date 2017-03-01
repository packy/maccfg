#!/app/clarity/perl/bin/perl

use strict;
use warnings;

use GridApp::Archive;
use GA::Util::DagentUtils;
use Data::Dumper;
use Getopt::Long;

my $show_clust = 1;
my $show_db    = 1;
my $show_app   = 1;
my $show_mssql = 1;

GetOptions
    'cluster!' => \$show_clust,
    'db!'      => \$show_db,
    'app!'     => \$show_app,
    'mssql!'   => \$show_mssql,
    'help|?'   => sub {
        print <<USAGE;
$0 [switches]

Switches:
  --nocluster  Omit cluster info
  --nodb       Omit oracle DB info
  --nomssql    Omit SQL Server info
  --noapp      Omit application info
  --help       Display this message

USAGE
        exit;
    };

print "\nNote: If you see unexpected results, be sure to look in this file:\n";
print "\t/app/clarity/dagent/var/log/discovery_trace.log\n\n";

my $cluster_type = GA::Util::DagentUtils::is_cluster_installed();
my %cluster_props; # Undef if no cluster present

sub pretty_print_hash {
    my(%hash) = @_;
    unless (keys %hash) {
        print "{ empty hash }\n";
        return;
    }
    # split the output of Dumper
    my @raw = split /\n/, Dumper \%hash;
    shift @raw;
    pop @raw;
    foreach my $line (@raw) { $line =~ s/^\s+/  / }
    print join "\n", sort @raw;
    print "\n";
}

sub pretty_print_array {
    my (@array) = @_;
    unless (@array) {
        print "( empty array )\n";
        return;
    }
    # split the output of Dumper
    my @raw = split /\n/, Dumper \@array;
    shift @raw;
    pop @raw;
    foreach my $line (@raw) { $line =~ s/^\s+/  / }
    print join "\n", @raw;
    print "\n";
}

if ($^O ne 'MSWin32') {
    if (defined($cluster_type)) {
        # gather the props whether we display them or not
        eval {
            %cluster_props =
                GA::Util::DagentUtils::list_cluster_properties($cluster_type);
            1;
        } or do {
            print $@,"\n";
        };
        ml_or_not(\%cluster_props);
    }

    if ($show_clust) {
        print "Is cluster installed? ";
        print defined($cluster_type) ? $cluster_type : "no";
        print "\n";

        if (defined($cluster_type)) {
            print "==========================================\n";
            print "Cluster Properties:\n";
            pretty_print_hash %cluster_props;
        
            print "==========================================\n";
            print "Cluster Hosts:\n";
            pretty_print_array GA::Util::DagentUtils::list_cluster_hosts(%cluster_props);
        }
    }
}
else {
    print "Skipping cluster discovery".($^O eq 'MSWin32'?" on Win32":"")."\n";
}

if ($show_db) {
    print "\n==========================================\n";
    print "list of oracle databases found\n";

    # don't know why we need to call this down here, but we crash if this
    # is left back where it was right before is_cluster_present()

    GA::Util::DagentUtils::setup_discovery_logger();

    my %db_list = GA::Util::DagentUtils::list_databases(%cluster_props);
    pretty_print_hash %db_list;

    # Now show the props for each database
    foreach my $db (keys %db_list) {
        print "==========================================\n";
        my %props;
        if ($db_list{$db} == 0) {
            print "Properties for standalone database $db:\n";
            %props =
                GA::Util::DagentUtils::list_standalone_database_properties("db_identifier", $db);
        } else {
            print "Properties for clustered database $db:\n";
            %props =
                GA::Util::DagentUtils::list_cluster_database_properties("db_identifier", $db, %cluster_props);
        }
        #print Dumper \%props;
        pretty_print_hash %props;
    }
}
else { 
    print "\n==========================================\n";
    print "Skipping oracle db discovery\n";
}

if ($^O eq 'MSWin32') {
    if ($show_mssql) {
        require GA::SqlServer;
        my @instances = GA::SqlServer::get_instance_list();
        print "\n==========================================\n";
        print "list of MSSQL Instances found\n";
        pretty_print_array @instances;

        foreach my $instance ( @instances ) {
            print "\nlist of MSSQL databases found in $instance\n";
            my @databases = GA::SqlServer::get_instance_databases($instance);
            pretty_print_array @databases;
        }
    }
    else {
        print "\n==========================================\n";
        print "Skipping mssql discovery\n";
    }
}
else {
    print "\n==========================================\n";
    print "Not Win32; skipping mssql discovery\n";
}

if ($show_app && GA::Util::DagentUtils->can("list_applications") ) {
    # Now let's look for applications
    print "\n==========================================\n";
    print "list of applications found\n";
    my %app_list = GA::Util::DagentUtils::list_applications(%cluster_props);
    pretty_print_hash %app_list;

    # Now let's dump the properties of the applications
    foreach my $app (keys %app_list) {
        print "==========================================\n";
        my %app_props;
        my ($class, $id) = split /;/, $app;
        my $state = q{};
        my $type  = q{};
        my $files;
        if ($app_list{$app} == 0) {
            $type = "standalone";
            %app_props =
                GA::Util::DagentUtils::list_standalone_app_properties("app_identifier", $app);
            if (GA::Util::DagentUtils->can("standalone_app_state")) {
                $state = GA::Util::DagentUtils::standalone_app_state("app_identifier", $app);
            }
        } else {
            $type = "clustered";
            %app_props =
                GA::Util::DagentUtils::list_cluster_app_properties("app_identifier", $app, 
                                            %cluster_props);
            if (GA::Util::DagentUtils->can("cluster_app_state")) {
                $state = GA::Util::DagentUtils::cluster_app_state("app_identifier", $app);
            }
        }
        
        print "Properties for $type application $id:\n";
        print "  _CLASS_ => $class\n";
        pretty_print_hash %app_props;

        $state = length($state) ? qq{'$state'} : 'no state tracking';
        print "\nState for $id: $state\n";

        # See if there are any application level properties associated with the
        # app type
        if (exists($app_props{'app_type'})) {
            my $app_type = $app_props{'app_type'};
            my @app_propnames;
            print "\nApplication level properties for type $app_type:\n";
            @app_propnames = GA::Util::DagentUtils::list_applevel_propertynames('app_type', $app_type, "app_identifier", $app);
            pretty_print_array @app_propnames;
            print "\n";
        }
    }
}
else { 
    print "\n==========================================\n";
    print "Skipping app discovery\n";
}

sub ml_or_not {
    my($props) = @_;
    open my $fh, '<', '/app/clarity/dagent/etc/dagent.conf';
    while (<$fh>) {
        s/\#.*$//g; # strip any comments out
        if (/vcstype=ml/) {
            $props->{ClusterStyle} = 'ml';
            return;
        }
    }
}
