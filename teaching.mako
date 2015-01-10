<%inherit file="base.mako"/>

<%block name="extra_header">
</%block>

<%block name="title">
  Luke Olson @ Illinois - Teaching
</%block>

<%!
teachingactive = 'active'
%>

<%block name="content">

<%
import yaml
from codecs import open
with open("courses.yml", "rt", encoding="utf-8") as inf:
  courses = yaml.load(inf)
  courses = courses[1:]
%>

  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <h4 class="text-muted">Courses</h4>
        <table class="table table-hover">
        <thead><tr> <th>Term</th> <th>Course</th> <th>Institution</th> </tr></thead>
        <tbody>
        %for course in courses:
            <tr>
            <td>${course["year"]} </td>
            <td>
            %if course.get("url"):
              <a href="${course["url"]}">${course["course"]}</a>
            %else:
              ${course["course"]}
            %endif
            </td>
            <td>
            %if course.get('inst'):
              (${course["inst"]})
            %endif
            </td>
            </tr>
        %endfor
        </tbody>
    </table>
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
