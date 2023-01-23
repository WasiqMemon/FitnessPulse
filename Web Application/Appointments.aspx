<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Appointments.aspx.cs" Inherits="FitnessPulse_Web.Appointments" %>

<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlacetab" runat="server">
    Appointments
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlacetitle" runat="server">
    Appointments
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <form runat="server">
     <div class ="row">
         <div class ="col-6">
             <h2>Appointments by Day</h2>
         </div>
         <div class ="col">
             <asp:DropDownList ID="aptday" runat="server" class="form-control" AutoPostBack="true">  
                                            <asp:ListItem >Select Day</asp:ListItem>  
                                            <asp:ListItem>Monday</asp:ListItem>  
                                            <asp:ListItem>Tuesday</asp:ListItem>  
                                            <asp:ListItem>Wednesday</asp:ListItem>
                                            <asp:ListItem>Thursday</asp:ListItem>  
                                            <asp:ListItem>Friday</asp:ListItem>
                                            <asp:ListItem>Saturday</asp:ListItem>  
                                            <asp:ListItem>Sunday</asp:ListItem>  
                                        </asp:DropDownList>  
         </div>

     </div>
     <br /><br />
    <div class ="card-default">
        <div class="card-body">
    <asp:GridView ID="GridView4" runat="server" class="table table-bordered" DataKeyNames="Slotid" AutoGenerateColumns="true" AutoGenerateSelectButton="true" OnSelectedIndexChanged="GridView4_SelectedIndexChanged"></asp:GridView>
        
        </div>
    </div>
     <asp:GridView ID="GridView5" runat="server" class="table table-bordered"></asp:GridView>
        </form>
    <br />
    
</asp:Content>

