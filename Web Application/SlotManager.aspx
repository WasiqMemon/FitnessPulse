<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="SlotManager.aspx.cs" Inherits="FitnessPulse_Web.SlotManager" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlacetab" runat="server">
    Slots
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlacetitle" runat="server">
    Slot Management
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<form runat="server">
<div class="card card-default">
            <div class="card-header">
                <h2>Add new Slots;</h2>
            </div>
            <div class="card-body">
                
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="PST">Start Time:</label>
                                <input id="pst" type="time" runat="server" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="PET">Ending Time</label>
                                <input id="pet" type="time" runat="server" class="form-control">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label for="cpty">Capacity:</label>
                                <input id="cpcty" type="text" class="form-control" runat="server" placeholder="Max. people allowed...">
                            </div>
                        </div>
                        <div class="form_group col-md-4">  
                            <label for="day">Day:</label>                
                            <asp:DropDownList ID="day" runat="server" class="form-control">  
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
                    <div class="form-footer pt-5 border-top">
                        <label class="text-danger" runat="server" id = "caution"></label>
                        <br />
                        <asp:Button runat="server" ID="btnAdd" Text="Add" CssClass="btn btn-primary btn-pill" OnClick="btnAdd_Click"/>
                                        
                    </div>
                
            </div>
        </div>
    <div class="card card-default">
        <div class="card-header">
            <div class="row">
                <div class="col">
                     <h2>Slots Table</h2> 
                </div>
            <div class="col">
            <asp:DropDownList ID="selectday" runat="server" class="form-control" AutoPostBack="True" OnSelectedIndexChanged="selectday_SelectedIndexChanged">  
                                            <asp:ListItem Text = "Select Day"></asp:ListItem>                                                        
                                            <asp:ListItem Text = "Monday"></asp:ListItem>  
                                            <asp:ListItem Text = "Tuesday"></asp:ListItem>  
                                            <asp:ListItem Text = "Wednesday"></asp:ListItem>
                                            <asp:ListItem Text = "Thursday"></asp:ListItem>  
                                            <asp:ListItem Text = "Friday"></asp:ListItem>
                                            <asp:ListItem Text = "Saturday"></asp:ListItem>  
                                            <asp:ListItem Text = "Sunday"></asp:ListItem>  
                                        </asp:DropDownList>  
            </div>
            </div>
            </div>
            <div class="card-body">
        
            <asp:GridView ID="GridView2" runat="server" class="table table-bordered" AutoGenerateColumns="false" DataKeyNames="Slotid" OnRowDeleting="GridView2_RowDeleting">
                <Columns>  
                    <asp:BoundField DataField="StartTime" HeaderText="Start Time"/>
                    <asp:BoundField DataField="EndTime" HeaderText="End Time" />
                    <asp:BoundField DataField="Capacity" HeaderText="Capacity" />
                    <asp:CommandField HeaderText="Delete" ShowDeleteButton="True" />  
                </Columns>
            </asp:GridView>
            </div>
            </div>
</form>

</asp:Content>


