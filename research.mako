<%inherit file="base.mako"/>

<%block name="extra_header">
</%block>

<%block name="title">
  Luke Olson @ Illinois
</%block>

<%block name="full_content">

<%
import makebib
pubs = makebib.generate_pubs('refs.bib')
%>

  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="well">
          <p class="lead">
            I am Luke Olson
          </p>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <ul class="fa-ul bibliography">
          %for entry in pubs:
            <li><i class="fa-li fa fa-square"></i>
              ${entry["html"]}
              <br/>
              <span class="bibtex">[<a style="cursor:pointer;" title="Show BibTeX entry"><i class="fa fa-toggle-on fa-3x"></i> BibTeX</a>]
                <div class="bibtex-body" style="display:none">
                  <pre>
${entry["bibtex"]}
                  </pre>
                </div>
              </span>
              &nbsp;
              %if "pdf" in entry:
                <a href="${entry["pdf"]}"><i class="fa fa-file-pdf-o fa-3x"></i>PDF</a>
              %endif
            </li>
          %endfor
        </ul>
      </div>
    </div>
  </div>


  <%block name="extra_scripts">
    <script>
      $('.bibtex').click(function(){
        $('> .bibtex-body', this).toggle();
      })
    </script>
  </%block>
</%block>
