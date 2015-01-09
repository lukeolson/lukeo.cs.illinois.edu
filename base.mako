<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="./images/favicon.ico">

    <title>
      <%block name="title">
      SciComp Template
      </%block>
    </title>

    <!-- Bootstrap core CSS -->
    <link href="bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="bootstrap-3.2.0-dist/css/bootstrap-theme.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="font-awesome-4.2.0/css/font-awesome.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/luke.css" rel="stylesheet">

    <!-- Extra Template Header -->
    <%block name="extra_header">
    </%block>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

<%!
indexactive = ''
researchactive = ''
teachingactive = ''
%>

  <body>

    <%block name="full_content">
    <div class="container">
      <div class="header">
        <nav>
          <ul class="nav nav-pills pull-right">
            <li role="presentation" class="${self.attr.indexactive}"><a href="index.html">Home</a></li>
            <li role="presentation" class="${self.attr.researchactive}"><a href="research.html">Research</a></li>
            <li role="presentation" class="${self.attr.teachingactive}"><a href="teaching.html">Teaching</a></li>
          </ul>
        </nav>
        <h3 class="text-muted">Luke Olson</h3>
      </div>
    </div>

    <%block name="content">
    </%block>
    </%block>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="../../dist/js/bootstrap.min.js"></script>

    <!-- GA -->
    <script>
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

      ga('create', 'UA-58391309-1', 'auto');
      ga('send', 'pageview');

    </script>

    <!-- Template JS -->
    <%block name="extra_scripts">
    </%block>
  </body>
</html>
