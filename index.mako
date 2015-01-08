<%inherit file="base.mako"/>

<%block name="extra_header">
</%block>

<%block name="title">
  Luke Olson @ Illinois
</%block>

<%!
indexactive = 'active'
%>

<%block name="content">

  <div class="container">
    <div class="row">
      <div class="col-md-8">
        <ul class="list-unstyled">
        <li>Luke Olson</li>
        <li>Associate Professor</li>
        <li><a href="http://scicomp.cs.illinois.edu/">Scientific Computing Group</a></li>
        <li><a href="http://cs.illinois.edu/">Department of Computer Science</a></li>
        <li><a href="http://illinois.edu/">University of Illinois at Urbana-Champaign</a></li>
        </ul>
        <ul class="fa-ul">
        <li><i class="fa-li fa fa-envelope"></i>lukeo <i class="fa fa-at"></i> illinois.edu</dd></li>
        <li><i class="fa-li fa fa-thumbs-up"></i>4312 Siebel Center</dd></li>
        <li><i class="fa-li fa fa-phone"></i>217-244-8422 (x4-8422)</dd></li>
        <li><i class="fa-li fa fa-university"></i><p>Siebel Center for Computer Science<br/>
                  University of Illinois at Urbana-Champaign<br/>
                  201 N. Goodwin Ave.<br/>
                  Urbana , IL 61801<br/>
                  USA<br/></p></li>
        </ul>
      </div>
      <div class="col-md-4">
        <img src="./images/luke-olson.jpeg" class="img-responsive" alt="index image">
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="topline"></div>
        <h4 class="text-muted">Quick Info</h4>
        <p>Learn more about my <b>reserach</b> in sparse matrix computations, finite elements, and high performance computing
           <a href="research.html">HERE</a>.
        </p>
        <p>Current course that I am <b>teaching</b> are
            <ul class="fa-ul">
          <li><i class="fa-li fa fa-archive"></i><a href="http://lukeo.cs.illinois.edu/cs555/">Spring 2015: CS555: Numerical Methods for PDEs</a></li>
          <li><i class="fa-li fa fa-archive"></i><a href="http://lukeo.cs.illinois.edu/cs556/">Fall 2014: CS556: Iterative and multigrid methods</a></li>
            </ul>
        </p>
        <p>
        I'm currently involved with the following <b>activities</b>; contact me if you want to know more!
            <ul class="fa-ul">
          <li><i class="fa-li fa fa-users"></i>Organizing Committee, <a href="http://www.siam.org/meetings/cse15/">SIAM Conference on Computational Science and Engineering</a>, 2015</li>
          <li><i class="fa-li fa fa-users"></i>Organizing Committee, <a href="http://grandmaster.colorado.edu/~copper/2015">Eighteenth Copper Mountain Conference on Multigrid Methods</a>, 2015</li>
          <li><i class="fa-li fa fa-users"></i><a href="http://siam.cs.illinois.edu">SIAM Student Chapter at Illinois</a></li>
          <li><i class="fa-li fa fa-users"></i><a href="http://cse.illinois.edu">Computational Science and Engineering (CSE) program at Illinois</a></li>
            </ul>
        </p>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="topline"></div>
        <h4 class="text-muted">About</h4>
        <p>
        Background:
        <ul class="square">
          <li>Associate Professor, Department of Computer Science, University of Illinois at Urbana-Champaign, 2011-present</li>
          <li>Visiting Affiliate, Institute for Mathematics and Its Applications, University of Minnesota, 2011 (fall)</li>
          <li>Affiliate Faculty, <a href="http://mechse.illinois.edu/">Department of Mechanical Science and Engineering</a>, University of Illinois at Urbana-Champaign, 2010-present</li>
          <li>Assistant Professor, Department of Computer Science, University of Illinois at Urbana-Champaign, 2005-2011</li>
          <li>Visiting Assistant Professor/NSF VIGRE Postdoctoral Fellow, Division of Applied Mathematics, Brown University, 2003-2005</li>
        </ul>
        </p>
        <p>
        Education:
        <ul class="square">
          <li>PhD (2003), Applied Mathematics, University of Colorado at Boulder</li>
            <ul>
              <li>Thesis: <em>Multilevel Least-Squares Finite Element Methods for Hyperbolic PDEs</em></li>
              <li>Advisors: Tom Manteuffel, Steve McCormick</li>
            </ul>
          <li>MS (1999), Mathematics (Applied), University of Iowa</li>
            <ul>
              <li>Areas: <em>PDEs, ODEs, Optimization, Numerical Analysis</em></li>
            </ul>
            <li>BA (1997), Physics and Mathematics, Luther College</li>
        </ul>
        </p>
      </div>
    </div>
  </div>

  <%block name="extra_scripts">
  </%block>
</%block>
