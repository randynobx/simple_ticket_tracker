# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' },  { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel',  city: cities.first)

accounts = Account.create([{id:0, category:"Client", name:"John Doe", business:"", phone:"(555) 555-5555", email:"user@dom.com", address:"", city:null, state:null, zip:null, notes:"My first dummy user."}, {id:1, category:"Client", name:"Joe Smith", business:"Retail", phone:"(555) 666-6666", email:"", address:"123 Street", city:"Big City", state:"NC", zip:"12345", notes:"Business dummy customer"}, {id:2, category:"Vendor", name:"Vendor #1", business:"Supplier", phone:"(555) 222-3334", email:"vendor@supply.com", address:"PO 345", city:"Anytown", state:"ST", zip:"55555", notes:"Some test notes."}])

tickets = Ticket.create([{id:0, date:"2015-02-01", account_id:0, service_id:0, materialslist:"", materialscost:"0.0", labor:"50.0", total:"50.0", closed:true, worklog:"General consulting"}, {id:1, date:"2015-02-03", account_id:0, service_id:0, materialslist:"", materialscost:"0.0", labor:"100.0", total:"100.0", closed:true, worklog:"2 hours general consulting"}, {id:2, date:"2015-02-04", account_id:1, service_id:1, materialslist:"", materialscost:"0.0", labor:"60.0", total:"60.0", closed:false, worklog:"Performed Service 1. Some more details. Yada yada."}, {id:4, date:"2015-02-07", account_id:0, service_id:0, materialslist:"", materialscost:"0.0", labor:"100.0", total:"100.0", closed:true, worklog:""}])

services = Service.create([{id:0, category:"Consulting", price:"50.0", rate:"Hourly"}, {id:1, category:"Service 1", price:"60.0", rate:"Flat"}])

records = Record.create([{id:0, date:"2015-02-04", account_id:0, ticket_id:0, notes:"", settled:true, income:"60.0", expense:"0.0", total:"60.0"}, {id:1, date:"2015-02-04", account_id:0, ticket_id:1, notes:"", settled:false, income:"20.0", expense:"20.0", total:"0.0"}, {id:4, date:"2015-02-05", account_id:1, ticket_id:2, notes:"", settled:true, income:"80.0", expense:"0.0", total:"80.0"}, {id:5, date:"2015-02-07", account_id:0, ticket_id:4, notes:"", settled:true, income:"100.0", expense:"0.0", total:"100.0"}])