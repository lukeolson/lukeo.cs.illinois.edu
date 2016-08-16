<%inherit file="base.mako"/>

<%block name="extra_header">
</%block>

<%block name="title">
  Luke Olson @ Illinois - Research
</%block>

<%!
researchactive = 'active'
%>

<%block name="content">

<%
import os.path

import makebib
pubs = makebib.generate_pubs('refs.bib')

import yaml
from codecs import open
with open("students.yml", "rt", encoding="utf-8") as inf:
  students = yaml.load(inf)

with open("resimg.yml", "rt", encoding="utf-8") as inf:
  resimg = yaml.load(inf)
%>

  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <h4 class="text-muted">Summary </h4>
        <div class="row">
          <div class="col-md-6">
            Research Focus:
            <ul class="fa-ul">
              <li><i class="fa-li fa fa-cogs"></i>Multigrid methods</li>
              <li><i class="fa-li fa fa-cogs"></i>Sparse matrix computations</li>
              <li><i class="fa-li fa fa-cogs"></i>Finite element methods</li>
              <li><i class="fa-li fa fa-cogs"></i>High performance computing</li>
              <li><i class="fa-li fa fa-cogs"></i>Scalable solvers on GPUs, large-scale systems</li>
            </ul>
          </div>
          <div class="col-md-6">
            Jump to:
            <ul class="list-group">
              <a href="research.html#students" class="list-group-item">Students</a>
              <a href="research.html#publications" class="list-group-item">Publications</a>
              <a href="research.html#images" class="list-group-item">Research images</a>
            </ul>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="topline"></div>
        <h4 class="text-muted" id="students">Students</h4>
        <% counter = 0 %>
        %for s in students:
          <%
          if s["category"] not in ['current']:
            continue
          name = s["name"]
          %>
          %if counter == 0:
            <div class="row">
          %elif counter % 3 == 0:
            </div>
            <div class="row">
          %endif
          <% counter += 1 %>
          <div class="col-md-4">
            <div style="height: 150px">
              %if s.get("url"):
                <a href="${s["url"]}">
              %endif
              %if s.get("image"):
                <img src="images/${s["image"]}" alt="${s["name"]}" height="150" class="img-rounded">
              %else:
                <img src="images/headshot.png" alt="${s["name"]}" height="150" class="img-rounded">
              %endif
              %if s.get("url"):
                </a>
              %endif
            </div>
            <span class="student-name">
            %if s.get("url"):
              <a href="${s["url"]}">${name}<i class="fa fa-external-link" style="padding-left: 5px;"></i></a>
            %else:
              ${name}
            %endif
            </span>
            %if s.get("dept"):
              (${s["dept"]})
            %endif
            %if s.get("blurb"):
              <p>${s["blurb"]}</p>
            %endif
          </div>
        %endfor
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="topline"></div>
        <h4 class="text-muted">Former Students</h4>
        <ul class="fa-ul">
        %for s in students:
          <%
          if s["category"] not in ['former']:
              continue
          name = s["name"]
          %>
          <li>
          %if s.get("url"):
            <a href="${s["url"]}">${name}<i class="fa fa-external-link" style="padding-left: 5px;"></i></a>,
          %else:
            ${name},
          %endif
          ${s["degree"]}, ${s["year"]}
          %if s.get("dept"):
            (${s["dept"]})
          %endif
          %if s.get("blurb") or s.get("thesis"):
            <ul>
              %if s.get("thesis"):
                %if not s.get("thesisurl"):
                  <li>${s["thesis"]}</li>
                %else:
                  <li>Thesis: <a href="${s["thesisurl"]}">${s["thesis"]}<i class="fa fa-external-link" style="padding-left: 5px;"></i></a></li>
                %endif
              %endif
              %if s.get("blurb"):
                <li>${s["blurb"]}</li>
              %endif
            </ul>
          %endif
          </li>
        %endfor
      </ul>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="topline"></div>
        <h4 class="text-muted" id="publications">Publications</h4>
        <ul class="fa-ul bibliography">
          %for entry in pubs:
              <li><a href="#${entry["id"]}"><i id = "${entry["id"]}" class="fa-li fa fa-caret-right"></i></a>
              ${entry["html"]}
              <br/>
              <span class="bibtex">
                <a style="cursor:pointer;" title="Show BibTeX entry"><i class="fa fa-toggle-on"></i> BibTeX</a>
              <div class="bibtex-body" style="display:none">
                <pre>
${entry["bibtex"]}
                </pre>
              </div>
              </span>
              %if "pdf" in entry:
                &nbsp;
                <a href="${entry["pdf"]}"><i class="fa fa-file-pdf-o"></i>PDF</a>
              %else:
                <%
                pdfpath = './files/' + entry["id"] + '.pdf'
                pdfexists = os.path.exists('./live/' + pdfpath)
                %>
                %if pdfexists:
                  &nbsp;
                  <a href="${pdfpath}"><i class="fa fa-file-pdf-o"></i>PDF</a>
                %else:
                %endif
              %endif
              %if "doi" in entry:
                &nbsp;
                <a href="http://doi.org/${entry["doi"]}"><i class="fa fa-external-link"></i>DOI: ${entry["doi"]}</a>
              %endif
              %if "url" in entry:
                &nbsp;
                <a href="${entry["url"]}"><i class="fa fa-external-link-square"></i>URL</a>
              %endif
            </li>
          %endfor
        </ul>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="topline"></div>
        <h4 class="text-muted" id="images">Some Images</h4>
        <% counter = 0 %>
        %for res in resimg:
          %if counter == 0:
            <div class="row">
          %elif counter % 3 == 0:
            </div>
            <div class="row">
          %endif
          <% counter += 1 %>
          <div class="col-md-4">
            <div style="height: 200px">
              <img src="${res["image"]}" alt="${res["title"]}" height="200" class="img-rounded">
            </div>
            <span class="resimg">
              ${res["title"]}: ${res["desc"]}
            </span>
          </div>
        %endfor
      </div>
    </div>
  </div>


  <%block name="extra_scripts">
    <script>
      $('.bibtex').click(function(){
        $('> .bibtex-body', this).show();
      })
    </script>
  </%block>

</%block>
