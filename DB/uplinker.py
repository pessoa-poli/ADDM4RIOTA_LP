
import anvil.server
import mysql.connector


mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="ADDM4RIOTA"
    )
mycursor = mydb.cursor()

anvil.server.connect("MO5EU2C2RI4KEAEJEX7PDP6W-7EHOFIIFZZH76HOQ")

@anvil.server.callable
def say_hello(name):
  print("Hello from the uplink, %s!" % name)

@anvil.server.callable
def getDevices():
    mycursor.execute("SELECT * FROM iot_critical_object")
    return mycursor.fetchall()

@anvil.server.callable
def getThreats():
    mycursor.execute("SELECT * FROM threat_type")
    return  mycursor.fetchall()

@anvil.server.callable
def getResilientSolutions():
    mycursor.execute("SELECT * FROM resilient_solution")
    return [{'id':obj[0],'resilient_solution_id':obj[1],'name':obj[2],'description':obj[3]} for obj in mycursor.fetchall()]

@anvil.server.callable
def getAllThreatTypes():
    mycursor.execute("select * from threat_type_enum")
    return mycursor.fetchall()

@anvil.server.callable
def getAllSolutionTypes():
    mycursor.execute("select * from resilient_solution_enum")
    return mycursor.fetchall()

@anvil.server.callable
def getAllIoTObjectsDropdown():
    mycursor.execute("select * from iot_critical_object")
    return [(obj[1]+" - ("+obj[2]+")",obj[0]) for obj in mycursor.fetchall()]

@anvil.server.callable
def getAllThreatTypesDropdown():
    mycursor.execute("select * from threat_type_enum")
    return [(obj[1] + ' - (' + obj[2]+")",obj[0]) for obj in mycursor.fetchall()]

@anvil.server.callable
def getAllSolutionTypesDropdown():
    mycursor.execute("select * from resilient_solution_enum")
    return [(obj[1] + ' - (' + obj[2]+")",obj[0]) for obj in  mycursor.fetchall()]

anvil.server.wait_forever()