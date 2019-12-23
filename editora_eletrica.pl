#!/usr/bin/env perl
use Mojolicious::Lite;
use Mojo::JSON qw(decode_json encode_json);
use Data::Dumper;

# Using the trader.conf file
plugin 'Config';

#show config
my $config = plugin('Config');

sub gettree {
  #my $self = shift;
  my $sha = shift;
  my $t = Pithub::GitData::Trees->new;
  my $tree = $t->get(
    user => $config->{user},
    repo => $config->{repo},
    sha  => $sha,
  );
  my $jt = decode_json $tree->response->content;
  return $jt->{tree};
}

sub parsetree {
  #my $self = shift;
  my $tree = shift;
  my $format = shift || 'html';
  my $parsed;
  my @chapters;

print Dumper $tree;

  my $i = 1;
  foreach my $item (@{$tree}){
   # Each dir has a README.md file with the main content.
   if ($item && $item->{type} eq 'blob' && $item->{path} eq 'README.md'){
     my $b = Pithub::GitData::Blobs->new;
     my $result = $b->get(
        user => $config->{user},
        repo => $config->{repo},
        sha  => $item->{sha},
    );
    my $jb = decode_json $result->response->content; 
    if ($format eq 'html'){
        $chapters[0] = markdown(decode("utf8", decode_base64($jb->{content})));
    }
   } elsif ($item->{type} eq 'tree'){
     $chapters[$i] = parsetree ( gettree $item->{sha}, $format );
     $i++;
   } 
  }
  $parsed = join(' ', @chapters);
  return $parsed;
}

# Routes
#-------------------------------

get '/' => sub {
  my $c = shift;
  $c->render(template => 'index');
};

get '/cursos' => sub {
  my $c = shift;

  my $p = Pithub->new;
  my $repo = $p->repos->get( 
    user => $config->{user},
    repo => $config->{repo},
  );
  my $r = Pithub::GitData::References->new;
  my $ref = $r->get(
    user => $config->{user},
    repo => $config->{repo},
    ref  => 'heads/master'
  ); 
  my $jr = decode_json $ref->response->content;
  my $jt = gettree $jr->{object}->{sha};

  $c->stash('description', $repo->content->{description}); 
  $c->stash('tree', $jt); 
  $c->render(template => 'cursos');
};

get '/ebook/:sha' => sub {
  my $c = shift;
  my $sha = $c->param('sha');
  my $html; 
  my $pdf;
  my $jt = gettree $sha;
  # Read and merge all blobs rendering in html and pdf
  $html = parsetree $jt;

  # Chapters are directories in GitHub
  # Each ebook has structure.json file with optional data
  # Each dir has a README.md file with the main content.
  # Optionaly the dir may contain an index.html file
  $c->stash('content', $html); 
  $c->render(template => 'ebook');
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Welcome to EE';
<h1>Editora El&eacute;trica</h1>
<li><a href="/cursos">Cursos</a></li>

@@ cursos.html.ep
% layout 'default';
% title 'Cursos';
<h1>Cursos Editora Elétrica</h1>
<p><%= $description %>

% for my $p (@$tree) {
%  if ($p->{type} eq 'tree') {
    <li><a href="/ebook/<%= $p->{sha} %>"><%= $p->{path} %></a>
%  } elsif ($p->{type} eq 'blob'){
    <li><a href="/getfile/<%= $p->{sha} %>"><%= $p->{path} %></a>
%  }
% }

@@ ebook.html.ep
% layout 'default';
% title 'ebook';
<div id="content">
<%== $content %>
</div>

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title>
  <link rel="stylesheet" type="text/css" href="/css/style.css">
  </head>
  <body>
  <div id="page">
  <div id="logo-kobkob"><img src="/img/logo.png"></div>
  <div id="logo-ee"><img src="/img/logo_ee.png"></div>
  <%= content %>
  </div>
  </body>
</html>
