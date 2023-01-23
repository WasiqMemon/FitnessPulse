<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="FitnessPulse_Web.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlacetab" runat="server">
    Dashboard
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlacetitle" runat="server">
    Dashboard
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<form runat="server">
<div class="row">
    <div class="col-sm-8">
        
        <div class="card card-default">
            
            <div class="card-header">
                <h2>New Members</h2>
                    <br />
                </div>
            <div class="card-body">
                    <asp:GridView ID="GridView1" runat="server" class="table table-bordered"></asp:GridView>
            </div>
            </div>
          </div>

    <div class="col-sm-4">
            <!-- PieChart -->
            <asp:HiddenField ID="male" runat="server"/>
            <div class="card card-default">
              <div class="card-header">
                <h2>Gender Distribution</h2>
              </div>
              <div class="card-body">
                  <div id="piechart" style="width: 300px; height: 285px;"></div>
              </div>

              </div>
            </div>
    </div>

    </form>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', { 'packages': ['corechart'] });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = new google.visualization.DataTable();
            var mal = document.getElementById('ContentPlaceHolder1_male').Value;
            var s = parseInt(mal);
            
            data.addColumn('string', 'Genderr');
            data.addColumn('number', 'Total Members');
            data.addRows([
                ['Male', <%=pb1%>],
                ['Female', <%=pb2%>],
                ['Others', 0],
            ]);

            var options = {
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart'));

            chart.draw(data, options);
        }
    </script>
    
</asp:Content>

